import 'package:flutter/material.dart';
import '../services/workout_service.dart';
import 'workout_category_detail_screen.dart';

class WorkoutCategoriesScreen extends StatefulWidget {
  const WorkoutCategoriesScreen({super.key});

  @override
  State<WorkoutCategoriesScreen> createState() => _WorkoutCategoriesScreenState();
}

class _WorkoutCategoriesScreenState extends State<WorkoutCategoriesScreen> {
  final WorkoutService _workoutService = WorkoutService();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeWorkouts();
  }

  Future<void> _initializeWorkouts() async {
    if (!_isInitialized) {
      await _workoutService.initializeDefaultWorkouts();
      setState(() {
        _isInitialized = true;
      });
    }
  }

  // Get icon for each category
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Strength training at the gym':
        return Icons.fitness_center;
      case 'Strength training at home':
        return Icons.home;
      case 'Strength training outdoors':
        return Icons.park;
      case 'Running':
        return Icons.directions_run;
      case 'Team sports':
        return Icons.sports_soccer;
      case 'Athletics':
        return Icons.sports_score;
      default:
        return Icons.fitness_center;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Workout Categories'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: WorkoutService.categories.length,
        itemBuilder: (context, index) {
          final category = WorkoutService.categories[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutCategoryDetailScreen(
                    category: category,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                border: isDark ? null : Border.all(color: Colors.black12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getCategoryIcon(category),
                    size: 48,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      category,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 