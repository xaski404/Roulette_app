import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../widgets/spinning_wheel.dart';
import '../widgets/roulette_wheel.dart';
import '../widgets/winner_banner.dart';
import '../services/party/party_service.dart';
import '../services/party/party_item.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';

class PartyGameScreen extends StatefulWidget {
  final String gameCategory; // e.g. 'klasyczna', 'dla par', 'imprezowa'

  const PartyGameScreen({super.key, required this.gameCategory});

  @override
  State<PartyGameScreen> createState() => _PartyGameScreenState();
}

class _PartyGameScreenState extends State<PartyGameScreen> {
  final GlobalKey<SpinningWheelState> _wheelKey = GlobalKey<SpinningWheelState>();
  final PartyService _partyService = PartyService();
  late final ConfettiController _confetti;
  final RouletteController _rouletteController = RouletteController();

  List<String> players = [];
  bool _isBusy = false;
  String? _lastWinnerName;
  int? _lastWinnerIndex;

  // Lokalna pula pytań/wyzwań (fallback/offline)
  static final Map<String, Map<String, List<String>>> _localPartyItems = {
    'klasyczna': {
      'pytanie': [
        'Co ostatnio sprawiło Ci największą radość?',
        'Jaka była Twoja najlepsza decyzja w tym roku?',
      ],
      'wyzwanie': [
        'Pokaż ostatnie zdjęcie ze swojej galerii i opowiedz o nim.',
        'Zrób 10 przysiadów i uśmiechaj się do kamery.',
      ],
    },
    'dla par': {
      'pytanie': [
        'Jaki macie wspólny rytuał, który najbardziej lubisz?',
        'Za co dziś najbardziej cenisz swojego partnera/partnerkę?',
      ],
      'wyzwanie': [
        'Weź do swojego chłopaka wszystkie misie którego od niego dostałaś.',
        'Weź do swojego chłopaka wszystkie misie którego od niego dostałaś.',
      ],
    },
    'imprezowa': {
      'pytanie': [
        'Jaka była najzabawniejsza sytuacja na imprezie, w której brałeś/aś udział?',
      ],
      'wyzwanie': [
        'Zatańcz przez 15 sekund tak, jakby nikt nie patrzył.',
        'Zrób selfie z 3 osobami obok Ciebie.',
      ],
    },
  };

  String? _getLocalRandom({required String type, required String category}) {
    final list = _localPartyItems[category]?[type] ?? const [];
    if (list.isEmpty) return null;
    final idx = Random().nextInt(list.length);
    return list[idx];
  }

  Widget _buildEmojifiedContent({required String text, required String type, required ColorScheme cs}) {
    final String bullet = type == 'wyzwanie' ? '💪' : '❓';
    // Prefer explicit line breaks, otherwise split into short sentences
    final List<String> rawLines = text.contains('\n')
        ? text.split('\n')
        : text.split(RegExp(r'[\.\!\?]+')).map((s) => s.trim()).toList();
    final lines = rawLines.where((s) => s.isNotEmpty).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < lines.length; i++) ...[
          Text(
            '$bullet  ${lines[i]}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: cs.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 1.35,
            ),
          ),
          if (i != lines.length - 1) const SizedBox(height: 6),
        ],
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _confetti = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  Future<void> _seedSampleItems() async {
    setState(() => _isBusy = true);
    try {
      await _partyService.addPartyItemsBatch([
        {
          'content': 'Opisz swój idealny dzień w trzech zdaniach.',
          'type': 'pytanie',
          'gameCategory': 'klasyczna',
          'language': 'pl',
        },
        {
          'content': 'Pokaż ostatnie zdjęcie ze swojej galerii i opowiedz o nim.',
          'type': 'wyzwanie',
          'gameCategory': 'klasyczna',
          'language': 'pl',
        },
        {
          'content': 'Zaśpiewaj refren pierwszej piosenki, która przyjdzie Ci do głowy.',
          'type': 'wyzwanie',
          'gameCategory': 'imprezowa',
          'language': 'pl',
        },
        {
          'content': 'Co ostatnio sprawiło Ci największą radość?',
          'type': 'pytanie',
          'gameCategory': 'klasyczna',
          'language': 'pl',
        },
        {
          'content': 'Weź do swojego chłopaka wszystkie misie którego od niego dostałaś.',
          'type': 'pytanie',
          'gameCategory': 'dla par',
          'language': 'pl',
        },
        {
          'content': 'Zatańcz przez 15 sekund tak, jakby nikt nie patrzył.',
          'type': 'wyzwanie',
          'gameCategory': 'imprezowa',
          'language': 'pl',
        },
        {
          'content': 'Weź do swojego chłopaka wszystkie misie którego od niego dostałaś.',
          'type': 'wyzwanie',
          'gameCategory': 'dla par',
          'language': 'pl',
        },
        {
          'content': 'Jaką najdziwniejszą rzecz kiedykolwiek zjadłeś/zjadłaś?',
          'type': 'pytanie',
          'gameCategory': 'klasyczna',
          'language': 'pl',
        },
      ]);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dodano przykładowe pytania i wyzwania.')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Błąd dodawania: $e')),
      );
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _openPlayersConfigurator() async {
    final result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) => _PlayersConfigurator(initialPlayers: players),
    );

    if (result != null) {
      setState(() {
        players = result;
      });
    }
  }

  Future<void> _handleAction(String type) async {
    if (players.isEmpty || _isBusy) return;
    setState(() => _isBusy = true);

    try {
      HapticFeedback.selectionClick();
      // 1) Spin roulette wheel with ball (deterministic index)
      final int idx = (players.isEmpty) ? 0 : (players.length == 1 ? 0 : DateTime.now().millisecondsSinceEpoch % players.length);
      await _rouletteController.spinTo(idx);
      _lastWinnerName = players[idx];

      // 2) Pobierz treść lokalnie (bez Firestore)
      final String? local = _getLocalRandom(type: type, category: widget.gameCategory);

      if (!mounted) return;
      HapticFeedback.lightImpact();
      _confetti.play();
      await showDialog(
        context: context,
        builder: (context) {
          final cs = Theme.of(context).colorScheme;
          return AlertDialog(
            title: Text(
              type == 'pytanie' ? 'Pytanie dla: ${_lastWinnerName!}' : 'Wyzwanie dla: ${_lastWinnerName!}',
            ),
            content: SingleChildScrollView(
              child: _buildEmojifiedContent(
                text: local ?? 'Brak zadań dla wybranych kryteriów.',
                type: type,
                cs: cs,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    String modeTitle;
    switch (widget.gameCategory) {
      case 'dla par':
        modeTitle = 'Dla Par';
        break;
      case 'imprezowa':
        modeTitle = 'Imprezowa';
        break;
      case 'klasyczna':
      default:
        modeTitle = 'Klasyczna Gra';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(modeTitle),
        actions: [
          IconButton(
            tooltip: 'Dodaj przykładowe pytania/wyzwania',
            icon: const Icon(Icons.cloud_upload),
            onPressed: _isBusy ? null : _seedSampleItems,
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (players.isEmpty) ...[
                  // Decorative faint wheel background (same visual as game wheel)
                  Opacity(
                    opacity: 0.12,
                    child: IgnorePointer(
                      child: SizedBox(
                        width: 260,
                        height: 260,
                        child: RouletteWheel(
                          segments: const [
                            RouletteSegment(label: 'A', color: Colors.cyan),
                            RouletteSegment(label: 'B', color: Colors.pinkAccent),
                            RouletteSegment(label: 'C', color: Colors.amber),
                            RouletteSegment(label: 'D', color: Colors.redAccent),
                            RouletteSegment(label: 'E', color: Colors.deepPurpleAccent),
                            RouletteSegment(label: 'F', color: Colors.tealAccent),
                          ],
                          controller: RouletteController(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          modeTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colorScheme.onBackground,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.group_add),
                          label: const Text('+ Skonfiguruj Graczy'),
                          onPressed: _openPlayersConfigurator,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Dodaj od 2 do 8 graczy, aby rozpocząć zabawę!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colorScheme.onBackground.withOpacity(0.7),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: RouletteWheel(
                      segments: List.generate(
                        players.length,
                        (i) => RouletteSegment(
                          label: players[i],
                          color: [
                            Colors.cyan,
                            Colors.pinkAccent,
                            Colors.amber,
                            Colors.redAccent,
                            Colors.deepPurpleAccent,
                            Colors.tealAccent,
                          ][i % 6],
                        ),
                      ),
                      controller: _rouletteController,
                      onCompleted: (i) {
                        setState(() => _lastWinnerName = players[i]);
                      },
                    ),
                  ),
                  // Banner wyniku – tuż pod kołem, nad przyciskami
                  WinnerBanner(winnerName: _lastWinnerName),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BFA5),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 3,
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                        ),
                        onPressed: _isBusy ? null : () => _handleAction('pytanie'),
                        child: const Text('Pytanie'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BFA5),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          elevation: 3,
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                        ),
                        onPressed: _isBusy ? null : () => _handleAction('wyzwanie'),
                        child: const Text('Wyzwanie'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: _isBusy ? null : _openPlayersConfigurator,
                    icon: const Icon(Icons.edit, color: Color(0xFF00BFA5)),
                    label: const Text('Edytuj graczy', style: TextStyle(color: Color(0xFF00BFA5))),
                  ),
                ],
              ],
            ),
          ),
          Positioned(
            top: 0,
            child: ConfettiWidget(
              confettiController: _confetti,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [Colors.amber, Colors.pinkAccent, Colors.cyanAccent, Colors.limeAccent],
              gravity: 0.9,
              emissionFrequency: 0.02,
              numberOfParticles: 25,
              maxBlastForce: 20,
              minBlastForce: 5,
            ),
          ),
        ],
        ),
      ),
    );
  }
}

class _PlayersConfigurator extends StatefulWidget {
  final List<String> initialPlayers;
  const _PlayersConfigurator({required this.initialPlayers});

  @override
  State<_PlayersConfigurator> createState() => _PlayersConfiguratorState();
}

class _PlayersConfiguratorState extends State<_PlayersConfigurator> {
  final TextEditingController _controller = TextEditingController();
  late List<String> _players;

  @override
  void initState() {
    super.initState();
    _players = [...widget.initialPlayers];
  }

  void _addPlayer() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _players.add(text);
      _controller.clear();
    });
  }

  void _removeAt(int index) {
    setState(() {
      _players.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: isDark ? null : Border.all(color: Colors.black12),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Imię gracza',
                      ),
                      onSubmitted: (_) => _addPlayer(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addPlayer,
                    child: const Text('Dodaj'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (int i = 0; i < _players.length; i++)
                    Chip(
                      label: Text(_players[i]),
                      onDeleted: () => _removeAt(i),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(widget.initialPlayers),
                    child: const Text('Anuluj'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _players.isEmpty
                        ? null
                        : () => Navigator.of(context).pop(_players),
                    child: const Text('Graj!'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


