import 'package:flutter/material.dart';
import '../services/food_service.dart';
import 'food_category_detail_screen.dart';

class FoodCategoriesScreen extends StatefulWidget {
  const FoodCategoriesScreen({super.key});

  @override
  State<FoodCategoriesScreen> createState() => _FoodCategoriesScreenState();
}

class _FoodCategoriesScreenState extends State<FoodCategoriesScreen> {
  final FoodService _foodService = FoodService();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeMeals();
  }

  Future<void> _initializeMeals() async {
    if (!_isInitialized) {
      await _foodService.initializeDefaultMeals();
      setState(() {
        _isInitialized = true;
      });
    }
  }

  // Get icon for each category
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Breakfast':
        return Icons.breakfast_dining;
      case 'Lunch':
        return Icons.lunch_dining;
      case 'Dinner':
        return Icons.dinner_dining;
      case 'Sweet treat':
        return Icons.cake;
      case 'Snack':
        return Icons.cookie;
      case 'Date night':
        return Icons.favorite;
      default:
        return Icons.restaurant;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Kategorie posiłków'),
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
        itemCount: FoodService.categories.length,
        itemBuilder: (context, index) {
          final category = FoodService.categories[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodCategoryDetailScreen(category: category),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _getCategoryIcon(category),
                    size: 48,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
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