// Training Plan Repository
// Handles all Firestore CRUD operations for training plans.
// Models are in ../training_plan_models.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../training_plan_models.dart';

class TrainingPlanRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Get user ID
  String? get userId => _auth.currentUser?.uid;

  // Initialize default training plans for a user
  Future<void> initializeDefaultTrainingPlans() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final userTrainingPlansRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('workout_training_plans');
    
    // Check if user already has training plans initialized
    final snapshot = await userTrainingPlansRef.limit(1).get();
    if (snapshot.docs.isNotEmpty) return;

    // Call initializer (to be injected)
    // await initializer._initializeTrainingPlansData(userTrainingPlansRef);
  }

  // Reset and reinitialize training plans (for updating with videos)
  Future<void> resetAndInitializeTrainingPlans() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final userTrainingPlansRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('workout_training_plans');
    
    // Delete existing data
    final snapshot = await userTrainingPlansRef.get();
    final batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();

    // Call initializer (to be injected)
    // await initializer._initializeTrainingPlansData(userTrainingPlansRef);
  }

  // Get training plans for a specific workout
  Future<List<TrainingPlan>> getTrainingPlansForWorkout({
    required String category,
    required String workoutName,
    required Map<String, Map<String, List<TrainingPlan>>> workoutSpecificPlans,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    try {
      final docSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('workout_training_plans')
          .doc('${category.toLowerCase().replaceAll(' ', '_')}_${workoutName.toLowerCase().replaceAll(' ', '_')}'
          )
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        final plansList = data?['plans'] as List<dynamic>;
        return plansList.map((plan) => TrainingPlan.fromMap(plan as Map<String, dynamic>)).toList();
      }

      // If no specific plan exists, return the default plans for this workout
      return workoutSpecificPlans[category]?[workoutName] ?? [];
    } catch (e) {
      print('Error getting training plans: $e');
      return [];
    }
  }

  Future<void> saveUserPlan(String userId, TrainingPlan plan) async {
    // TODO: Implement Firestore logic to save a user's training plan
  }

  Future<List<TrainingPlan>> fetchUserPlans(String userId) async {
    // TODO: Implement Firestore logic to fetch all training plans for a user
    return [];
  }

  Future<void> deleteUserPlan(String userId, String planId) async {
    // TODO: Implement Firestore logic to delete a user's training plan
  }

  // Add more CRUD methods as needed
} 