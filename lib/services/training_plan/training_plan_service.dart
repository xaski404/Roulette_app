// Modular Training Plan Service
// This file is part of the modular training plan system.
// Related files:
//   - training_plan_repository.dart: Firestore CRUD
//   - training_plan_initializer.dart: Default plan initialization
//   - training_plan_helpers.dart: Utility functions
// Models and static data are in ../training_plan_models.dart and ../default_training_plans.dart

import 'training_plan_repository.dart';
import 'training_plan_initializer.dart';
import 'training_plan_helpers.dart';
import '../training_plan_models.dart';

class TrainingPlanService {
  final TrainingPlanRepository repository;
  final TrainingPlanInitializer initializer;
  final Map<String, Map<String, List<TrainingPlan>>> workoutSpecificPlans;

  TrainingPlanService({
    required this.repository,
    required this.initializer,
    required this.workoutSpecificPlans,
  });

  Future<void> initializeDefaultTrainingPlans() async {
    await repository.initializeDefaultTrainingPlans();
  }

  Future<void> resetAndInitializeTrainingPlans() async {
    await repository.resetAndInitializeTrainingPlans();
  }

  Future<List<TrainingPlan>> getTrainingPlansForWorkout({
    required String category,
    required String workoutName,
  }) async {
    return await repository.getTrainingPlansForWorkout(
      category: category,
      workoutName: workoutName,
      workoutSpecificPlans: workoutSpecificPlans,
    );
  }

  // Add more orchestrating methods as needed
}

// ... existing code ...
// REFACTOR: This file has been split for modularity and maintainability.
// See lib/services/training_plan/ for new structure.

// TODO: Remove this file after migration is complete.
// ... existing code ... 