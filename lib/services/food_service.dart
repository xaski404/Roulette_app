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
      'Owsianka z owocami',
      'Jajecznica na maśle',
      'Kanapki z awokado',
      'Jogurt z granolą',
      'Naleśniki',
      'Smoothie bowl',
    ],
    'Lunch': [
      'Sałatka z grillowanym kurczakiem',
      'Wrap z hummusem i warzywami',
      'Makaron z sosem pomidorowym',
      'Bowl z quinoa i warzywami',
      'Zupa krem z dyni',
      'Risotto z grzybami',
    ],
    'Dinner': [
      'Łosoś z pieczonymi warzywami',
      'Kotlet schabowy z ziemniakami',
      'Curry z ciecierzycą',
      'Pizza domowa',
      'Spaghetti bolognese',
      'Pierogi ruskie',
    ],
    'Sweet treat': [
      'Brownie',
      'Szarlotka',
      'Sernik',
      'Muffiny czekoladowe',
      'Lody z owocami',
      'Budyń waniliowy',
    ],
    'Snack': [
      'Hummus z warzywami',
      'Mix orzechów',
      'Smoothie owocowe',
      'Kanapka z pastą jajeczną',
      'Owoce sezonowe',
      'Chipsy z warzyw',
    ],
    'Date night': [
      'Stek z frytkami',
      'Risotto z krewetkami',
      'Makaron carbonara',
      'Sushi',
      'Fondue serowe',
      'Tapas',
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