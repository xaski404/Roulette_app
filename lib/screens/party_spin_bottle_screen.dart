import 'dart:math';
import 'package:flutter/material.dart';
import '../services/party/party_service.dart';
import '../services/party/party_item.dart';

class PartySpinBottleScreen extends StatefulWidget {
  final String gameCategory;
  final String title;

  const PartySpinBottleScreen({super.key, required this.gameCategory, required this.title});

  @override
  State<PartySpinBottleScreen> createState() => _PartySpinBottleScreenState();
}

class _PartySpinBottleScreenState extends State<PartySpinBottleScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;
  bool _isSpinning = false;
  final PartyService _partyService = PartyService();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
    _animation = Tween<double>(begin: 0, end: 0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() { _isSpinning = false; });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleAction(String type) async {
    if (_isSpinning) return;
    setState(() { _isSpinning = true; });

    // Spin bottle to random final angle with a few full rotations
    final random = Random();
    final double fullSpins = 4.0 + random.nextInt(2).toDouble(); // 4-5 spins
    final double endAngle = fullSpins * 2 * pi + random.nextDouble() * 2 * pi;
    _animation = Tween<double>(begin: 0, end: endAngle).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller
      ..reset()
      ..forward();

    // Fetch random item in parallel while spinning
    final Future<PartyItem?> futureItem = _partyService.getRandomItem(
      type: type,
      gameCategory: widget.gameCategory,
      language: 'pl',
    );

    final PartyItem? item = await futureItem;

    // Wait until spin finishes if it hasn't yet
    if (_controller.isAnimating) {
      await _controller.forward().orCancel.catchError((_) {});
    }

    if (!mounted) return;
    if (item == null) {
      _showDialog('Brak danych', 'Nie znaleziono zadań dla wybranych kryteriów.');
    } else {
      _showDialog(type == 'pytanie' ? 'Pytanie' : 'Wyzwanie', item.content);
    }
  }

  void _showDialog(String title, String content) {
    final colorScheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colorScheme.surface,
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(angle: _animation.value, child: child);
              },
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  shape: BoxShape.circle,
                  boxShadow: isDark ? null : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Transform.rotate(
                    angle: pi / 2,
                    child: Icon(Icons.local_drink, size: 84, color: colorScheme.primary),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isSpinning ? null : () => _handleAction('pytanie'),
                  child: const Text('Pytanie'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isSpinning ? null : () => _handleAction('wyzwanie'),
                  child: const Text('Wyzwanie'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


