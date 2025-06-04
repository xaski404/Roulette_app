import 'package:flutter/material.dart';
import 'dart:math';
import '../services/food_service.dart';
import '../services/recipe_service.dart';
import '../services/places_service.dart';
import 'restaurant_results_screen.dart';
import 'package:fl_chart/fl_chart.dart';

class FoodCategoryDetailScreen extends StatefulWidget {
  final String category;

  const FoodCategoryDetailScreen({
    super.key,
    required this.category,
  });

  @override
  State<FoodCategoryDetailScreen> createState() => _FoodCategoryDetailScreenState();
}

class _FoodCategoryDetailScreenState extends State<FoodCategoryDetailScreen> with TickerProviderStateMixin {
  final FoodService _foodService = FoodService();
  List<String> _meals = [];
  String? _selectedMeal;
  String? _currentPassingMeal;
  bool _isLoading = true;
  bool _isSpinning = false;
  String? _selectedRecipe;
  
  // Controllers for different animation aspects
  late AnimationController _spinController;
  late AnimationController _bounceController;
  late Animation<double> _spinAnimation;
  late Animation<double> _bounceAnimation;
  
  // Constants for animation
  static const int numSegments = 12;
  static const double segmentAngle = 2 * pi / numSegments;
  final List<Color> pieColors = [
    Color(0xFF7AD1D6),  // Light blue
    Color(0xFF2B4263),  // Dark blue
    Color(0xFFB6E2D3),  // Light green
    Color(0xFFF7D6B3),  // Light orange
  ];

  @override
  void initState() {
    super.initState();
    
    // Main spin animation controller
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Bounce effect controller
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    // Bounce animation
    _bounceAnimation = Tween<double>(
      begin: 0,
      end: segmentAngle / 4,
    ).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    ));

    // Initialize spin animation
    _spinAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _spinController,
        curve: const Interval(0, 1, curve: Curves.easeOutCubic),
      ),
    );

    // Add listeners for animation updates
    _spinAnimation.addListener(_updatePassingMeal);
    _spinAnimation.addStatusListener(_handleSpinStatus);

    _loadMeals();
  }

  @override
  void dispose() {
    _spinController.dispose();
    _bounceController.dispose();
    // Ensure we clean up the passing meal state
    _currentPassingMeal = null;
    super.dispose();
  }

  void _updatePassingMeal() {
    if (!_isSpinning || _meals.isEmpty) {
      setState(() {
        _currentPassingMeal = null;
      });
      return;
    }

    // Calculate current angle and segment
    final currentAngle = _spinAnimation.value * (2 * pi * 5); // 5 full rotations
    final normalizedAngle = currentAngle % (2 * pi);
    final currentSegment = (normalizedAngle / segmentAngle).floor() % _meals.length;

    // Update passing meal with smooth transitions
    if (mounted) {
      setState(() {
        _currentPassingMeal = _meals[currentSegment];
      });
    }

    // Add bounce effect near the end of the animation
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
    if (status == AnimationStatus.completed && mounted) {
      setState(() {
        _isSpinning = false;
        _currentPassingMeal = null;
      });
    }
  }

  Future<void> _loadMeals() async {
    setState(() => _isLoading = true);
    try {
      final meals = await _foodService.getMealsForCategory(widget.category);
      setState(() {
        _meals = meals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Błąd podczas ładowania posiłków: $e')),
        );
      }
    }
  }

  void _selectRandomMeal() {
    if (_meals.isEmpty || _isSpinning) return;
    
    setState(() {
      _isSpinning = true;
      final random = Random();
      String newMeal;
      do {
        newMeal = _meals[random.nextInt(_meals.length)];
      } while (_meals.length > 1 && newMeal == _selectedMeal);
      _selectedMeal = newMeal;

      // Reset and start animations
      _spinController.reset();
      _spinController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Roulette wheel with selector
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

                    const SizedBox(height: 32),

                    // Passing meals display
                    SizedBox(
                      height: 40,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: _isSpinning && _currentPassingMeal != null
                            ? Container(
                                key: ValueKey(_currentPassingMeal),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 32,
                                ),
                                child: Text(
                                  _currentPassingMeal!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: colorScheme.onBackground.withOpacity(0.7),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Container(
                                key: const ValueKey('empty'),
                                height: 40,
                              ),
                      ),
                    ),

                    // Selected meal display with action buttons
                    if (_selectedMeal != null && !_isSpinning)
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: isDark ? null : [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const Text(
                                    'Wylosowany posiłek:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    _selectedMeal!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Action buttons
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      final recipe = RecipeService.getRecipe(_selectedMeal!);
                                      setState(() {
                                        _selectedRecipe = recipe;
                                      });
                                      if (recipe == null) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Przepis nie jest jeszcze dostępny'),
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.secondary.withOpacity(0.8),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Zjem w domu',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      final location = await PlacesService.getCurrentLocation();
                                      if (location == null) {
                                        if (mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Nie udało się uzyskać lokalizacji. Sprawdź uprawnienia.'),
                                            ),
                                          );
                                        }
                                        return;
                                      }

                                      if (mounted) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => RestaurantResultsScreen(
                                              meal: _selectedMeal!,
                                              userLocation: location,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.tertiary.withOpacity(0.8),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Zjem na mieście',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    // Recipe display
                    if (_selectedRecipe != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(32, 24, 32, 0),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: isDark ? null : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Przepis',
                                    style: TextStyle(
                                      color: colorScheme.onSurface,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        _selectedRecipe = null;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _selectedRecipe!,
                                style: TextStyle(
                                  color: colorScheme.onSurface,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    const SizedBox(height: 40),

                    // Random selection button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: ElevatedButton(
                        onPressed: _meals.isEmpty || _isSpinning ? null : _selectRandomMeal,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: _isSpinning
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'LOSUJ',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
} 