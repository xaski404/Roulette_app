import 'package:flutter/foundation.dart';

class Exercise {
  final String name;
  final int sets;
  final int reps;
  final int restBetweenSets; // in seconds
  final String? youtubeVideoUrl; // YouTube video URL for exercise demonstration
  final String? videoTitle; // Optional title for the video
  final String? videoDescription; // Optional description for the video
  
  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.restBetweenSets,
    this.youtubeVideoUrl,
    this.videoTitle,
    this.videoDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sets': sets,
      'reps': reps,
      'restBetweenSets': restBetweenSets,
      'youtubeVideoUrl': youtubeVideoUrl,
      'videoTitle': videoTitle,
      'videoDescription': videoDescription,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'],
      sets: map['sets'],
      reps: map['reps'],
      restBetweenSets: map['restBetweenSets'],
      youtubeVideoUrl: map['youtubeVideoUrl'],
      videoTitle: map['videoTitle'],
      videoDescription: map['videoDescription'],
    );
  }

  /// Extracts YouTube video ID from various YouTube URL formats
  String? get youtubeVideoId {
    if (youtubeVideoUrl == null || youtubeVideoUrl!.isEmpty) return null;
    final url = youtubeVideoUrl!;
    final patterns = [
      RegExp(r'(?:youtube\.com/watch\?v=|youtu\.be/|youtube\.com/embed/)([a-zA-Z0-9_-]{11})'),
      RegExp(r'youtube\.com/watch\?.*v=([a-zA-Z0-9_-]{11})'),
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