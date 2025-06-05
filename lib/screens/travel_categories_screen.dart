import 'package:flutter/material.dart';
import '../services/travel_service.dart';
import 'travel_screen.dart';

class TravelCategoriesScreen extends StatelessWidget {
  const TravelCategoriesScreen({super.key});

  // Get icon for each category
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Quick trip':
        return Icons.directions_car;
      case 'Trip up to 300 km':
        return Icons.train;
      case 'Trip up to 500 km':
        return Icons.airplanemode_active;
      case 'Trip within Poland':
        return Icons.flag;
      case 'Trip within Europe':
        return Icons.euro;
      case 'Trip worldwide':
        return Icons.public;
      default:
        return Icons.place;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = colorScheme.brightness == Brightness.dark;

    final categories = [
      TravelService.QUICK_TRIP,
      TravelService.TRIP_300,
      TravelService.TRIP_500,
      TravelService.TRIP_POLAND,
      TravelService.TRIP_EUROPE,
      TravelService.TRIP_WORLDWIDE,
    ];

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Travel Categories'),
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
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TravelScreen(initialCategory: category),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      category,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
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