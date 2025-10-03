import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../widgets/spinning_wheel.dart';
import '../widgets/roulette_wheel.dart';
import '../widgets/winner_banner.dart';
import '../widgets/challenge_dialog.dart';
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
  Color? _winnerAccentColor;
  bool _isDialogVisible = false;

  // Lokalna pula pytań/wyzwań (fallback/offline)
  static final Map<String, Map<String, List<String>>> _localPartyItems = {
    'klasyczna': {
      'pytanie': [
        'Gdybyś mógł/mogła do końca życia słuchać tylko jednej piosenki, która by to była i dlaczego?',
        'Jaka jest najbardziej bezużyteczna supermoc, jaką chciałbyś/chciałabyś mieć?',
        'Opowiedz o swoim najbardziej cringe\'owym wspomnieniu z dzieciństwa.',
        'Jaki jest Twój "guilty pleasure" na YouTube albo TikToku?',
        'Gdybyś mógł/mogła zamienić się życiem z jedną postacią z serialu na tydzień, kto by to był?',
        'Co jest Twoim zdaniem najbardziej przereklamowaną rzeczą na świecie?',
        'Jaka jest najdziwniejsza plotka, jaką kiedykolwiek o sobie usłyszałeś/aś?',
        'Trzy rzeczy, które zabrałbyś/zabrałabyś na bezludną wyspę.',
        'Jaki był najgłupszy powód, dla którego pokłóciłeś/aś się ze znajomym?',
        'Gdyby Twoje życie było filmem, jaki miałoby tytuł?',
      ],
      'wyzwanie': [
        'Nagraj zabawnego TikToka z osobą po Twojej lewej stronie.',
        'Zadzwoń do kogoś z rodziny i spróbuj mu/jej sprzedać długopis, jak w filmie "Wilk z Wall Street".',
        'Przez następne 3 kolejki mów z brytyjskim akcentem.',
        'Stwórz na poczekaniu krótki rap o osobie siedzącej naprzeciwko Ciebie.',
        'Pokaż ostatnie zdjęcie, jakie zrobiłeś/aś telefonem i opowiedz jego historię.',
        'Wybierz jedną osobę z grupy i spróbuj ją rozśmieszyć w 30 sekund. Nie możesz jej dotykać.',
        'Użyj trzech losowych przedmiotów ze stołu, aby stworzyć dla nich reklamę.',
        'Wybierz piosenkę i spróbuj zaśpiewać jej refren, trzymając w ustach kostkę lodu.',
        'Opublikuj na Instagram Stories ankietę z absurdalnym pytaniem (np. "Czy w kosmosie są krewetki?").',
        'Pozwól grupie wybrać dla Ciebie jedno słowo, którego musisz użyć w każdym zdaniu do końca gry.',
      ],
    },
    'dla par': {
      'pytanie': [
        'Jaka jest moja ulubiona cecha Twojego charakteru, o której rzadko mówię?',
        'Opisz nasze pierwsze spotkanie ze swojej perspektywy. Co wtedy pomyślałaś/eś?',
        'Jaki jest Twój ulubiony wspólny moment lub wspomnienie z ostatniego roku?',
        'Gdybyśmy mogli jutro obudzić się w dowolnym miejscu na świecie, gdzie by to było?',
        'Co jest według Ciebie najzabawniejszą rzeczą, jaka nam się wspólnie przytrafiła?',
        'Czego nauczyłeś/aś się o miłości, będąc ze mną?',
        'W jakiej bieliźnie (lub jej braku) lubisz mnie najbardziej?',
        'Jaka jest jedna rzecz, którą od dawna chciałeś/aś ze mną spróbować w łóżku, ale wstydziłeś/aś się zapytać?',
        'Która część mojego ciała jest Twoim zdaniem najbardziej niedoceniana, a uwielbiasz ją?',
        'Jaki jest najbardziej seksowny komplement, jaki kiedykolwiek usłyszałeś/aś?',
        'Gdybyś mógł/mogła wybrać jedno miejsce na moim ciele, które mógłbyś/mogłabyś całować przez 5 minut, gdzie by to było?',
        'Jakie słowo lub dźwięk, który wydaję, najbardziej Cię podnieca?',
        'Wolisz dominować czy być zdominowanym/ą? A może lubisz się zamieniać?',
        'Opisz swój idealny wieczór, który kończy się seksem.',
        'Jaka piosenka najbardziej kojarzy Ci się z seksem i dlaczego?',
        'Jaki jest Twój ulubiony rodzaj pocałunku? (np. namiętny, delikatny, agresywny)',
        'Jaka jest Twoja najodważniejsza fantazja erotyczna, o której nikomu nie mówiłeś/aś?',
        'Co myślisz o lekkim związaniu rąk podczas seksu?',
        'Jakie jest najbardziej ryzykowne, publiczne miejsce, w którym chciałbyś/chciałabyś się ze mną kochać?',
        'Opisz ze szczegółami, jakbyś mnie teraz powoli rozebrał/a i doprowadził/a do orgazmu.',
        'Co sądzisz o używaniu zabawek erotycznych we dwoje?',
        'Jaka jest najbardziej niegrzeczna rzecz, o której myślałeś/aś w ciągu ostatniego tygodnia?',
        'Wolisz szybki, namiętny numerek czy długą, romantyczną sesję miłosną?',
        'Jaka pozycja seksualna jest Twoim zdaniem najbardziej niedoceniana?',
        'Co byś zrobił/a, gdybym powiedział/a, że na następną godzinę możesz zrobić ze mną absolutnie wszystko?',
        'Czy wolałbyś/wolałabyś uprawiać ze mną seks z zasłoniętymi oczami czy z moimi związanymi rękami?',
        'Jaka jest Twoja najbardziej "zakazana" lub tabu fantazja?',
        'Co myślisz o lekkich klapsach jako formie pieszczoty lub kary za niegrzeczność?',
        'Gdybyś mógł/mogła nagrać nasz wspólny film, co by się w nim działo?',
        'Czy podnieca Cię myśl o seksie w trójkącie lub obserwowaniu mnie z kimś innym? Bądź szczery/a.',
        'Jaka jest najbardziej perwersyjna rzecz, jaką chciałbyś/chciałabyś mi zrobić (lub żebym ja zrobił/a Tobie)?',
        'Co byś zrobił/a, gdybym dał/a Ci pełną kontrolę nad sobą na jedną noc? Opisz szczegółowo.',
        'Wolisz dawać czy otrzymywać przyjemność oralną?',
        'Jaki jest Twój "sygnał", po którym wiesz, że jestem blisko orgazmu?',
        'Czy podnieca Cię mówienie sprośnych rzeczy podczas seksu? Jeśli tak, co najbardziej lubisz słyszeć?',
        'Jaka jest Twoja ulubiona rzecz do robienia tuż po seksie?',
      ],
      'wyzwanie': [
        'Patrzcie sobie w oczy przez minutę bez słowa i bez śmiechu.',
        'Włączcie Waszą piosenkę i zatańczcie do niej.',
        'Powiedz swojemu partnerowi/partnerce trzy rzeczy, za które jesteś mu/jej najbardziej wdzięczny/a.',
        'Zaplanujcie na poczekaniu Waszą wymarzoną, idealną randkę, bez ograniczeń budżetowych.',
        'Zrób partnerowi/partnerce striptiz do jednej, dowolnie wybranej piosenki. Nie musi być idealny – liczy się zabawa.',
        'Wybierz trzy miejsca na ciele partnera/partnerki i obsyp je pocałunkami.',
        'Szepcz partnerowi/partnerce do ucha niegrzeczne komplementy przez 60 sekund bez przerwy.',
        'Zdejmij partnerowi/partnerce jedną część garderoby, używając tylko zębów.',
        'Zatańczcie razem bardzo blisko siebie, w powolnym, zmysłowym tańcu, nawet jeśli nie ma muzyki.',
        'Napisz na ciele partnera/partnerki palcem ukryte słowo. On/ona musi zgadnąć, co to za słowo, czując tylko dotyk.',
        'Usiądź na przeciwko siebie i opowiedzcie sobie nawzajem, co Wam się w sobie najbardziej podoba fizycznie, nie przerywając kontaktu wzrokowego.',
        'Daj partnerowi/partnerce namiętny pocałunek francuski trwający co najmniej minutę.',
        'Zrób partnerowi/partnerce zmysłowy masaż dłoni, skupiając się na każdym palcu.',
        'Pozwól partnerowi/partnerce wybrać jedną część Twojego ciała, którą sfotografuje w artystyczny, erotyczny sposób.',
        'Pozwól partnerowi/partnerce związać sobie ręce (np. szalikiem) na 5 minut. W tym czasie musisz spełniać jego/jej zmysłowe polecenia.',
        'Użyj kostki lodu (lub ciepłego olejku do masażu) i wodź nią po ciele partnera/partnerki, celowo omijając najbardziej intymne strefy.',
        'Uprawiajcie petting (pieszczoty manualne i oralne) przez 10 minut, ale z absolutnym zakazem stosunku.',
        'Odegrajcie scenkę: jedno z Was jest nieśmiałym/ą studentem/studentką, a drugie doświadczonym/ą profesorem/profesorką. Macie 5 minut na improwizację.',
        'Rozbierzcie się nawzajem do naga, ale róbcie to najwolniej, jak to tylko możliwe.',
        'Doprowadź partnera/partnerkę na skraj podniecenia, używając tylko swoich ust i języka, ale nie całując go/jej w usta ani strefy intymne.',
        'Połóż się i pozwól partnerowi/partnerce "malować" po Twoim ciele bitą śmietaną lub czekoladą, a następnie ją zlizać.',
        'Przez następne 15 minut możecie komunikować się tylko za pomocą dotyku i dźwięków, bez używania słów.',
        'Zrób partnerowi/partnerce masaż erotyczny pośladków i wewnętrznej strony ud.',
        'Obejrzyjcie razem krótki, ale gustowny film erotyczny (np. w kategorii "artistic") i komentujcie na bieżąco, co Wam się podoba.',
        'Zasłoń partnerowi/partnerce oczy i doprowadź go/ją do orgazmu, używając wszystkiego, oprócz stosunku.',
        'Usiądź na kolanach partnera/ki (w bieliźnie lub nago) i poruszaj się powoli w rytm muzyki, całując go/ją i szepcząc niegrzeczne rzeczy.',
        'Odegrajcie scenkę: jedno z Was przyłapuje drugie na masturbacji. Co dzieje się dalej?',
        'Podyktuj partnerowi/partnerce treść bardzo niegrzecznego SMS-a, którego musi do Ciebie wysłać. Przeczytaj go na głos.',
        'Przez następne 15 minut nie wolno Wam uprawiać seksu waginalnego/analnego, ale możecie robić wszystko inne, aby doprowadzić się nawzajem do granic pożądania.',
        'Pozwól partnerowi/partnerce użyć Twojego ciała jako "płótna" i namalować na nim coś szminką lub pisakiem do ciała.',
        'Spróbujcie seksu w miejscu, w którym jeszcze nigdy tego nie robiliście (np. pod prysznicem, na podłodze w kuchni, na balkonie).',
        'Przez następną rundę jedno z Was jest "panem/panią", a drugie "niewolnikiem/niewolnicą". Osoba dominująca wydaje trzy erotyczne polecenia, które druga musi spełnić bez wahania.',
        'Doprowadź partnera/partnerkę do orgazmu oralnego.',
        'Sfinalizujcie grę, kochając się w Waszej ulubionej, najbardziej namiętnej pozycji.',
      ],
    },
    'imprezowa': {
      'pytanie': [
        'Kto z tej grupy najprawdopodobniej wygrałby w reality show typu "Hotel Paradise"?',
        'Jaka jest najbardziej szalona rzecz, jaką zrobiłeś/aś dla zakładu?',
        'Opisz swoją ostatnią randkę używając tylko 3 słów.',
        'Gdybyś mógł/mogła bez konsekwencji zrobić jedną nielegalną rzecz, co by to było?',
        'Jaka piosenka jest Twoim hymnem imprezowym?',
        'Kto z obecnych ma najlepszy styl ubierania się?',
        'Najgłupszy tekst na podryw, jakiego kiedykolwiek użyłeś/aś lub słyszałeś/aś?',
        'Jaka jest Twoja najbardziej kompromitująca historia związana z alkoholem?',
        'Którą znaną osobę pocałowałbyś/pocałowałabyś bez wahania?',
        'Twoja teoria spiskowa, w którą po cichu wierzysz?',
      ],
      'wyzwanie': [
        'Zrób 10 pompek, a reszta grupy musi Ci głośno kibicować.',
        'Wybierz piosenkę i zatańcz jej refren bez muzyki, a reszta musi zgadnąć, co to za utwór.',
        'Pozwól grupie napisać Ci na czole jedno słowo (zmywalnym markerem!).',
        'Wypij shota bez użycia rąk.',
        'Wybierz dwie osoby i przez resztę gry zwracaj się do nich "mamo" i "tato".',
        'Zrób sobie selfie z najdziwniejszą miną, jaką potrafisz i ustaw je jako tapetę w telefonie na 24h.',
        'Napisz SMS-a do swojej byłej/byłego z tekstem "Tęsknię za Twoim psem/kotem". Jeśli nie masz, to do znajomego.',
        'Stań na krześle i wygłoś uroczystą przemowę na temat wyższości kotów nad psami (lub odwrotnie).',
        'Zrób "kółko prawdy" - każdy po kolei mówi jedną, szczerą, ale miłą rzecz o Tobie.',
        'Wymień się jedną częścią garderoby z osobą po prawej stronie na następne 15 minut.',
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
      
      setState(() => _isDialogVisible = true);
      await showChallengeDialog(
        context: context,
        winnerName: _lastWinnerName!,
        challengeText: local ?? 'Brak zadań dla wybranych kryteriów.',
        taskType: type == 'pytanie' ? TaskType.question : TaskType.challenge,
        accentColor: _winnerAccentColor ?? const Color(0xFF00BFA5),
        icon: type == 'pytanie' ? Icons.help_outline_rounded : Icons.local_fire_department_rounded,
        autoClose: false,
        autoCloseAfter: const Duration(seconds: 3),
      );
      setState(() => _isDialogVisible = false);
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
                          color: const [
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
                        const palette = [
                          Colors.cyan,
                          Colors.pinkAccent,
                          Colors.amber,
                          Colors.redAccent,
                          Colors.deepPurpleAccent,
                          Colors.tealAccent,
                        ];
                        setState(() {
                          _lastWinnerName = players[i];
                          _winnerAccentColor = palette[i % palette.length];
                        });
                      },
                    ),
                  ),
                  // Banner wyniku – tuż pod kołem, nad przyciskami
                  AnimatedOpacity(
                    opacity: _isDialogVisible ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: WinnerBanner(winnerName: _lastWinnerName, accentColor: _winnerAccentColor),
                  ),
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


