import 'package:flutter/material.dart';
import 'dart:math';
import '../services/food_service.dart';
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

class _FoodCategoryDetailScreenState extends State<FoodCategoryDetailScreen> with SingleTickerProviderStateMixin {
  final FoodService _foodService = FoodService();
  List<String> _meals = [];
  String? _selectedMeal;
  bool _isLoading = true;
  bool _isSpinning = false;
  late AnimationController _spinController;
  late Animation<double> _spinAnimation;
  final List<Color> pieColors = [
    Color(0xFF7AD1D6),  // Light blue
    Color(0xFF2B4263),  // Dark blue
    Color(0xFFB6E2D3),  // Light green
    Color(0xFFF7D6B3),  // Light orange
    Color(0xFF7AD1D6),  // Light blue
  ];

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _spinAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _spinController, curve: Curves.easeOut),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isSpinning = false;
        });
      }
    });
    _loadMeals();
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
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

      // Calculate random spins (4-6 full rotations plus partial)
      final spins = 4 + random.nextDouble() * 2;
      final targetAngle = spins * 2 * pi;
      
      _spinAnimation = Tween<double>(
        begin: 0,
        end: targetAngle,
      ).animate(CurvedAnimation(parent: _spinController, curve: Curves.easeOut));
    });

    _spinController.reset();
    _spinController.forward();
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
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Roulette wheel
                AnimatedBuilder(
                  animation: _spinController,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _spinAnimation.value,
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
                              sectionsSpace: 0,
                              centerSpaceRadius: 50,
                              sections: List.generate(
                                8,
                                (i) => PieChartSectionData(
                                  color: pieColors[i % pieColors.length],
                                  value: 1,
                                  title: '',
                                  radius: 90,
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
                const SizedBox(height: 40),

                // Selected meal display
                if (_selectedMeal != null)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 32),
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
    );
  }
} 