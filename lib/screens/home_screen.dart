import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'food_categories_screen.dart';
import 'travel_categories_screen.dart';
import 'entertainment_categories_screen.dart';
import 'workout_categories_screen.dart';
import 'music_categories_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../main.dart';  // For ThemeProvider
import '../services/auth_service.dart';
import '../widgets/streak_calendar.dart';
import '../services/streak_service.dart';
import '../widgets/user_menu_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<String> dailyActivities = [
    'Wstań godzinę wcześniej niż zwykle',
    'Przejdź dziś minimum 10 000 kroków',
    'Zrób coś dobrego dla nieznajomej osoby',
    'Przeznacz 30 minut na porządki w dowolnym miejscu w domu',
    'Spędź 10 minut medytując lub wykonując ćwiczenia oddechowe',
  ];

  String? _selectedActivity;
  bool _isSpinning = false;
  bool _canSpin = true;
  DateTime? _nextSpinTime;
  String _timeUntilNextSpin = '';
  late AnimationController _spinController;
  late AnimationController _bounceController;
  late Animation<double> _spinAnimation;
  late Animation<double> _bounceAnimation;

  static const int numSegments = 12;
  static const double segmentAngle = 2 * pi / numSegments;
  final List<Color> pieColors = [
    Color(0xFF7AD1D6),  // Light blue
    Color(0xFF2B4263),  // Dark blue
    Color(0xFFB6E2D3),  // Light green
    Color(0xFFF7D6B3),  // Light orange
  ];

  final AuthService _authService = AuthService();
  final StreakService _streakService = StreakService();

  @override
  void initState() {
    super.initState();
    
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _bounceAnimation = Tween<double>(
      begin: 0,
      end: segmentAngle / 4,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ));

    _spinAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _spinController,
        curve: Curves.easeOutCubic,
      ),
    );

    _spinAnimation.addListener(_updatePassingActivity);
    _spinAnimation.addStatusListener(_handleSpinStatus);
    _checkSpinAvailability();
    _startTimer();
  }

  void _updatePassingActivity() {
    if (!_isSpinning) return;

    final currentAngle = _spinAnimation.value * (2 * pi * 5);
    final normalizedAngle = currentAngle % (2 * pi);
    final currentSegment = (normalizedAngle / segmentAngle).floor() % dailyActivities.length;

    if (_spinAnimation.value > 0.8) {
      final shouldBounce = (normalizedAngle / (segmentAngle / 2)).floor() % 2 == 0;
      
      if (shouldBounce && !_bounceController.isAnimating) {
        _bounceController.forward().then((_) {
          if (mounted) {
            _bounceController.reverse();
          }
        });
      }
    }
  }

  void _handleSpinStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _isSpinning = false;
        final currentAngle = _spinAnimation.value;
        final normalizedAngle = currentAngle % (2 * pi);
        final segmentAngle = 2 * pi / dailyActivities.length;
        final selectedIndex = (normalizedAngle / segmentAngle).floor() % dailyActivities.length;
        _selectedActivity = dailyActivities[selectedIndex];
      });
      _recordDailyActivity();
      _checkSpinAvailability();
    }
  }

  void _startTimer() {
    Future.doWhile(() async {
      if (!mounted) return false;
      await _updateTimeUntilNextSpin();
      await Future.delayed(const Duration(seconds: 1));
      return true;
    });
  }

  Future<void> _updateTimeUntilNextSpin() async {
    if (_nextSpinTime == null) return;
    
    final now = DateTime.now();
    if (now.isAfter(_nextSpinTime!)) {
      setState(() {
        _canSpin = true;
        _nextSpinTime = null;
        _timeUntilNextSpin = '';
      });
      return;
    }

    final difference = _nextSpinTime!.difference(now);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    final seconds = difference.inSeconds % 60;

    setState(() {
      _timeUntilNextSpin = '${hours}h ${minutes}m ${seconds}s';
    });
  }

  Future<void> _checkSpinAvailability() async {
    final spinStatus = await _streakService.checkDailySpin();
    setState(() {
      _canSpin = spinStatus['canSpin'];
      _nextSpinTime = spinStatus['nextSpinTime'];
    });
    if (_nextSpinTime != null) {
      _updateTimeUntilNextSpin();
    }
  }

  void _spinWheel() {
    if (_isSpinning || !_canSpin) return;
    
    setState(() {
      _isSpinning = true;
      _selectedActivity = null;
    });

    // Generate a random number of full rotations (between 3 and 5)
    final random = Random();
    final fullRotations = 3 + random.nextInt(3);
    
    // Generate a random final position
    final randomIndex = random.nextInt(dailyActivities.length);
    final segmentAngle = 2 * pi / dailyActivities.length;
    final targetAngle = randomIndex * segmentAngle + (segmentAngle / 2);
    
    // Calculate the total rotation needed
    final totalRotation = (fullRotations * 2 * pi) + targetAngle;
    
    // Create a new animation with the random target
    _spinAnimation = Tween<double>(begin: 0, end: totalRotation).animate(
      CurvedAnimation(
        parent: _spinController,
        curve: Curves.easeOutCubic,
      ),
    );

    _spinController.forward(from: 0);
  }

  Future<void> _handleLogout() async {
    try {
      await _authService.signOut();
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error logging out: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _recordDailyActivity() async {
    await _streakService.recordActivity();
  }

  void _showStreakCalendar() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const StreakCalendar(),
      ),
    );
  }

  void _showUserMenu() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (context) => UserMenuPanel(
        onLogout: () {
          Navigator.of(context).pop();
          _handleLogout();
        },
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  void dispose() {
    _spinController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  Widget _buildCategoryButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: isDark ? null : Border.all(color: Colors.black12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 28, color: colorScheme.primary),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header with app name and controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Theme toggle button
                  IconButton(
                    icon: Icon(
                      themeProvider.themeMode == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: colorScheme.onBackground,
                    ),
                    onPressed: () => themeProvider.toggleTheme(),
                  ),
                  // App title
                  Text(
                    'Roulette',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onBackground,
                    ),
                  ),
                  // Profile avatar
                  GestureDetector(
                    onTap: _showUserMenu,
                    child: CircleAvatar(
                      backgroundColor: colorScheme.surface,
                      radius: 22,
                      child: Icon(
                        Icons.person,
                        color: colorScheme.onSurface,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Category navigation
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryButton(
                    icon: Icons.restaurant,
                    label: 'Food',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FoodCategoriesScreen()),
                    ),
                  ),
                  _buildCategoryButton(
                    icon: Icons.place,
                    label: 'Travel',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const TravelCategoriesScreen()),
                    ),
                  ),
                  _buildCategoryButton(
                    icon: Icons.sports_esports,
                    label: 'Fun',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EntertainmentCategoriesScreen()),
                    ),
                  ),
                  _buildCategoryButton(
                    icon: Icons.fitness_center,
                    label: 'Workouts',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const WorkoutCategoriesScreen()),
                    ),
                  ),
                  _buildCategoryButton(
                    icon: Icons.music_note,
                    label: 'Music',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MusicCategoriesScreen()),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),  // Add subtle spacing after navigation

            // Make My Day section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),  // Adjusted from 8 to 16
                child: Column(
                  children: [
                    // Title with icon
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),  // Adjusted from 16 to 20
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 32,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Make My Day',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: colorScheme.onBackground,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Wheel container
                    SizedBox(
                      width: 250,
                      height: 270,
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          // Spinning wheel
                          AnimatedBuilder(
                            animation: Listenable.merge([_spinAnimation, _bounceAnimation]),
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _spinAnimation.value * (2 * pi * 5) + _bounceAnimation.value,
                                child: Container(
                                  width: 250,
                                  height: 250,
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
                                    child: PieChart(
                                      PieChartData(
                                        sectionsSpace: 2,
                                        centerSpaceRadius: 50,
                                        sections: List.generate(
                                          numSegments,
                                          (i) => PieChartSectionData(
                                            color: pieColors[i % pieColors.length],
                                            value: 1,
                                            title: '',
                                            radius: 90,
                                            showTitle: false,
                                          ),
                                        ),
                                        borderData: FlBorderData(show: false),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          // Center circle with icon
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isDark ? Colors.white24 : Colors.black12,
                                width: 2,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.auto_awesome_motion,
                                  color: colorScheme.primary.withOpacity(0.3),
                                  size: 42,
                                ),
                                Icon(
                                  Icons.casino,
                                  color: colorScheme.primary,
                                  size: 32,
                                ),
                              ],
                            ),
                          ),
                          // Selector triangle
                          Positioned(
                            top: -10,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                shape: BoxShape.circle,
                                boxShadow: isDark ? null : [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Selected activity display
                    if (_selectedActivity != null && !_isSpinning)
                      Container(
                        padding: const EdgeInsets.all(24),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: isDark ? null : Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Today\'s Challenge',
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _selectedActivity!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 24),

                    // Spin button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      child: Column(
                        children: [
                          if (_timeUntilNextSpin.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                'Next spin available in: $_timeUntilNextSpin',
                                style: TextStyle(
                                  color: colorScheme.onBackground.withOpacity(0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ElevatedButton(
                            onPressed: _canSpin && !_isSpinning ? _spinWheel : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _canSpin ? colorScheme.primary : colorScheme.surface,
                              foregroundColor: _canSpin ? colorScheme.onPrimary : colorScheme.onSurface.withOpacity(0.38),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              _isSpinning ? 'Spinning...' : (_canSpin ? 'Spin the Wheel' : 'Come back tomorrow'),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 