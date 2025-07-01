import './training_plan_models.dart';
import './default_training_plans.dart';
import 'training_plan/training_plan_repository.dart';
import 'training_plan/workout_categories/strength_training_at_home.dart';
import 'training_plan/workout_categories/strength_training_outdoors.dart';

class TrainingPlanService {
  final TrainingPlanRepository _repository = TrainingPlanRepository();

  // Deleguje do repozytorium
  Future<void> initializeDefaultTrainingPlans() => _repository.initializeDefaultTrainingPlans();
  Future<void> resetAndInitializeTrainingPlans() => _repository.resetAndInitializeTrainingPlans();
  Future<List<TrainingPlan>> getTrainingPlansForWorkout({
    required String category,
    required String workoutName,
  }) => _repository.getTrainingPlansForWorkout(
        category: category,
        workoutName: workoutName,
        workoutSpecificPlans: workoutSpecificPlans,
      );
} 