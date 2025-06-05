import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Workout categories
  static const List<String> categories = [
    'Strength training at the gym',
    'Strength training at home',
    'Strength training outdoors',
    'Running',
    'Team sports',
    'Athletics'
  ];

  // Default workouts for each category
  final Map<String, List<String>> defaultWorkouts = {
    'Strength training at the gym': [
      'Full body workout',
      'Upper body focus',
      'Lower body focus',
      'Push day',
      'Pull day',
      'Leg day',
      'Core workout',
      'HIIT circuit',
      'Strength and cardio mix',
      'Powerlifting session'
    ],
    'Strength training at home': [
      'Bodyweight circuit',
      'Resistance band workout',
      'Dumbbell routine',
      'Core and abs',
      'Full body HIIT',
      'Upper body focus',
      'Lower body focus',
      'Push-up variations',
      'Squat variations',
      'Plank variations'
    ],
    'Strength training outdoors': [
      'Park workout',
      'Calisthenics',
      'Outdoor circuit',
      'Stair workout',
      'Bench workout',
      'Tree branch exercises',
      'Rock climbing',
      'Outdoor HIIT',
      'Bodyweight strength',
      'Natural resistance training'
    ],
    'Running': [
      'Long distance run',
      'Sprint intervals',
      'Hill repeats',
      'Fartlek training',
      'Tempo run',
      'Recovery run',
      'Trail running',
      'Beach run',
      'City exploration run',
      'Park run'
    ],
    'Team sports': [
      'Basketball',
      'Football',
      'Volleyball',
      'Soccer',
      'Tennis',
      'Badminton',
      'Hockey',
      'Rugby',
      'Baseball',
      'Ultimate frisbee'
    ],
    'Athletics': [
      'Track and field',
      'Long jump',
      'High jump',
      'Shot put',
      'Discus throw',
      'Javelin throw',
      'Hurdles',
      'Relay races',
      'Pole vault',
      'Triple jump'
    ]
  };

  // Initialize default workouts for a user
  Future<void> initializeDefaultWorkouts() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final userWorkoutsRef = _firestore.collection('users').doc(userId).collection('workouts');
    
    // Check if user already has workouts initialized
    final snapshot = await userWorkoutsRef.limit(1).get();
    if (snapshot.docs.isNotEmpty) return;

    // Initialize default workouts for each category
    for (var category in categories) {
      await userWorkoutsRef.doc(category.toLowerCase().replaceAll(' ', '_')).set({
        'workouts': defaultWorkouts[category],
        'category': category,
      });
    }
  }

  // Get workouts for a specific category
  Future<List<String>> getWorkoutsForCategory(String category) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    try {
      final docSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('workouts')
          .doc(category.toLowerCase().replaceAll(' ', '_'))
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        return List<String>.from(data?['workouts'] ?? []);
      }
      return defaultWorkouts[category] ?? [];
    } catch (e) {
      print('Error getting workouts: $e');
      return [];
    }
  }

  // Add a new workout to a category
  Future<void> addWorkoutToCategory(String category, String workout) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('workouts')
        .doc(category.toLowerCase().replaceAll(' ', '_'));

    await _firestore.runTransaction((transaction) async {
      final docSnapshot = await transaction.get(docRef);
      if (docSnapshot.exists) {
        final currentWorkouts = List<String>.from(docSnapshot.data()?['workouts'] ?? []);
        if (!currentWorkouts.contains(workout)) {
          currentWorkouts.add(workout);
          transaction.update(docRef, {'workouts': currentWorkouts});
        }
      } else {
        transaction.set(docRef, {
          'workouts': [workout],
          'category': category,
        });
      }
    });
  }

  // Remove a workout from a category
  Future<void> removeWorkoutFromCategory(String category, String workout) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('workouts')
        .doc(category.toLowerCase().replaceAll(' ', '_'));

    await _firestore.runTransaction((transaction) async {
      final docSnapshot = await transaction.get(docRef);
      if (docSnapshot.exists) {
        final currentWorkouts = List<String>.from(docSnapshot.data()?['workouts'] ?? []);
        currentWorkouts.remove(workout);
        transaction.update(docRef, {'workouts': currentWorkouts});
      }
    });
  }
} 