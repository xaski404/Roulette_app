// Training Plan Initializer
// Handles logic for initializing default training plans from maps.
// Uses data from ../default_training_plans.dart and models from ../training_plan_models.dart

import '../default_training_plans.dart';
import '../training_plan_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingPlanInitializer {
  const TrainingPlanInitializer();

  List<TrainingPlan> buildDefaultPlansForUser(String workoutType, String category) {
    // TODO: Implement logic to build default plans from the default_training_plans.dart map
    // Example:
    // return workoutSpecificPlans[workoutType]?[category] ?? [];
    return [];
  }

  // Helper method to initialize training plans data
  Future<void> initializeTrainingPlansData(CollectionReference userTrainingPlansRef, Map<String, Map<String, List<TrainingPlan>>> workoutSpecificPlans) async {
    // Initialize default training plans for each category and workout
    for (var categoryEntry in workoutSpecificPlans.entries) {
      final category = categoryEntry.key;
      final workouts = categoryEntry.value;
      
      for (var workoutEntry in workouts.entries) {
        final workoutName = workoutEntry.key;
        final plans = workoutEntry.value;
        
        await userTrainingPlansRef
            .doc('${category.toLowerCase().replaceAll(' ', '_')}_${workoutName.toLowerCase().replaceAll(' ', '_')}'
            )
            .set({
          'category': category,
          'workoutName': workoutName,
          'plans': plans.map((plan) => plan.toMap()).toList(),
        });
      }
    }
  }

  // Add any private helpers for initialization here
} 