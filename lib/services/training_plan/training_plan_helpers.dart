// Training Plan Helpers
// Utility and helper functions for training plans.
// Add any reusable helpers or extensions here.

// TODO: Move low-level helpers from the service here as needed 

// Exercise helpers
extension ExerciseHelpers on Exercise {
  /// Extracts YouTube video ID from various YouTube URL formats
  String? get youtubeVideoId {
    if (youtubeVideoUrl == null || youtubeVideoUrl!.isEmpty) return null;
    final url = youtubeVideoUrl!;
    final patterns = [
      RegExp(r'(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([a-zA-Z0-9_-]{11})'),
      RegExp(r'youtube\.com\/watch\?.*v=([a-zA-Z0-9_-]{11})'),
    ];
    for (final pattern in patterns) {
      final match = pattern.firstMatch(url);
      if (match != null) {
        return match.group(1);
      }
    }
    return null;
  }
  /// Checks if the exercise has a valid YouTube video
  bool get hasVideo => youtubeVideoId != null;
} 

import '../training_plan_models.dart';
import 'training_plan/strength_training_at_home.dart';
import 'training_plan/strength_training_at_the_gym.dart';

final Map<String, Map<String, List<TrainingPlan>>> workoutSpecificPlans = {
  'Strength training at home': strengthTrainingAtHomePlans,
  'Strength training at the gym': strengthTrainingAtTheGymPlans,
  // ... kolejne kategorie
}; 