import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'widgets/shuffle_song_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'services/auth_service.dart';
import 'screens/food_categories_screen.dart';

// Dodaj klasę ThemeProvider
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  static const String _themeKey = 'theme_mode';

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);
    if (savedTheme != null) {
      _themeMode = ThemeMode.values.firstWhere(
        (mode) => mode.toString() == savedTheme,
        orElse: () => ThemeMode.dark,
      );
      notifyListeners();
    }
  }

  Future<void> toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, _themeMode.toString());
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
    return MaterialApp(
      title: 'Roulette',
      theme: ThemeData(
        brightness: Brightness.light,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: Brightness.light,
              primary: Colors.teal,
              secondary: Colors.tealAccent,
              surface: Colors.white,
              background: Colors.grey[50]!,
              onSurface: Colors.black87,
              onBackground: Colors.black87,
            ),
        useMaterial3: true,
            cardTheme: CardThemeData(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                  side: const BorderSide(color: Colors.black12, width: 1),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black87),
              bodyMedium: TextStyle(color: Colors.black87),
              titleLarge: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            iconTheme: const IconThemeData(
              color: Colors.black87,
              size: 32,
            ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: Brightness.dark,
              primary: Colors.teal,
              secondary: Colors.tealAccent,
              surface: const Color(0xFF151C25),
              background: const Color(0xFF0B111A),
              onSurface: Colors.white,
              onBackground: Colors.white,
            ),
        useMaterial3: true,
            cardTheme: CardThemeData(
              color: const Color(0xFF151C25),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF151C25),
                foregroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ),
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
              titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
              size: 32,
            ),
          ),
          themeMode: themeProvider.themeMode,
          home: const LoginScreen(),
        );
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _resetEmailController = TextEditingController();
  final AuthService _authService = AuthService();
  String _errorMessage = '';
  bool _isLoading = false;
  bool _isRegistering = false;

  Future<void> _handleAuth() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Proszę wypełnić wszystkie pola';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      if (_isRegistering) {
        await _authService.registerWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
      } else {
        await _authService.signInWithEmailAndPassword(
          _emailController.text,
          _passwordController.text,
        );
      }
      
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const RouletteHomePage()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().contains('user-not-found') 
            ? 'Użytkownik nie istnieje'
            : e.toString().contains('wrong-password')
                ? 'Nieprawidłowe hasło'
                : e.toString().contains('email-already-in-use')
                    ? 'Email jest już używany'
                    : 'Wystąpił błąd podczas logowania';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      await _authService.signInWithGoogle();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const RouletteHomePage()),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _showResetPasswordDialog() async {
    _resetEmailController.text = _emailController.text; // Pre-fill with current email if any
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Resetowanie hasła'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Wprowadź swój adres email, a wyślemy Ci link do resetowania hasła.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _resetEmailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Anuluj'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_resetEmailController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Proszę wprowadzić adres email')),
                  );
                  return;
                }

                try {
                  await _authService.resetPassword(_resetEmailController.text);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Link do resetowania hasła został wysłany na podany adres email'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Błąd: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text('Wyślij'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = colorScheme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: isDark ? null : Border.all(color: Colors.black12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      themeProvider.themeMode == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: colorScheme.onSurface,
                    ),
                    onPressed: () => themeProvider.toggleTheme(),
                  ),
                ],
              ),
              Text(
                _isRegistering ? 'Rejestracja' : 'Logowanie',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                style: TextStyle(color: colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.2)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: colorScheme.onSurface),
                decoration: InputDecoration(
                  hintText: 'Hasło',
                  hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.onSurface.withOpacity(0.2)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: colorScheme.primary),
                  ),
                ),
              ),
              if (!_isRegistering) // Show only on login screen
                TextButton(
                  onPressed: _isLoading ? null : _showResetPasswordDialog,
                  child: Text(
                    'Zapomniałeś hasła?',
                    style: TextStyle(
                      color: colorScheme.primary,
                      fontSize: 12,
                    ),
                  ),
                ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: colorScheme.error),
                  ),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(
                      color: isDark ? Colors.transparent : Colors.black12,
                      width: 1,
                    ),
                  ),
                ),
                onPressed: _isLoading ? null : _handleAuth,
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(_isRegistering ? 'Zarejestruj się' : 'Zaloguj się'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        setState(() {
                          _isRegistering = !_isRegistering;
                          _errorMessage = '';
                        });
                      },
                child: Text(
                  _isRegistering
                      ? 'Masz już konto? Zaloguj się'
                      : 'Nie masz konta? Zarejestruj się',
                  style: TextStyle(color: colorScheme.primary),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'lub',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                icon: Image.network(
                  'https://www.google.com/favicon.ico',
                  height: 24,
                ),
                label: const Text('Zaloguj się przez Google'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? colorScheme.surface : Colors.white,
                  foregroundColor: isDark ? Colors.white : Colors.black87,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(
                      color: isDark ? Colors.transparent : Colors.black12,
                      width: 1,
                    ),
                  ),
                ),
                onPressed: _isLoading ? null : _handleGoogleSignIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RouletteHomePage extends StatefulWidget {
  const RouletteHomePage({super.key});

  @override
  State<RouletteHomePage> createState() => _RouletteHomePageState();
}

class _RouletteHomePageState extends State<RouletteHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const RoulettePage(),
    const MusicPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
    );
  }
}

class _CategoryIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool highlighted;
  final ColorScheme colorScheme;

  const _CategoryIcon({
    required this.icon,
    required this.label,
    required this.colorScheme,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = colorScheme.brightness == Brightness.dark;
    final iconColor = isDark
        ? Colors.white.withOpacity(highlighted ? 1 : 0.7)
        : Colors.black.withOpacity(highlighted ? 1 : 0.8);
    final textColor = isDark
        ? Colors.white.withOpacity(highlighted ? 1 : 0.7)
        : Colors.black.withOpacity(highlighted ? 1 : 0.8);

    return Column(
      children: [
        Icon(
          icon,
          size: 32,
          color: iconColor,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: textColor,
            fontWeight: highlighted ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ChallengeScreen extends StatefulWidget {
  final String category;
  final List<String> challenges;
  final List<Color> pieColors;
  const ChallengeScreen({super.key, required this.category, required this.challenges, required this.pieColors});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> with TickerProviderStateMixin {
  String? drawnChallenge;
  bool spinning = false;
  late final AnimationController _spinController;
  late Animation<double> _spinAnimation;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _spinAnimation = Tween<double>(begin: 0, end: 0).animate(CurvedAnimation(parent: _spinController, curve: Curves.easeOut));

    _spinAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          spinning = false;
          final double finalAngle = _spinAnimation.value;
          final adjustedAngle = finalAngle + pi / 2;
          final normalizedAngle = adjustedAngle % (2 * pi);
          final positiveNormalizedAngle = normalizedAngle < 0 ? normalizedAngle + 2 * pi : normalizedAngle;
          final segmentAngle = 2 * pi / widget.challenges.length;
          final int drawnIndex = (positiveNormalizedAngle / segmentAngle).floor();
          drawnChallenge = widget.challenges[drawnIndex % widget.challenges.length];
        });
      }
    });
  }

  void drawChallenge() {
    if (widget.challenges.isEmpty || spinning) return;
    setState(() {
      spinning = true;
      drawnChallenge = null;
    });
    final int randomIndex = Random().nextInt(widget.challenges.length);
    final double segmentAngle = 2 * pi / widget.challenges.length;
    final double targetSegmentCenterAngle = randomIndex * segmentAngle + segmentAngle / 2;
    final double requiredRotation = targetSegmentCenterAngle - (-pi/2);
    final double fullSpins = 4;
    final double targetAngle = fullSpins * 2 * pi + requiredRotation;

    _spinAnimation = Tween<double>(begin: 0, end: targetAngle).animate(CurvedAnimation(parent: _spinController, curve: Curves.easeOut));

    _spinController.reset();
    _spinController.forward();
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.category,
          style: TextStyle(color: colorScheme.onBackground, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        iconTheme: IconThemeData(color: colorScheme.onBackground),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _spinController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _spinAnimation.value,
                    child: child,
                  );
                },
                child: Container(
                  width: 180,
                  height: 180,
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    shape: BoxShape.circle,
                    boxShadow: isDark ? null : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 180,
                      width: 180,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 38,
                          borderData: FlBorderData(show: false),
                          sections: List.generate(widget.challenges.length, (i) => PieChartSectionData(
                            color: widget.pieColors[i % widget.pieColors.length],
                            value: 1, // Equal size for each section
                            showTitle: false,
                            radius: 80,
                          )),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.only(bottom: 18),
                decoration: BoxDecoration(
                  color: colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: isDark ? null : Border.all(color: Colors.black12),
                ),
                child: Text(
                  drawnChallenge ?? 'Naciśnij przycisk, aby wylosować wyzwanie',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorScheme.onSurface, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  elevation: 2,
                ),
                onPressed: drawChallenge,
                child: spinning
                    ? const SizedBox(width: 28, height: 28, child: CircularProgressIndicator(color: Color(0xFF2196F3), strokeWidth: 3))
                    : const Text('Losuj wyzwanie'),
              ),
              
              if (widget.category == 'Muzyka') ...[
                const SizedBox(height: 40),
                 Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: isDark ? null : Border.all(color: Colors.black12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                        'Losuj piosenkę Spotify',
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const ShuffleSongWidget(),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  // Dodajemy mapę wyzwań muzycznych jako statyczną stałą
  static const Map<String, List<String>> wyzwania = {
    'Muzyka': [
      'Posłuchaj przez 30 minut muzyki z innego gatunku niż zwykle.',
      'Stwórz nową playlistę na konkretny nastrój (np. relaks, motywacja).',
      'Naucz się słów jednej nowej piosenki i zaśpiewaj ją.',
      'Odsłuchaj cały album wybranego artysty bez przerzucania utworów.',
      'Znajdź nowego artystę na Spotify/YouTube i posłuchaj 3 jego utworów.',
    ],
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Muzyka'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Spotify Widget
            const ShuffleSongWidget(),
            
            const SizedBox(height: 24),
            
            // Music Challenges Section
            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: isDark ? null : Border.all(color: Colors.black12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wyzwania muzyczne',
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...List.generate(
                    wyzwania['Muzyka']?.length ?? 0,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.music_note,
                            color: colorScheme.primary,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              wyzwania['Muzyka']![index],
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final authService = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ustawienia'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              themeProvider.themeMode == ThemeMode.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
              color: colorScheme.onSurface,
            ),
            title: Text(
              'Tryb ciemny',
              style: TextStyle(color: colorScheme.onSurface),
            ),
            trailing: Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: colorScheme.error,
            ),
            title: Text(
              'Wyloguj się',
              style: TextStyle(color: colorScheme.error),
            ),
            onTap: () async {
              await authService.signOut();
              if (context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class RoulettePage extends StatefulWidget {
  const RoulettePage({super.key});

  @override
  State<RoulettePage> createState() => _RoulettePageState();
}

class _RoulettePageState extends State<RoulettePage> with SingleTickerProviderStateMixin {
  final List<String> categories = ['Dzień', 'Jedzenie', 'Rozrywka', 'Muzyka', 'Podróż'];
  final List<IconData> icons = [
    Icons.calendar_today,
    Icons.restaurant,
    Icons.sports_esports,
    Icons.music_note,
    Icons.place,
  ];
  final List<Color> pieColors = [
    Color(0xFF7AD1D6),  // Light blue
    Color(0xFF2B4263),  // Dark blue
    Color(0xFFB6E2D3),  // Light green
    Color(0xFFF7D6B3),  // Light orange
    Color(0xFF7AD1D6),  // Light blue
  ];
  Map<String, List<String>> activities = {};
  int selectedCategory = 0;
  int? spinningResult;
  double angle = 0;
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isSpinning = false;

  // Dodana baza wyzwań
  final Map<String, List<String>> wyzwania = {
    'Dzień': [
      'Wstań godzinę wcześniej niż zwykle.',
      'Przejdź dziś minimum 10 000 kroków.',
      'Zrób coś dobrego dla nieznajomej osoby.',
      'Przeznacz 30 minut na porządki w dowolnym miejscu w domu.',
      'Spędź 10 minut medytując lub wykonując ćwiczenia oddechowe.',
    ],
    'Jedzenie': [], // Empty list as we'll handle food differently
    'Rozrywka': [
      'Zagraj w grę planszową lub karcianą.',
      'Obejrzyj film z listy klasyków, których jeszcze nie widziałeś/aś.',
      'Spędź godzinę grając w swoją ulubioną grę — bez poczucia winy.',
      'Znajdź nową grę mobilną i przetestuj ją przez 15 minut.',
      'Przejrzyj stare zdjęcia lub filmy i powspominaj dobre chwile.',
    ],
    'Muzyka': [
      'Posłuchaj przez 30 minut muzyki z innego gatunku niż zwykle.',
      'Stwórz nową playlistę na konkretny nastrój (np. relaks, motywacja).',
      'Naucz się słów jednej nowej piosenki i zaśpiewaj ją.',
      'Odsłuchaj cały album wybranego artysty bez przerzucania utworów.',
      'Znajdź nowego artystę na Spotify/YouTube i posłuchaj 3 jego utworów.',
    ],
    'Podróż': [
      'Wybierz się dziś na spacer po nieznanej okolicy w Twoim mieście.',
      'Zaplanuj weekendową wycieczkę (nawet jeśli tylko na mapie).',
      'Przejdź się trasą, którą jeszcze nigdy nie chodziłeś/aś.',
      'Odwiedź lokalne miejsce, którego wcześniej nie znałeś/aś.',
      'Zrób zdjęcie jak z wakacji — nawet jeśli jesteś niedaleko domu.',
    ],
  };

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isSpinning = false;
            selectedCategory = spinningResult!;
          });
        }
      });
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      for (var cat in categories) {
        activities[cat] = prefs.getStringList('activities_$cat') ?? [];
      }
    });
  }

  Future<void> _saveActivities() async {
    final prefs = await SharedPreferences.getInstance();
    for (var cat in categories) {
      await prefs.setStringList('activities_$cat', activities[cat] ?? []);
    }
  }

  void _spinRoulette() {
    if (isSpinning) return;
    isSpinning = true;
    spinningResult = Random().nextInt(categories.length);
    double spins = 4 + spinningResult! / categories.length;
    angle = spins * 2 * pi;
    _controller.reset();
    _controller.forward();
  }

  void _showAddActivityDialog() async {
    String? newActivity;
    int catIndex = selectedCategory;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151C25),
          title: const Text('Dodaj aktywność', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<int>(
                value: catIndex,
                dropdownColor: const Color(0xFF151C25),
                style: const TextStyle(color: Colors.white),
                items: List.generate(categories.length, (i) => DropdownMenuItem(
                  value: i,
                  child: Text(categories[i], style: const TextStyle(color: Colors.white)),
                )),
                onChanged: (v) {
                  setState(() { catIndex = v!; });
                  Navigator.of(context).pop();
                  _showAddActivityDialog();
                },
              ),
              TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(hintText: 'Aktywność', hintStyle: TextStyle(color: Colors.white54)),
                onChanged: (v) => newActivity = v,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Anuluj', style: TextStyle(color: Colors.white70)),
            ),
            TextButton(
              onPressed: () {
                if (newActivity != null && newActivity!.trim().isNotEmpty) {
                  setState(() {
                    activities[categories[catIndex]]!.add(newActivity!.trim());
                  });
                  _saveActivities();
                }
                Navigator.of(context).pop();
              },
              child: const Text('Dodaj', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _openChallengeScreen(int catIndex) {
    if (categories[catIndex] == 'Jedzenie') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const FoodCategoriesScreen(),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChallengeScreen(
            category: categories[catIndex],
            challenges: wyzwania[categories[catIndex]] ?? [],
            pieColors: pieColors,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = colorScheme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 330,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
              color: colorScheme.background,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 40),
                      Text(
                        'Roulette',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onBackground,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              themeProvider.themeMode == ThemeMode.dark
                                  ? Icons.dark_mode
                                  : Icons.light_mode,
                              color: colorScheme.onBackground,
                            ),
                            onPressed: () => themeProvider.toggleTheme(),
                          ),
                          CircleAvatar(
                            backgroundColor: colorScheme.surface,
                            radius: 22,
                            child: Icon(Icons.person, color: colorScheme.onSurface, size: 26),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(categories.length, (i) => GestureDetector(
                      onTap: () => _openChallengeScreen(i),
                      child: _CategoryIcon(
                        icon: icons[i],
                        label: categories[i],
                        highlighted: selectedCategory == i,
                        colorScheme: colorScheme,
                      ),
                    )),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _animation.value * angle,
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            shape: BoxShape.circle,
                            boxShadow: isDark ? null : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              height: 180,
                              width: 180,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 38,
                                  borderData: FlBorderData(show: false),
                                  sections: List.generate(categories.length, (i) => PieChartSectionData(
                                    color: pieColors[i % pieColors.length],
                                    value: 25,
                                    showTitle: false,
                                    radius: 80,
                                  )),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16),
                if (!isSpinning && spinningResult != null)
                  Text(
                    'Wylosowano: ${categories[selectedCategory]}',
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  )
                else
                  const SizedBox(height: 24),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 240,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? colorScheme.surface : Colors.white,
                            foregroundColor: isDark ? Colors.white : Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                              side: BorderSide(
                                color: isDark ? Colors.transparent : Colors.black26,
                                width: 1,
                              ),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                            elevation: isDark ? 0 : 2,
                          ),
                          onPressed: _spinRoulette,
                          child: isSpinning
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.teal,
                                    strokeWidth: 3,
                                  ),
                                )
                              : const Text('KRĘĆ'),
                        ),
                      ),
                      const SizedBox(height: 18),
                      SizedBox(
                        width: 240,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isDark ? colorScheme.surface : Colors.white,
                            foregroundColor: isDark ? Colors.white : Colors.black87,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                              side: BorderSide(
                                color: isDark ? Colors.transparent : Colors.black26,
                                width: 1,
                              ),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.1,
                            ),
                            elevation: isDark ? 0 : 2,
                          ),
                          onPressed: _showAddActivityDialog,
                          child: const Text('DODAJ AKTYWNOŚĆ'),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
