import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FoodService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Food categories
  static const List<String> categories = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Sweet treat',
    'Snack',
    'Date night'
  ];

  // Default meals for each category
  final Map<String, List<String>> defaultMeals = {
    'Breakfast': [
      'Oatmeal with fruits',
      'Scrambled eggs with butter',
      'Avocado toast',
      'Yogurt with granola',
      'Pancakes',
      'Smoothie bowl',
      'French toast',
      'Shakshuka',
      'Vegetable omelette',
      'Hummus sandwich',
      'Apple pancakes',
      'Muesli with yogurt',
      'Eggs benedict',
      'Millet porridge with milk',
      'Pancakes with maple syrup',
      'Smoked salmon sandwich',
      'Chia pudding',
      'Waffles with fruits',
      'Cottage cheese with chives',
      'Cinnamon rolls',
      'Apple fritters',
      'Egg salad on toast',
      'Protein shake',
      'Rice pudding',
      'Croissants with jam',
      'Tuna sandwich',
      'Millet porridge with banana',
      'Cheese omelette',
      'Greek yogurt with honey',
      'Cornflakes with milk',
    ],
    'Lunch': [
      'Grilled chicken salad',
      'Hummus and vegetable wrap',
      'Pasta with tomato sauce',
      'Quinoa and vegetable bowl',
      'Pumpkin cream soup',
      'Mushroom risotto',
      'Turkey cutlet with buckwheat',
      'Greek salad',
      'Penne arrabiata',
      'Buddha bowl',
      'Minestrone soup',
      'Bean tortilla',
      'Salmon with steamed vegetables',
      'Quinoa salad',
      'Chickpea curry',
      'Pesto pasta',
      'Thai soup',
      'Grilled cheese sandwich',
      'Mexican bowl',
      'Broccoli cream soup',
      'Cauliflower cutlet',
      'Tuna salad',
      'Zucchini pasta',
      'Falafel wrap',
      'Tomato soup',
      'Avocado salad',
      'Couscous with vegetables',
      'Vegetable frittata',
      'Asian bowl',
      'Lentil cream soup',
    ],
    'Dinner': [
      'Salmon with roasted vegetables',
      'Pork cutlet with potatoes',
      'Chickpea curry',
      'Homemade pizza',
      'Spaghetti bolognese',
      'Russian pierogi',
      'Chicken in cream sauce',
      'Beef goulash',
      'Fish in Greek style',
      'Lasagna',
      'Meat patty with mashed potatoes',
      'Duck with apples',
      'Seafood paella',
      'Cabbage rolls in tomato sauce',
      'Roasted turkey',
      'Pasta carbonara',
      'Breaded cod',
      'Pork tenderloin in mushroom sauce',
      'Pasta casserole',
      'Grilled pork neck',
      'Salmon in dill sauce',
      'Meat patties',
      'Chicken curry',
      'BBQ ribs',
      'Baked sea bream',
      'Pork in its own sauce',
      'Meatballs in tomato sauce',
      'Chicken fillet with herbs',
      'Fish in lemon sauce',
      'Roman roast',
    ],
    'Sweet treat': [
      'Brownie',
      'Apple pie',
      'Cheesecake',
      'Chocolate muffins',
      'Ice cream with fruits',
      'Vanilla pudding',
      'Tiramisu',
      'Crème brûlée',
      'Panna cotta',
      'Chocolate cake',
      'Macarons',
      'Fruit tart',
      'Homemade ice cream',
      'Cream cupcakes',
      'Chocolate mousse',
      'Carrot cake',
      'Chocolate truffles',
      'Apples in batter',
      'Rice pudding',
      'Waffles with whipped cream',
      'Pancakes with Nutella',
      'Yogurt cake',
      'Meringue with fruits',
      'Chocolate fondant',
      'Cream puffs',
      'No-bake cheesecake',
      'Oatmeal cookies',
      'Lemon tart',
      'Homemade Raffaello',
      'Cake with jelly',
    ],
    'Snack': [
      'Hummus with vegetables',
      'Nut mix',
      'Fruit smoothie',
      'Egg salad sandwich',
      'Seasonal fruits',
      'Vegetable chips',
      'Guacamole with nachos',
      'Yogurt with granola',
      'Dried fruits',
      'Avocado sandwich',
      'Energy bars',
      'Fruit salad',
      'Homemade popcorn',
      'Mini vegetable wraps',
      'Protein shake',
      'Apple chips',
      'Student mix',
      'Cheese crackers',
      'Smoothie bowl',
      'Chickpea spread',
      'Honey nuts',
      'Vegetables with dip',
      'Energy balls',
      'Hummus toast',
      'Banana chips',
      'Quinoa salad',
      'Savory muffins',
      'Tortilla rolls',
      'Chocolate-covered dried fruits',
      'Mini sandwiches',
    ],
    'Date night': [
      'Steak with fries',
      'Shrimp risotto',
      'Pasta carbonara',
      'Sushi',
      'Cheese fondue',
      'Tapas',
      'Duck in orange sauce',
      'Seafood in wine',
      'Truffle ravioli',
      'Beef tartare',
      'Shrimp in white wine',
      'Duck breast',
      'Grilled lobster',
      'Saffron risotto',
      'Beef carpaccio',
      'Mussels in wine sauce',
      'Beef wellington',
      'Tagliata with arugula',
      'Oysters',
      'Gnocchi with sage',
      'Grilled octopus',
      'Tomahawk steak',
      'Seafood linguine',
      'Tuna tartare',
      'Foie gras',
      'Seafood paella',
      'BBQ ribs',
      'Sashimi mix',
      'Beef bourguignon',
      'Shrimp tempura',
    ],
  };

  // Initialize default meals for a user
  Future<void> initializeDefaultMeals() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final userMealsRef = _firestore.collection('users').doc(userId).collection('meals');
    
    // Check if user already has meals initialized
    final snapshot = await userMealsRef.limit(1).get();
    if (snapshot.docs.isNotEmpty) return;

    // Initialize default meals for each category
    for (var category in categories) {
      await userMealsRef.doc(category.toLowerCase().replaceAll(' ', '_')).set({
        'meals': defaultMeals[category],
        'category': category,
      });
    }
  }

  // Get meals for a specific category
  Future<List<String>> getMealsForCategory(String category) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    try {
      final docSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('meals')
          .doc(category.toLowerCase().replaceAll(' ', '_'))
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        return List<String>.from(data?['meals'] ?? []);
      }
      return defaultMeals[category] ?? [];
    } catch (e) {
      print('Error getting meals: $e');
      return [];
    }
  }

  // Add a new meal to a category
  Future<void> addMealToCategory(String category, String meal) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('meals')
        .doc(category.toLowerCase().replaceAll(' ', '_'));

    await _firestore.runTransaction((transaction) async {
      final docSnapshot = await transaction.get(docRef);
      if (docSnapshot.exists) {
        final currentMeals = List<String>.from(docSnapshot.data()?['meals'] ?? []);
        if (!currentMeals.contains(meal)) {
          currentMeals.add(meal);
          transaction.update(docRef, {'meals': currentMeals});
        }
      } else {
        transaction.set(docRef, {
          'meals': [meal],
          'category': category,
        });
      }
    });
  }

  // Remove a meal from a category
  Future<void> removeMealFromCategory(String category, String meal) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('meals')
        .doc(category.toLowerCase().replaceAll(' ', '_'));

    await _firestore.runTransaction((transaction) async {
      final docSnapshot = await transaction.get(docRef);
      if (docSnapshot.exists) {
        final currentMeals = List<String>.from(docSnapshot.data()?['meals'] ?? []);
        currentMeals.remove(meal);
        transaction.update(docRef, {'meals': currentMeals});
      }
    });
  }
} 