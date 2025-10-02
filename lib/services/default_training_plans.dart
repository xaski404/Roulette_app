import 'training_plan_models.dart';
import 'training_plan/workout_categories/strength_training_at_home.dart';
import 'training_plan/workout_categories/strength_training_outdoors.dart';
import 'training_plan/workout_categories/running.dart';
import 'training_plan/workout_categories/team_sports.dart';
import 'training_plan/workout_categories/athletics.dart';
import 'training_plan/workout_categories/strength_training_at_the_gym.dart';

final Map<String, Map<String, List<TrainingPlan>>> workoutSpecificPlans = {
  'Strength training at home': strengthTrainingAtHomePlans['Strength training at home']!,
  'Strength training outdoors': strengthTrainingOutdoorsPlans['Strength training outdoors']!,
  'Running': runningPlans['Running']!,
  'Team sports': teamSportsPlans['Team sports']!,
  'Athletics': athleticsPlans['Athletics']!,
  'Strength training at the gym': strengthTrainingAtTheGymPlans['Strength training at the gym']!,
}; 