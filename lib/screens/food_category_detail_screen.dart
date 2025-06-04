import 'package:flutter/material.dart';
import 'dart:math';
import '../services/food_service.dart';

class FoodCategoryDetailScreen extends StatefulWidget {
  final String category;

  const FoodCategoryDetailScreen({
    super.key,
    required this.category,
  });

  @override
  State<FoodCategoryDetailScreen> createState() => _FoodCategoryDetailScreenState();
}

class _FoodCategoryDetailScreenState extends State<FoodCategoryDetailScreen> {
  final FoodService _foodService = FoodService();
  List<String> _meals = [];
  String? _selectedMeal;
  bool _isLoading = true;
  final TextEditingController _newMealController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMeals();
  }

  @override
  void dispose() {
    _newMealController.dispose();
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
    if (_meals.isEmpty) return;
    
    setState(() {
      final random = Random();
      String newMeal;
      do {
        newMeal = _meals[random.nextInt(_meals.length)];
      } while (_meals.length > 1 && newMeal == _selectedMeal);
      _selectedMeal = newMeal;
    });
  }

  Future<void> _showAddMealDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Dodaj nowy posiłek'),
          content: TextField(
            controller: _newMealController,
            decoration: const InputDecoration(
              hintText: 'Nazwa posiłku',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Anuluj'),
            ),
            ElevatedButton(
              onPressed: () async {
                final newMeal = _newMealController.text.trim();
                if (newMeal.isNotEmpty) {
                  await _foodService.addMealToCategory(widget.category, newMeal);
                  _newMealController.clear();
                  Navigator.pop(context);
                  _loadMeals();
                }
              },
              child: const Text('Dodaj'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteConfirmation(String meal) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Usuń posiłek'),
          content: Text('Czy na pewno chcesz usunąć "$meal"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Anuluj'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _foodService.removeMealFromCategory(widget.category, meal);
                Navigator.pop(context);
                _loadMeals();
                if (_selectedMeal == meal) {
                  setState(() => _selectedMeal = null);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Usuń'),
            ),
          ],
        );
      },
    );
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
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddMealDialog,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Selected meal display
                if (_selectedMeal != null)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
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
                      children: [
                        const Text(
                          'Wylosowany posiłek:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
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

                // Random selection button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: _meals.isEmpty ? null : _selectRandomMeal,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text('Wylosuj posiłek'),
                  ),
                ),

                // Meals list
                Expanded(
                  child: _meals.isEmpty
                      ? Center(
                          child: Text(
                            'Brak posiłków w tej kategorii',
                            style: TextStyle(color: colorScheme.onSurface),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _meals.length,
                          itemBuilder: (context, index) {
                            final meal = _meals[index];
                            return Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                title: Text(meal),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _showDeleteConfirmation(meal),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
} 