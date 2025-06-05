import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Training plan structure for each exercise
class Exercise {
  final String name;
  final int sets;
  final int reps;
  final int restBetweenSets; // in seconds
  
  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.restBetweenSets,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sets': sets,
      'reps': reps,
      'restBetweenSets': restBetweenSets,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'],
      sets: map['sets'],
      reps: map['reps'],
      restBetweenSets: map['restBetweenSets'],
    );
  }
}

// Training plan structure
class TrainingPlan {
  final String name;
  final List<Exercise> exercises;
  final int restBetweenExercises; // in seconds
  
  TrainingPlan({
    required this.name,
    required this.exercises,
    required this.restBetweenExercises,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'restBetweenExercises': restBetweenExercises,
    };
  }

  factory TrainingPlan.fromMap(Map<String, dynamic> map) {
    return TrainingPlan(
      name: map['name'],
      exercises: (map['exercises'] as List)
          .map((e) => Exercise.fromMap(e as Map<String, dynamic>))
          .toList(),
      restBetweenExercises: map['restBetweenExercises'],
    );
  }
}

class TrainingPlanService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Default training plans for each category
  final Map<String, List<TrainingPlan>> defaultTrainingPlans = {
    'Strength training at the gym': [
      TrainingPlan(
        name: 'Full Body Power',
        exercises: [
          Exercise(name: 'Barbell Squats', sets: 4, reps: 8, restBetweenSets: 90),
          Exercise(name: 'Bench Press', sets: 4, reps: 8, restBetweenSets: 90),
          Exercise(name: 'Bent Over Rows', sets: 4, reps: 10, restBetweenSets: 90),
          Exercise(name: 'Overhead Press', sets: 3, reps: 10, restBetweenSets: 90),
          Exercise(name: 'Romanian Deadlifts', sets: 3, reps: 10, restBetweenSets: 90),
          Exercise(name: 'Lat Pulldowns', sets: 3, reps: 12, restBetweenSets: 60),
          Exercise(name: 'Leg Press', sets: 3, reps: 12, restBetweenSets: 60),
          Exercise(name: 'Plank', sets: 3, reps: 45, restBetweenSets: 45), // reps in seconds
        ],
        restBetweenExercises: 120,
      ),
      TrainingPlan(
        name: 'Upper Body Focus',
        exercises: [
          Exercise(name: 'Incline Dumbbell Press', sets: 4, reps: 10, restBetweenSets: 90),
          Exercise(name: 'Pull-ups', sets: 4, reps: 8, restBetweenSets: 90),
          Exercise(name: 'Military Press', sets: 3, reps: 10, restBetweenSets: 90),
          Exercise(name: 'Cable Rows', sets: 3, reps: 12, restBetweenSets: 60),
          Exercise(name: 'Lateral Raises', sets: 3, reps: 15, restBetweenSets: 60),
          Exercise(name: 'Face Pulls', sets: 3, reps: 15, restBetweenSets: 60),
          Exercise(name: 'Tricep Pushdowns', sets: 3, reps: 12, restBetweenSets: 60),
          Exercise(name: 'Bicep Curls', sets: 3, reps: 12, restBetweenSets: 60),
        ],
        restBetweenExercises: 90,
      ),
    ],
    'Strength training at home': [
      TrainingPlan(
        name: 'Bodyweight Warrior',
        exercises: [
          Exercise(name: 'Push-ups', sets: 4, reps: 12, restBetweenSets: 60),
          Exercise(name: 'Bodyweight Squats', sets: 4, reps: 15, restBetweenSets: 60),
          Exercise(name: 'Inverted Rows', sets: 3, reps: 10, restBetweenSets: 60),
          Exercise(name: 'Pike Push-ups', sets: 3, reps: 10, restBetweenSets: 60),
          Exercise(name: 'Lunges', sets: 3, reps: 12, restBetweenSets: 60),
          Exercise(name: 'Mountain Climbers', sets: 3, reps: 20, restBetweenSets: 45),
          Exercise(name: 'Plank Hold', sets: 3, reps: 45, restBetweenSets: 45), // reps in seconds
          Exercise(name: 'Burpees', sets: 3, reps: 10, restBetweenSets: 60),
        ],
        restBetweenExercises: 90,
      ),
      TrainingPlan(
        name: 'Core and Mobility',
        exercises: [
          Exercise(name: 'Bird Dogs', sets: 3, reps: 12, restBetweenSets: 45),
          Exercise(name: 'Dead Bugs', sets: 3, reps: 12, restBetweenSets: 45),
          Exercise(name: 'Glute Bridges', sets: 3, reps: 15, restBetweenSets: 45),
          Exercise(name: 'Superman Holds', sets: 3, reps: 30, restBetweenSets: 45), // reps in seconds
          Exercise(name: 'Russian Twists', sets: 3, reps: 20, restBetweenSets: 45),
          Exercise(name: 'V-Ups', sets: 3, reps: 12, restBetweenSets: 45),
          Exercise(name: 'Side Planks', sets: 3, reps: 30, restBetweenSets: 45), // reps in seconds
          Exercise(name: 'Hollow Body Hold', sets: 3, reps: 30, restBetweenSets: 45), // reps in seconds
        ],
        restBetweenExercises: 60,
      ),
    ],
    'Strength training outdoors': [
      TrainingPlan(
        name: 'Park Warrior',
        exercises: [
          Exercise(name: 'Pull-ups on Bar', sets: 4, reps: 8, restBetweenSets: 90),
          Exercise(name: 'Dips on Parallel Bars', sets: 4, reps: 10, restBetweenSets: 90),
          Exercise(name: 'Box Jumps', sets: 3, reps: 10, restBetweenSets: 60),
          Exercise(name: 'Step-ups', sets: 3, reps: 12, restBetweenSets: 60),
          Exercise(name: 'Hanging Leg Raises', sets: 3, reps: 12, restBetweenSets: 60),
          Exercise(name: 'Decline Push-ups', sets: 3, reps: 12, restBetweenSets: 60),
          Exercise(name: 'Australian Pull-ups', sets: 3, reps: 12, restBetweenSets: 60),
          Exercise(name: 'Sprints', sets: 6, reps: 30, restBetweenSets: 60), // reps in meters
        ],
        restBetweenExercises: 90,
      ),
    ],
    'Running': [
      TrainingPlan(
        name: 'Speed and Endurance',
        exercises: [
          Exercise(name: 'Dynamic Warm-up', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          Exercise(name: '400m Sprint Intervals', sets: 6, reps: 400, restBetweenSets: 120), // reps in meters
          Exercise(name: 'Recovery Jog', sets: 5, reps: 200, restBetweenSets: 0), // reps in meters
          Exercise(name: 'Hill Sprints', sets: 6, reps: 100, restBetweenSets: 90), // reps in meters
          Exercise(name: 'Tempo Run', sets: 1, reps: 2000, restBetweenSets: 0), // reps in meters
          Exercise(name: 'Cool Down Jog', sets: 1, reps: 800, restBetweenSets: 0), // reps in meters
        ],
        restBetweenExercises: 180,
      ),
    ],
    'Team sports': [
      TrainingPlan(
        name: 'Agility and Power',
        exercises: [
          Exercise(name: 'Ladder Drills', sets: 3, reps: 20, restBetweenSets: 60), // reps in seconds
          Exercise(name: 'Cone Sprints', sets: 4, reps: 30, restBetweenSets: 60), // reps in meters
          Exercise(name: 'Box Jumps', sets: 4, reps: 8, restBetweenSets: 60),
          Exercise(name: 'Medicine Ball Throws', sets: 3, reps: 10, restBetweenSets: 60),
          Exercise(name: 'Shuttle Runs', sets: 4, reps: 40, restBetweenSets: 90), // reps in meters
          Exercise(name: 'Plyometric Lunges', sets: 3, reps: 12, restBetweenSets: 60),
          Exercise(name: 'T-Drill', sets: 3, reps: 30, restBetweenSets: 90), // reps in seconds
          Exercise(name: 'Reaction Drills', sets: 4, reps: 30, restBetweenSets: 60), // reps in seconds
        ],
        restBetweenExercises: 120,
      ),
    ],
    'Athletics': [
      TrainingPlan(
        name: 'Track and Field',
        exercises: [
          Exercise(name: 'Dynamic Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          Exercise(name: 'Sprint Technique Drills', sets: 3, reps: 50, restBetweenSets: 60), // reps in meters
          Exercise(name: 'Explosive Starts', sets: 6, reps: 20, restBetweenSets: 90), // reps in meters
          Exercise(name: 'Plyometric Bounds', sets: 4, reps: 8, restBetweenSets: 90),
          Exercise(name: 'Medicine Ball Power Throws', sets: 3, reps: 10, restBetweenSets: 60),
          Exercise(name: 'Speed Endurance Runs', sets: 4, reps: 200, restBetweenSets: 120), // reps in meters
          Exercise(name: 'Form Running', sets: 3, reps: 100, restBetweenSets: 60), // reps in meters
          Exercise(name: 'Cool Down', sets: 1, reps: 10, restBetweenSets: 0), // minutes
        ],
        restBetweenExercises: 120,
      ),
    ],
  };

  // Initialize default training plans for a user
  Future<void> initializeDefaultTrainingPlans() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final userTrainingPlansRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('training_plans');
    
    // Check if user already has training plans initialized
    final snapshot = await userTrainingPlansRef.limit(1).get();
    if (snapshot.docs.isNotEmpty) return;

    // Initialize default training plans for each category
    for (var entry in defaultTrainingPlans.entries) {
      final category = entry.key;
      final plans = entry.value;
      
      await userTrainingPlansRef
          .doc(category.toLowerCase().replaceAll(' ', '_'))
          .set({
        'category': category,
        'plans': plans.map((plan) => plan.toMap()).toList(),
      });
    }
  }

  // Get training plans for a specific category
  Future<List<TrainingPlan>> getTrainingPlansForCategory(String category) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    try {
      final docSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('training_plans')
          .doc(category.toLowerCase().replaceAll(' ', '_'))
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        final plansList = data?['plans'] as List<dynamic>;
        return plansList.map((plan) => TrainingPlan.fromMap(plan)).toList();
      }
      return defaultTrainingPlans[category] ?? [];
    } catch (e) {
      print('Error getting training plans: $e');
      return [];
    }
  }
} 