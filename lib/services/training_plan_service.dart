import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Training plan structure for each exercise
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
    
    // Handle different YouTube URL formats
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

  // Default training plans for specific workouts
  final Map<String, Map<String, List<TrainingPlan>>> workoutSpecificPlans = {
    'Strength training at the gym': {
      'Full body workout': [
        TrainingPlan(
          name: 'Full Body Strength',
          exercises: [
            Exercise(
              name: 'Barbell Back Squats',
              sets: 4,
              reps: 8,
              restBetweenSets: 90,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=SW_C1A-rejs',
              videoTitle: 'Proper Barbell Back Squat Form',
              videoDescription: 'Learn the correct form for barbell back squats with proper depth and technique.',
            ),
            Exercise(
              name: 'Bench Press',
              sets: 4,
              reps: 8,
              restBetweenSets: 90,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=rT7DgCr-3pg',
              videoTitle: 'Bench Press Tutorial',
              videoDescription: 'Master the bench press with proper form and breathing technique.',
            ),
            Exercise(
              name: 'Deadlifts',
              sets: 4,
              reps: 8,
              restBetweenSets: 120,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=1ZXobu7JvvE',
              videoTitle: 'Deadlift Form Guide',
              videoDescription: 'Learn proper deadlift form to prevent injury and maximize strength gains.',
            ),
            Exercise(
              name: 'Pull-ups',
              sets: 3,
              reps: 10,
              restBetweenSets: 90,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=eGo4IYlbE5g',
              videoTitle: 'Pull-up Progression',
              videoDescription: 'Master pull-ups with proper form and progression techniques.',
            ),
            Exercise(
              name: 'Overhead Press',
              sets: 3,
              reps: 10,
              restBetweenSets: 90,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=2yjwXTZQDDg',
              videoTitle: 'Overhead Press Tutorial',
              videoDescription: 'Learn the military press with proper form and breathing.',
            ),
            Exercise(
              name: 'Barbell Rows',
              sets: 3,
              reps: 10,
              restBetweenSets: 90,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=G8l_8chR5BE',
              videoTitle: 'Barbell Row Form',
              videoDescription: 'Master the barbell row for a strong back and proper posture.',
            ),
            Exercise(
              name: 'Dips',
              sets: 3,
              reps: 12,
              restBetweenSets: 60,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=2z8JmcrW-As',
              videoTitle: 'Dips Tutorial',
              videoDescription: 'Learn proper dip form for chest and tricep development.',
            ),
            Exercise(
              name: 'Plank',
              sets: 3,
              reps: 45,
              restBetweenSets: 45,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=ASdvN_XEl_c',
              videoTitle: 'Perfect Plank Form',
              videoDescription: 'Master the plank for core strength and stability.',
            ),
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Upper body focus': [
        TrainingPlan(
          name: 'Upper Body Power',
          exercises: [
            Exercise(name: 'Incline Bench Press', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Weighted Pull-ups', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Standing Military Press', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Barbell Rows', sets: 4, reps: 10, restBetweenSets: 90),
            Exercise(name: 'Lateral Raises', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Face Pulls', sets: 3, reps: 15, restBetweenSets: 60),
            Exercise(name: 'Skull Crushers', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Hammer Curls', sets: 3, reps: 12, restBetweenSets: 60),
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Lower body focus': [
        TrainingPlan(
          name: 'Lower Body Power',
          exercises: [
            Exercise(name: 'Back Squats', sets: 5, reps: 5, restBetweenSets: 120),
            Exercise(name: 'Romanian Deadlifts', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Bulgarian Split Squats', sets: 3, reps: 12, restBetweenSets: 90),
            Exercise(name: 'Leg Press', sets: 4, reps: 10, restBetweenSets: 90),
            Exercise(name: 'Walking Lunges', sets: 3, reps: 20, restBetweenSets: 90),
            Exercise(name: 'Calf Raises', sets: 4, reps: 15, restBetweenSets: 60),
            Exercise(name: 'Leg Extensions', sets: 3, reps: 15, restBetweenSets: 60),
            Exercise(name: 'Leg Curls', sets: 3, reps: 15, restBetweenSets: 60),
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Push day': [
        TrainingPlan(
          name: 'Push Power',
          exercises: [
            Exercise(name: 'Flat Barbell Bench Press', sets: 4, reps: 8, restBetweenSets: 120),
            Exercise(name: 'Standing Military Press', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Incline Dumbbell Press', sets: 3, reps: 10, restBetweenSets: 90),
            Exercise(name: 'Lateral Raises', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Tricep Rope Pushdowns', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Dips', sets: 3, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Front Raises', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Tricep Overhead Extensions', sets: 3, reps: 12, restBetweenSets: 60),
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Pull day': [
        TrainingPlan(
          name: 'Pull Power',
          exercises: [
            Exercise(name: 'Deadlifts', sets: 4, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Weighted Pull-ups', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Barbell Rows', sets: 3, reps: 10, restBetweenSets: 90),
            Exercise(name: 'Face Pulls', sets: 3, reps: 15, restBetweenSets: 60),
            Exercise(name: 'Barbell Curls', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Hammer Curls', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Lat Pulldowns', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Reverse Flyes', sets: 3, reps: 15, restBetweenSets: 60),
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Leg day': [
        TrainingPlan(
          name: 'Leg Power',
          exercises: [
            Exercise(name: 'Back Squats', sets: 5, reps: 5, restBetweenSets: 120),
            Exercise(name: 'Romanian Deadlifts', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Leg Press', sets: 4, reps: 10, restBetweenSets: 90),
            Exercise(name: 'Bulgarian Split Squats', sets: 3, reps: 12, restBetweenSets: 90),
            Exercise(name: 'Leg Extensions', sets: 3, reps: 15, restBetweenSets: 60),
            Exercise(name: 'Leg Curls', sets: 3, reps: 15, restBetweenSets: 60),
            Exercise(name: 'Standing Calf Raises', sets: 4, reps: 15, restBetweenSets: 45),
            Exercise(name: 'Seated Calf Raises', sets: 3, reps: 20, restBetweenSets: 45),
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Core workout': [
        TrainingPlan(
          name: 'Core Strength',
          exercises: [
            Exercise(name: 'Weighted Planks', sets: 3, reps: 45, restBetweenSets: 60), // reps in seconds
            Exercise(name: 'Cable Woodchoppers', sets: 3, reps: 12, restBetweenSets: 45),
            Exercise(name: 'Hanging Leg Raises', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Ab Wheel Rollouts', sets: 3, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Cable Crunches', sets: 3, reps: 15, restBetweenSets: 45),
            Exercise(name: 'Russian Twists', sets: 3, reps: 20, restBetweenSets: 45),
            Exercise(name: 'Dragon Flags', sets: 3, reps: 8, restBetweenSets: 60),
            Exercise(name: 'Pallof Press', sets: 3, reps: 12, restBetweenSets: 45),
          ],
          restBetweenExercises: 60,
        ),
      ],
      'HIIT circuit': [
        TrainingPlan(
          name: 'High Intensity Circuit',
          exercises: [
            Exercise(name: 'Battle Rope Waves', sets: 4, reps: 30, restBetweenSets: 30), // reps in seconds
            Exercise(name: 'Kettlebell Swings', sets: 4, reps: 20, restBetweenSets: 30),
            Exercise(name: 'Box Jumps', sets: 4, reps: 12, restBetweenSets: 30),
            Exercise(name: 'Burpees', sets: 4, reps: 10, restBetweenSets: 30),
            Exercise(name: 'Medicine Ball Slams', sets: 4, reps: 15, restBetweenSets: 30),
            Exercise(name: 'Rowing Sprints', sets: 4, reps: 200, restBetweenSets: 45), // reps in meters
            Exercise(name: 'Mountain Climbers', sets: 4, reps: 30, restBetweenSets: 30),
            Exercise(name: 'Jump Rope', sets: 4, reps: 50, restBetweenSets: 30),
          ],
          restBetweenExercises: 60,
        ),
      ],
      'Powerlifting session': [
        TrainingPlan(
          name: 'Power Development',
          exercises: [
            Exercise(name: 'Dynamic Warm-up & Mobility', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Back Squat (Progressive: 60-75-85-90% 1RM)', sets: 4, reps: 5, restBetweenSets: 180),
            Exercise(name: 'Bench Press (Progressive: 60-75-85-90% 1RM)', sets: 4, reps: 5, restBetweenSets: 180),
            Exercise(name: 'Deadlift (Progressive: 60-75-85-90% 1RM)', sets: 4, reps: 3, restBetweenSets: 240),
            Exercise(name: 'Accessory: Rows', sets: 3, reps: 8, restBetweenSets: 120),
            Exercise(name: 'Accessory: Core Work', sets: 3, reps: 12, restBetweenSets: 90),
            Exercise(name: 'Technique Practice (Light Weight)', sets: 2, reps: 5, restBetweenSets: 120),
            Exercise(name: 'Cool Down & Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 240,
        ),
      ],
      'Strength and cardio mix': [
        TrainingPlan(
          name: 'Hybrid Performance',
          exercises: [
            Exercise(name: 'Dynamic Warm-up Circuit', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Heavy Compound Lift (Squat/Deadlift)', sets: 4, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Rowing Sprint', sets: 3, reps: 250, restBetweenSets: 90), // meters
            Exercise(name: 'Upper Body Push/Pull Superset', sets: 3, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Box Jumps', sets: 3, reps: 8, restBetweenSets: 60),
            Exercise(name: 'Battle Rope Intervals', sets: 4, reps: 30, restBetweenSets: 45), // seconds
            Exercise(name: 'Kettlebell Complex', sets: 3, reps: 6, restBetweenSets: 90),
            Exercise(name: 'Cool Down Cardio', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
    },
    'Strength training at home': {
      'Bodyweight circuit': [
        TrainingPlan(
          name: 'Bodyweight Intensity',
          exercises: [
            Exercise(
              name: 'Diamond Push-ups',
              sets: 4,
              reps: 12,
              restBetweenSets: 60,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=J0DnG1_S92I',
              videoTitle: 'Diamond Push-ups Tutorial',
              videoDescription: 'Jak poprawnie wykonać Diamond Push-ups – technika i wskazówki.',
            ),
            Exercise(
              name: 'Jump Squats',
              sets: 4,
              reps: 15,
              restBetweenSets: 60,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=U4s4mEQ5VqU',
              videoTitle: 'Jump Squats Tutorial',
              videoDescription: 'Technika wykonywania Jump Squats – ćwiczenie na moc i dynamikę.',
            ),
            Exercise(
              name: 'Pull-ups',
              sets: 3,
              reps: 8,
              restBetweenSets: 90,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=eGo4IYlbE5g',
              videoTitle: 'Pull-ups Tutorial',
              videoDescription: 'Jak poprawnie wykonać podciągnięcia na drążku.',
            ),
            Exercise(
              name: 'Pike Push-ups',
              sets: 3,
              reps: 12,
              restBetweenSets: 60,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=F3QY5vMz_6I',
              videoTitle: 'Pike Push-ups Tutorial',
              videoDescription: 'Pike Push-ups – instrukcja i najczęstsze błędy.',
            ),
            Exercise(
              name: 'Pistol Squats',
              sets: 3,
              reps: 8,
              restBetweenSets: 90,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=U3HlEF_E9fo',
              videoTitle: 'Pistol Squats Tutorial',
              videoDescription: 'Jak nauczyć się i poprawnie wykonać Pistol Squat.',
            ),
            Exercise(
              name: 'Burpees',
              sets: 3,
              reps: 15,
              restBetweenSets: 60,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=TU8QYVW0gDU',
              videoTitle: 'Burpees Tutorial',
              videoDescription: 'Burpees – pełna technika i wskazówki.',
            ),
            Exercise(
              name: 'L-Sits',
              sets: 3,
              reps: 20,
              restBetweenSets: 60,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=Qn5P9M_Dl5w',
              videoTitle: 'L-Sit Tutorial',
              videoDescription: 'Jak wykonać L-Sit na podłodze lub poręczach.',
            ),
            Exercise(
              name: 'Mountain Climbers',
              sets: 3,
              reps: 30,
              restBetweenSets: 45,
              youtubeVideoUrl: 'https://www.youtube.com/watch?v=nmwgirgXLYM',
              videoTitle: 'Mountain Climbers Tutorial',
              videoDescription: 'Mountain Climbers – poprawna technika i warianty.',
            ),
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Core and abs': [
        TrainingPlan(
          name: 'Core Home Workout',
          exercises: [
            Exercise(name: 'Plank Hold', sets: 3, reps: 60, restBetweenSets: 45), // reps in seconds
            Exercise(name: 'Bicycle Crunches', sets: 3, reps: 30, restBetweenSets: 45),
            Exercise(name: 'Mountain Climbers', sets: 3, reps: 40, restBetweenSets: 45),
            Exercise(name: 'V-Ups', sets: 3, reps: 15, restBetweenSets: 45),
            Exercise(name: 'Russian Twists', sets: 3, reps: 30, restBetweenSets: 45),
            Exercise(name: 'Leg Raises', sets: 3, reps: 15, restBetweenSets: 45),
            Exercise(name: 'Side Plank Holds', sets: 3, reps: 30, restBetweenSets: 45), // reps in seconds
            Exercise(name: 'Flutter Kicks', sets: 3, reps: 30, restBetweenSets: 45),
          ],
          restBetweenExercises: 60,
        ),
      ],
      'Upper body focus': [
        TrainingPlan(
          name: 'Upper Body Home',
          exercises: [
            Exercise(name: 'Push-ups', sets: 4, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Diamond Push-ups', sets: 3, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Pike Push-ups', sets: 3, reps: 8, restBetweenSets: 60),
            Exercise(name: 'Inverted Rows', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Wide Push-ups', sets: 3, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Tricep Dips', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Wall Handstand Hold', sets: 3, reps: 30, restBetweenSets: 60), // reps in seconds
            Exercise(name: 'Plank to Downward Dog', sets: 3, reps: 10, restBetweenSets: 45),
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Lower body focus': [
        TrainingPlan(
          name: 'Lower Body Home',
          exercises: [
            Exercise(name: 'Bodyweight Squats', sets: 4, reps: 20, restBetweenSets: 60),
            Exercise(name: 'Walking Lunges', sets: 4, reps: 24, restBetweenSets: 60),
            Exercise(name: 'Jump Squats', sets: 3, reps: 15, restBetweenSets: 60),
            Exercise(name: 'Single Leg Bridge', sets: 3, reps: 12, restBetweenSets: 45),
            Exercise(name: 'Wall Sit', sets: 3, reps: 45, restBetweenSets: 45), // reps in seconds
            Exercise(name: 'Calf Raises', sets: 4, reps: 25, restBetweenSets: 45),
            Exercise(name: 'Step-ups', sets: 3, reps: 15, restBetweenSets: 45),
            Exercise(name: 'Pistol Squat Progression', sets: 3, reps: 8, restBetweenSets: 60),
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Squat variations': [
        TrainingPlan(
          name: 'Lower Body Power',
          exercises: [
            Exercise(name: 'Joint Mobility Warm-up', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Bodyweight Squats', sets: 3, reps: 20, restBetweenSets: 60),
            Exercise(name: 'Jump Squats', sets: 3, reps: 12, restBetweenSets: 90),
            Exercise(name: 'Split Squats', sets: 3, reps: 12, restBetweenSets: 60), // each leg
            Exercise(name: 'Pistol Squat Progression', sets: 4, reps: 5, restBetweenSets: 90), // each leg
            Exercise(name: 'Pulse Squats', sets: 3, reps: 30, restBetweenSets: 60), // seconds
            Exercise(name: 'Wall Sit Hold', sets: 3, reps: 45, restBetweenSets: 45), // seconds
            Exercise(name: 'Cool Down Stretches', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Dumbbell routine': [
        TrainingPlan(
          name: 'Full Body Dumbbell',
          exercises: [
            Exercise(name: 'Dynamic Warm-up', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'DB Romanian Deadlifts', sets: 4, reps: 12, restBetweenSets: 90),
            Exercise(name: 'DB Floor Press', sets: 4, reps: 12, restBetweenSets: 90),
            Exercise(name: 'DB Renegade Rows', sets: 3, reps: 10, restBetweenSets: 60), // each side
            Exercise(name: 'DB Walking Lunges', sets: 3, reps: 20, restBetweenSets: 90), // steps total
            Exercise(name: 'DB Shoulder Press', sets: 3, reps: 12, restBetweenSets: 90),
            Exercise(name: 'DB Farmer\'s Walk', sets: 3, reps: 30, restBetweenSets: 60), // meters
            Exercise(name: 'Cool Down & Stretch', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Push-up variations': [
        TrainingPlan(
          name: 'Push-up Power',
          exercises: [
            Exercise(name: 'Upper Body Warm-up', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Standard Push-ups', sets: 4, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Diamond Push-ups', sets: 3, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Wide Push-ups', sets: 3, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Decline Push-ups', sets: 3, reps: 8, restBetweenSets: 60),
            Exercise(name: 'Explosive Push-ups', sets: 3, reps: 6, restBetweenSets: 90),
            Exercise(name: 'Push-up Hold', sets: 3, reps: 30, restBetweenSets: 45), // seconds
            Exercise(name: 'Mobility Work', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Full body HIIT': [
        TrainingPlan(
          name: 'High Intensity Home',
          exercises: [
            Exercise(name: 'Dynamic Warm-up', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Burpee Sprint Combo', sets: 4, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'Mountain Climber to Push-up', sets: 4, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'Squat Jump to Lunge', sets: 4, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'Plank to Pike Jump', sets: 4, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'High Knees to Tuck Jump', sets: 4, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'Bear Crawl to Sprawl', sets: 4, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'Cool Down & Stretch', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 60,
        ),
      ],
    },
    'Running': {
      'Long distance run': [
        TrainingPlan(
          name: 'Endurance Builder',
          exercises: [
            Exercise(name: 'Dynamic Warm-up (leg swings, lunges, skips)', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Easy Pace Run (Zone 2, 60-70% max HR)', sets: 1, reps: 5000, restBetweenSets: 0), // meters
            Exercise(name: 'Tempo Run (Zone 3, 70-80% max HR)', sets: 1, reps: 3000, restBetweenSets: 180), // meters
            Exercise(name: 'Easy Pace Run (Zone 2)', sets: 1, reps: 2000, restBetweenSets: 0), // meters
            Exercise(name: 'Strides (90% effort)', sets: 4, reps: 100, restBetweenSets: 60), // meters
            Exercise(name: 'Cool Down Jog (Zone 1, <60% max HR)', sets: 1, reps: 1000, restBetweenSets: 0), // meters
            Exercise(name: 'Walking', sets: 1, reps: 500, restBetweenSets: 0), // meters
            Exercise(name: 'Static Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Sprint intervals': [
        TrainingPlan(
          name: 'Speed Development',
          exercises: [
            Exercise(name: 'Dynamic Warm-up (high knees, butt kicks, leg swings)', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Light Jog (Zone 2)', sets: 1, reps: 800, restBetweenSets: 0), // meters
            Exercise(name: '100m Sprints (95% max effort)', sets: 6, reps: 100, restBetweenSets: 90), // meters
            Exercise(name: '200m Sprints (90% max effort)', sets: 4, reps: 200, restBetweenSets: 120), // meters
            Exercise(name: '400m Sprints (85% max effort)', sets: 2, reps: 400, restBetweenSets: 180), // meters
            Exercise(name: 'Recovery Jog (Zone 1)', sets: 1, reps: 400, restBetweenSets: 0), // meters
            Exercise(name: 'Walking Cool Down', sets: 1, reps: 400, restBetweenSets: 0), // meters
            Exercise(name: 'Cool Down Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 180,
        ),
      ],
      'Hill repeats': [
        TrainingPlan(
          name: 'Hill Power',
          exercises: [
            Exercise(name: 'Dynamic Warm-up (mobility work)', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Easy Jog to Hills (Zone 2)', sets: 1, reps: 1000, restBetweenSets: 0), // meters
            Exercise(name: 'Short Hill Sprints (30-45° incline, 90% effort)', sets: 6, reps: 60, restBetweenSets: 120), // meters
            Exercise(name: 'Medium Hill Climbs (85% effort)', sets: 4, reps: 100, restBetweenSets: 150), // meters
            Exercise(name: 'Long Hill Climbs (80% effort)', sets: 3, reps: 200, restBetweenSets: 180), // meters
            Exercise(name: 'Jog Down Recovery', sets: 13, reps: 1, restBetweenSets: 0), // per climb
            Exercise(name: 'Flat Ground Cool Down Jog', sets: 1, reps: 800, restBetweenSets: 0), // meters
            Exercise(name: 'Recovery Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Fartlek training': [
        TrainingPlan(
          name: 'Speed Play',
          exercises: [
            Exercise(name: 'Dynamic Warm-up', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Easy Pace Warm-up (Zone 2)', sets: 1, reps: 1000, restBetweenSets: 0), // meters
            Exercise(name: 'Hard Effort (85-90% max HR)', sets: 8, reps: 2, restBetweenSets: 0), // minutes
            Exercise(name: 'Easy Effort Recovery (Zone 2)', sets: 8, reps: 1, restBetweenSets: 0), // minutes
            Exercise(name: 'Medium Effort (75-80% max HR)', sets: 4, reps: 3, restBetweenSets: 0), // minutes
            Exercise(name: 'Easy Recovery (Zone 2)', sets: 4, reps: 2, restBetweenSets: 0), // minutes
            Exercise(name: 'Cool Down Jog', sets: 1, reps: 800, restBetweenSets: 0), // meters
            Exercise(name: 'Recovery Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 60,
        ),
      ],
      'Trail running': [
        TrainingPlan(
          name: 'Trail Adventure',
          exercises: [
            Exercise(name: 'Dynamic Trail Warm-up', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Technical Trail Section', sets: 1, reps: 2000, restBetweenSets: 120), // meters
            Exercise(name: 'Hill Climb Progression', sets: 3, reps: 400, restBetweenSets: 180), // meters
            Exercise(name: 'Technical Descent Practice', sets: 3, reps: 400, restBetweenSets: 120), // meters
            Exercise(name: 'Mixed Terrain Running', sets: 1, reps: 3000, restBetweenSets: 180), // meters
            Exercise(name: 'Trail Sprint Sections', sets: 4, reps: 100, restBetweenSets: 90), // meters
            Exercise(name: 'Easy Trail Cool Down', sets: 1, reps: 1000, restBetweenSets: 0), // meters
            Exercise(name: 'Post-Trail Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 180,
        ),
      ],
      'Recovery run': [
        TrainingPlan(
          name: 'Active Recovery',
          exercises: [
            Exercise(name: 'Light Dynamic Stretching', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Easy Pace Walk', sets: 1, reps: 400, restBetweenSets: 0), // meters
            Exercise(name: 'Zone 1 Easy Jog', sets: 1, reps: 2000, restBetweenSets: 0), // meters
            Exercise(name: 'Walking Break', sets: 1, reps: 200, restBetweenSets: 0), // meters
            Exercise(name: 'Zone 1-2 Light Run', sets: 1, reps: 1500, restBetweenSets: 0), // meters
            Exercise(name: 'Form Drills', sets: 2, reps: 50, restBetweenSets: 60), // meters
            Exercise(name: 'Easy Cool Down Jog', sets: 1, reps: 800, restBetweenSets: 0), // meters
            Exercise(name: 'Gentle Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 60,
        ),
      ],
      'City exploration run': [
        TrainingPlan(
          name: 'Urban Explorer',
          exercises: [
            Exercise(name: 'Dynamic Urban Warm-up', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Easy Pace Exploration', sets: 1, reps: 2000, restBetweenSets: 60), // meters
            Exercise(name: 'City Stairs Circuit', sets: 3, reps: 50, restBetweenSets: 90), // steps
            Exercise(name: 'Urban Fartlek', sets: 6, reps: 400, restBetweenSets: 120), // meters
            Exercise(name: 'Landmark Sprint Intervals', sets: 4, reps: 200, restBetweenSets: 90), // meters
            Exercise(name: 'Urban Obstacle Navigation', sets: 1, reps: 1500, restBetweenSets: 0), // meters
            Exercise(name: 'Easy Pace Return', sets: 1, reps: 1000, restBetweenSets: 0), // meters
            Exercise(name: 'Cool Down Walk', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Beach run': [
        TrainingPlan(
          name: 'Sand Runner',
          exercises: [
            Exercise(name: 'Beach Mobility Warm-up', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Soft Sand Walk', sets: 1, reps: 800, restBetweenSets: 0), // meters
            Exercise(name: 'Firm Sand Progressive Run', sets: 1, reps: 2000, restBetweenSets: 120), // meters
            Exercise(name: 'Soft Sand Intervals', sets: 6, reps: 100, restBetweenSets: 90), // meters
            Exercise(name: 'Water Line Tempo', sets: 1, reps: 1500, restBetweenSets: 120), // meters
            Exercise(name: 'Beach Shuttle Runs', sets: 4, reps: 50, restBetweenSets: 60), // meters
            Exercise(name: 'Easy Sand Cool Down', sets: 1, reps: 800, restBetweenSets: 0), // meters
            Exercise(name: 'Beach Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Tempo run': [
        TrainingPlan(
          name: 'Speed Builder',
          exercises: [
            Exercise(name: 'Dynamic Running Warm-up', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Easy Pace Warm-up', sets: 1, reps: 1500, restBetweenSets: 0), // meters
            Exercise(name: 'Progressive Tempo (75-85% max)', sets: 3, reps: 1000, restBetweenSets: 180), // meters
            Exercise(name: 'Recovery Jog', sets: 2, reps: 400, restBetweenSets: 0), // meters
            Exercise(name: 'Fast Finish Tempo', sets: 1, reps: 800, restBetweenSets: 0), // meters
            Exercise(name: 'Form Strides', sets: 4, reps: 100, restBetweenSets: 60), // meters
            Exercise(name: 'Easy Cool Down', sets: 1, reps: 1000, restBetweenSets: 0), // meters
            Exercise(name: 'Post-Run Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Park run': [
        TrainingPlan(
          name: 'Park Pacer',
          exercises: [
            Exercise(name: 'Dynamic Park Warm-up', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Easy Lap Warm-up', sets: 1, reps: 1000, restBetweenSets: 0), // meters
            Exercise(name: 'Park Loop Progression', sets: 3, reps: 800, restBetweenSets: 120), // meters
            Exercise(name: 'Grass Surface Intervals', sets: 6, reps: 200, restBetweenSets: 90), // meters
            Exercise(name: 'Path Tempo Sections', sets: 2, reps: 1000, restBetweenSets: 180), // meters
            Exercise(name: 'Hill Repeats', sets: 4, reps: 100, restBetweenSets: 90), // meters
            Exercise(name: 'Easy Recovery Loop', sets: 1, reps: 800, restBetweenSets: 0), // meters
            Exercise(name: 'Cool Down & Stretch', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
    },
    'Team sports': {
      'Basketball': [
        TrainingPlan(
          name: 'Basketball Conditioning',
          exercises: [
            Exercise(name: 'Dynamic Warm-up (ankle mobility, hip flexors)', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Defensive Slides (both directions)', sets: 4, reps: 30, restBetweenSets: 45), // seconds
            Exercise(name: 'Sprint-Backpedal-Sprint (baseline to baseline)', sets: 4, reps: 40, restBetweenSets: 45), // seconds
            Exercise(name: 'Box Jumps (explosive power)', sets: 3, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Ladder Drills (footwork)', sets: 3, reps: 30, restBetweenSets: 45), // seconds
            Exercise(name: 'Suicide Runs (full court)', sets: 4, reps: 1, restBetweenSets: 90),
            Exercise(name: 'Jump Rope (active recovery)', sets: 3, reps: 60, restBetweenSets: 45), // seconds
            Exercise(name: 'Cool Down Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Volleyball': [
        TrainingPlan(
          name: 'Volleyball Power & Agility',
          exercises: [
            Exercise(name: 'Dynamic Warm-up (shoulder mobility focus)', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Jump Training (block jumps)', sets: 4, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Approach Jump Practice', sets: 4, reps: 8, restBetweenSets: 60),
            Exercise(name: 'Lateral Shuffle with Ball Control', sets: 3, reps: 30, restBetweenSets: 45), // seconds
            Exercise(name: 'Quick Direction Changes', sets: 4, reps: 20, restBetweenSets: 45), // seconds
            Exercise(name: 'Diving Practice (both sides)', sets: 3, reps: 6, restBetweenSets: 60),
            Exercise(name: 'Service Line Sprints', sets: 4, reps: 6, restBetweenSets: 45),
            Exercise(name: 'Cool Down & Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Soccer': [
        TrainingPlan(
          name: 'Soccer Endurance & Skills',
          exercises: [
            Exercise(name: 'Dynamic Warm-up (leg focus)', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Cone Dribbling (figure 8s)', sets: 4, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'Sprint-Dribble-Pass Drill', sets: 4, reps: 30, restBetweenSets: 45), // seconds
            Exercise(name: 'Box-to-Box Runs (with ball)', sets: 6, reps: 50, restBetweenSets: 45), // meters
            Exercise(name: 'Shooting Practice (after sprint)', sets: 3, reps: 8, restBetweenSets: 60),
            Exercise(name: 'Small Area Speed Work', sets: 4, reps: 30, restBetweenSets: 45), // seconds
            Exercise(name: 'Agility Course with Ball', sets: 3, reps: 60, restBetweenSets: 60), // seconds
            Exercise(name: 'Cool Down Jog & Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Tennis': [
        TrainingPlan(
          name: 'Tennis Agility & Power',
          exercises: [
            Exercise(name: 'Dynamic Warm-up (upper & lower body)', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Spider Drill (court corners)', sets: 4, reps: 45, restBetweenSets: 45), // seconds
            Exercise(name: 'Lateral Shuffle with Shadow Swings', sets: 4, reps: 30, restBetweenSets: 30), // seconds
            Exercise(name: 'Split-Step Practice', sets: 3, reps: 20, restBetweenSets: 30),
            Exercise(name: 'Service Line Sprints', sets: 4, reps: 8, restBetweenSets: 45),
            Exercise(name: 'Cross-Court Movement', sets: 3, reps: 40, restBetweenSets: 45), // seconds
            Exercise(name: 'Medicine Ball Rotations', sets: 3, reps: 12, restBetweenSets: 45),
            Exercise(name: 'Cool Down & Flexibility', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Badminton': [
        TrainingPlan(
          name: 'Court Agility',
          exercises: [
            Exercise(name: 'Dynamic Badminton Warm-up', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Footwork Pattern Drills', sets: 4, reps: 2, restBetweenSets: 60), // minutes
            Exercise(name: 'Shadow Racket Work', sets: 4, reps: 2, restBetweenSets: 60), // minutes
            Exercise(name: 'Court Sprint Patterns', sets: 6, reps: 30, restBetweenSets: 45), // seconds
            Exercise(name: 'Smash Practice', sets: 3, reps: 20, restBetweenSets: 60),
            Exercise(name: 'Net Shot Series', sets: 3, reps: 20, restBetweenSets: 45),
            Exercise(name: 'Service Practice', sets: 4, reps: 10, restBetweenSets: 30),
            Exercise(name: 'Cool Down & Stretch', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Hockey': [
        TrainingPlan(
          name: 'Ice Skills',
          exercises: [
            Exercise(name: 'Dynamic Hockey Warm-up', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Skating Technique Drills', sets: 4, reps: 3, restBetweenSets: 60), // minutes
            Exercise(name: 'Puck Handling Skills', sets: 4, reps: 2, restBetweenSets: 45), // minutes
            Exercise(name: 'Shot Practice Series', sets: 3, reps: 15, restBetweenSets: 60),
            Exercise(name: 'Speed & Agility Skates', sets: 6, reps: 30, restBetweenSets: 45), // seconds
            Exercise(name: 'Pass-Shot Combinations', sets: 4, reps: 10, restBetweenSets: 45),
            Exercise(name: 'Game Situation Drills', sets: 3, reps: 3, restBetweenSets: 90), // minutes
            Exercise(name: 'Cool Down Skate', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Ultimate frisbee': [
        TrainingPlan(
          name: 'Disc Skills',
          exercises: [
            Exercise(name: 'Dynamic Field Warm-up', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Throwing Progression', sets: 4, reps: 20, restBetweenSets: 45), // throws
            Exercise(name: 'Cutting Patterns', sets: 6, reps: 30, restBetweenSets: 45), // seconds
            Exercise(name: 'Sprint-Float-Sprint', sets: 6, reps: 40, restBetweenSets: 60), // seconds
            Exercise(name: 'Handler Weave Drills', sets: 3, reps: 3, restBetweenSets: 60), // minutes
            Exercise(name: 'Zone Defense Movement', sets: 4, reps: 2, restBetweenSets: 45), // minutes
            Exercise(name: 'Huck Practice', sets: 3, reps: 10, restBetweenSets: 45),
            Exercise(name: 'Cool Down & Stretch', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Rugby': [
        TrainingPlan(
          name: 'Rugby Skills',
          exercises: [
            Exercise(name: 'Rugby-Specific Warm-up', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Passing Drills (Both Sides)', sets: 4, reps: 20, restBetweenSets: 45),
            Exercise(name: 'Contact Technique', sets: 4, reps: 5, restBetweenSets: 60),
            Exercise(name: 'Ruck/Maul Practice', sets: 3, reps: 3, restBetweenSets: 90), // minutes
            Exercise(name: 'Sprint & Tackle Combo', sets: 6, reps: 30, restBetweenSets: 60), // seconds
            Exercise(name: 'Kicking Practice', sets: 3, reps: 10, restBetweenSets: 45),
            Exercise(name: 'Game Scenarios', sets: 2, reps: 5, restBetweenSets: 120), // minutes
            Exercise(name: 'Position-Specific Work', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Football': [
        TrainingPlan(
          name: 'Soccer Skills',
          exercises: [
            Exercise(name: 'Dynamic Football Warm-up', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Ball Control Drills', sets: 4, reps: 3, restBetweenSets: 45), // minutes
            Exercise(name: 'Passing Patterns', sets: 4, reps: 20, restBetweenSets: 45),
            Exercise(name: 'Shooting Practice', sets: 3, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Small-Sided Games', sets: 3, reps: 5, restBetweenSets: 120), // minutes
            Exercise(name: 'Sprint & Dribble', sets: 6, reps: 30, restBetweenSets: 45), // seconds
            Exercise(name: 'Set Piece Practice', sets: 3, reps: 5, restBetweenSets: 60),
            Exercise(name: 'Cool Down Exercises', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Baseball': [
        TrainingPlan(
          name: 'Diamond Skills',
          exercises: [
            Exercise(name: 'Baseball Dynamic Warm-up', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Throwing Progression', sets: 4, reps: 15, restBetweenSets: 45),
            Exercise(name: 'Fielding Drills', sets: 4, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Batting Practice', sets: 3, reps: 15, restBetweenSets: 90),
            Exercise(name: 'Base Running', sets: 4, reps: 4, restBetweenSets: 90), // bases
            Exercise(name: 'Position-Specific Work', sets: 3, reps: 5, restBetweenSets: 60), // minutes
            Exercise(name: 'Situational Defense', sets: 2, reps: 8, restBetweenSets: 60), // minutes
            Exercise(name: 'Arm Care & Cool Down', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
    },
    'Athletics': {
      'Discus throw': [
        TrainingPlan(
          name: 'Discus Power',
          exercises: [
            Exercise(name: 'Dynamic Throws Warm-up', sets: 1, reps: 15, restBetweenSets: 0), // minutes
            Exercise(name: 'Standing Throw Technique', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Half Turn Practice', sets: 4, reps: 6, restBetweenSets: 90),
            Exercise(name: 'Full Spin Technique', sets: 4, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Power Position Work', sets: 3, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Release Drills', sets: 3, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Full Throw Practice', sets: 3, reps: 5, restBetweenSets: 120),
            Exercise(name: 'Cool Down & Stretch', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 180,
        ),
      ],
      'Javelin throw': [
        TrainingPlan(
          name: 'Javelin Power',
          exercises: [
            Exercise(name: 'Throwing Warm-up', sets: 1, reps: 15, restBetweenSets: 0), // minutes
            Exercise(name: 'Standing Throws', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Cross-Step Practice', sets: 4, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Run-up Technique', sets: 4, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Block Position Work', sets: 3, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Full Approach Throws', sets: 3, reps: 4, restBetweenSets: 180),
            Exercise(name: 'Competition Practice', sets: 2, reps: 3, restBetweenSets: 240),
            Exercise(name: 'Recovery Protocol', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 180,
        ),
      ],
      'Hurdles': [
        TrainingPlan(
          name: 'Hurdle Technique',
          exercises: [
            Exercise(name: 'Sprint & Hurdle Warm-up', sets: 1, reps: 15, restBetweenSets: 0), // minutes
            Exercise(name: 'Lead Leg Drills', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Trail Leg Technique', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Three-Step Rhythm', sets: 4, reps: 4, restBetweenSets: 120), // hurdles
            Exercise(name: 'Single Hurdle Sprints', sets: 6, reps: 1, restBetweenSets: 120), // hurdle
            Exercise(name: 'Multi-Hurdle Practice', sets: 4, reps: 3, restBetweenSets: 180), // hurdles
            Exercise(name: 'Race Pace Series', sets: 3, reps: 4, restBetweenSets: 240), // hurdles
            Exercise(name: 'Cool Down & Mobility', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 180,
        ),
      ],
      'Track and field': [
        TrainingPlan(
          name: 'Track Performance',
          exercises: [
            Exercise(name: 'Dynamic Warm-up (track specific)', sets: 1, reps: 15, restBetweenSets: 0), // minutes
            Exercise(name: 'Sprint Technique Drills (A-skips, B-skips)', sets: 3, reps: 50, restBetweenSets: 60), // meters
            Exercise(name: 'Block Start Practice', sets: 6, reps: 20, restBetweenSets: 90), // meters
            Exercise(name: 'Flying 30m Sprints', sets: 4, reps: 30, restBetweenSets: 120), // meters
            Exercise(name: 'Acceleration Development', sets: 4, reps: 40, restBetweenSets: 120), // meters
            Exercise(name: 'Speed Endurance Runs', sets: 3, reps: 150, restBetweenSets: 180), // meters
            Exercise(name: 'Form Running', sets: 2, reps: 100, restBetweenSets: 90), // meters
            Exercise(name: 'Cool Down Protocol', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Long jump': [
        TrainingPlan(
          name: 'Jump Power Development',
          exercises: [
            Exercise(name: 'Dynamic Flexibility Routine', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Approach Run Practice', sets: 5, reps: 40, restBetweenSets: 90), // meters
            Exercise(name: 'Bounding Exercises', sets: 4, reps: 30, restBetweenSets: 60), // meters
            Exercise(name: 'Box Jumps (increasing height)', sets: 4, reps: 6, restBetweenSets: 90),
            Exercise(name: 'Single Leg Hops', sets: 3, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Take-off Practice', sets: 6, reps: 1, restBetweenSets: 120),
            Exercise(name: 'Landing Technique', sets: 4, reps: 5, restBetweenSets: 90),
            Exercise(name: 'Cool Down & Recovery', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Relay races': [
        TrainingPlan(
          name: 'Relay Speed',
          exercises: [
            Exercise(name: 'Sprint Warm-up Protocol', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Baton Exchange Drills', sets: 6, reps: 30, restBetweenSets: 90), // meters
            Exercise(name: 'Acceleration Zone Practice', sets: 4, reps: 50, restBetweenSets: 120), // meters
            Exercise(name: 'Visual Exchange Work', sets: 4, reps: 50, restBetweenSets: 90), // meters
            Exercise(name: 'Non-Visual Exchange', sets: 4, reps: 50, restBetweenSets: 90), // meters
            Exercise(name: 'Full Speed Exchange', sets: 3, reps: 100, restBetweenSets: 180), // meters
            Exercise(name: 'Team Coordination', sets: 2, reps: 200, restBetweenSets: 240), // meters
            Exercise(name: 'Cool Down Jog', sets: 1, reps: 800, restBetweenSets: 0), // meters
          ],
          restBetweenExercises: 180,
        ),
      ],
      'Pole vault': [
        TrainingPlan(
          name: 'Vault Technique',
          exercises: [
            Exercise(name: 'Pole Vault Warm-up', sets: 1, reps: 15, restBetweenSets: 0), // minutes
            Exercise(name: 'Run-up Practice', sets: 4, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Plant Box Drills', sets: 4, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Swing Up Technique', sets: 4, reps: 5, restBetweenSets: 180),
            Exercise(name: 'Short Run Vaults', sets: 3, reps: 4, restBetweenSets: 240),
            Exercise(name: 'Full Approach Vaults', sets: 3, reps: 3, restBetweenSets: 300),
            Exercise(name: 'Technical Analysis', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Cool Down Protocol', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 240,
        ),
      ],
      'Shot put': [
        TrainingPlan(
          name: 'Shot Power',
          exercises: [
            Exercise(name: 'Throws Warm-up', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Standing Throw Tech', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Glide Technique', sets: 4, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Power Position Work', sets: 4, reps: 6, restBetweenSets: 90),
            Exercise(name: 'Spin Technique', sets: 3, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Release Practice', sets: 3, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Competition Throws', sets: 3, reps: 4, restBetweenSets: 180),
            Exercise(name: 'Recovery & Stretch', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 180,
        ),
      ],
      'High jump': [
        TrainingPlan(
          name: 'Jump Technique',
          exercises: [
            Exercise(name: 'Jump-Specific Warm-up', sets: 1, reps: 15, restBetweenSets: 0), // minutes
            Exercise(name: 'Approach Run Practice', sets: 4, reps: 6, restBetweenSets: 90),
            Exercise(name: 'Take-off Drills', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Bar Clearance Tech', sets: 4, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Full Jump Practice', sets: 3, reps: 4, restBetweenSets: 180),
            Exercise(name: 'Height Progression', sets: 3, reps: 3, restBetweenSets: 240),
            Exercise(name: 'Technical Review', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Cool Down Protocol', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 180,
        ),
      ],
      'Triple jump': [
        TrainingPlan(
          name: 'Jump Sequence',
          exercises: [
            Exercise(name: 'Jump Warm-up', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Hop Phase Practice', sets: 4, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Step Phase Work', sets: 4, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Jump Phase Tech', sets: 4, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Full Sequence Practice', sets: 3, reps: 4, restBetweenSets: 180),
            Exercise(name: 'Approach Run Work', sets: 3, reps: 6, restBetweenSets: 120),
            Exercise(name: 'Competition Jumps', sets: 2, reps: 3, restBetweenSets: 240),
            Exercise(name: 'Cool Down & Analysis', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 180,
        ),
      ],
    },
    'Strength training outdoors': {
      'Park workout': [
        TrainingPlan(
          name: 'Outdoor Total Body',
          exercises: [
            Exercise(name: 'Dynamic Movement Prep', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Pull-ups on Bar', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Step-ups on Bench', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Parallel Bar Dips', sets: 3, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Incline Push-ups on Bench', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Box Jumps', sets: 3, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Hanging Leg Raises', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Sprint Intervals', sets: 4, reps: 30, restBetweenSets: 60), // meters
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Calisthenics': [
        TrainingPlan(
          name: 'Advanced Bodyweight',
          exercises: [
            Exercise(name: 'Joint Mobility Warm-up', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Muscle-ups', sets: 4, reps: 5, restBetweenSets: 120),
            Exercise(name: 'Handstand Push-ups', sets: 3, reps: 6, restBetweenSets: 90),
            Exercise(name: 'Front Lever Progressions', sets: 4, reps: 15, restBetweenSets: 90), // seconds
            Exercise(name: 'Pistol Squats', sets: 3, reps: 8, restBetweenSets: 60),
            Exercise(name: 'L-Sit Holds', sets: 3, reps: 20, restBetweenSets: 60), // seconds
            Exercise(name: 'Planche Progressions', sets: 3, reps: 15, restBetweenSets: 90), // seconds
            Exercise(name: 'Human Flag Attempts', sets: 4, reps: 10, restBetweenSets: 120), // seconds
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Natural resistance training': [
        TrainingPlan(
          name: 'Nature Strength',
          exercises: [
            Exercise(name: 'Movement Prep & Mobility', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Log/Rock Carries', sets: 4, reps: 30, restBetweenSets: 90), // meters
            Exercise(name: 'Natural Object Press', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Boulder Pull-ups', sets: 3, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Log Squats', sets: 4, reps: 12, restBetweenSets: 90),
            Exercise(name: 'Rock Rows', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Natural Object Farmers Walk', sets: 3, reps: 40, restBetweenSets: 90), // meters
            Exercise(name: 'Cool Down & Mobility', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Tree branch exercises': [
        TrainingPlan(
          name: 'Branch Strength',
          exercises: [
            Exercise(name: 'Joint Mobility Warm-up', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Branch Pull-ups', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Branch Inverted Rows', sets: 4, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Branch Dips', sets: 3, reps: 10, restBetweenSets: 90),
            Exercise(name: 'Hanging Leg Raises', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Branch Walk (Balance)', sets: 3, reps: 20, restBetweenSets: 60), // steps
            Exercise(name: 'Branch Hang Challenge', sets: 3, reps: 45, restBetweenSets: 60), // seconds
            Exercise(name: 'Flexibility Work', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Stair workout': [
        TrainingPlan(
          name: 'Stair Power',
          exercises: [
            Exercise(name: 'Dynamic Warm-up', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Stair Sprints', sets: 6, reps: 20, restBetweenSets: 90), // steps
            Exercise(name: 'Walking Lunges Up Stairs', sets: 4, reps: 24, restBetweenSets: 90), // steps
            Exercise(name: 'Box Jumps on Steps', sets: 4, reps: 10, restBetweenSets: 60),
            Exercise(name: 'Stair Push-ups', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Step-ups (2 at a time)', sets: 3, reps: 20, restBetweenSets: 60), // each leg
            Exercise(name: 'Stair Plank Hold', sets: 3, reps: 30, restBetweenSets: 45), // seconds
            Exercise(name: 'Cool Down Walk', sets: 1, reps: 5, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Outdoor circuit': [
        TrainingPlan(
          name: 'Park Circuit',
          exercises: [
            Exercise(name: 'Dynamic Movement Prep', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Sprint-Push-up Complex', sets: 4, reps: 30, restBetweenSets: 45), // seconds
            Exercise(name: 'Park Bench Dips to Jumps', sets: 4, reps: 12, restBetweenSets: 45),
            Exercise(name: 'Tree Pull-up to Squats', sets: 4, reps: 8, restBetweenSets: 45),
            Exercise(name: 'Grass Burpee Broad Jumps', sets: 4, reps: 10, restBetweenSets: 45),
            Exercise(name: 'Hill Sprint-Walk Combo', sets: 4, reps: 45, restBetweenSets: 45), // seconds
            Exercise(name: 'Natural Object Circuit', sets: 3, reps: 60, restBetweenSets: 60), // seconds
            Exercise(name: 'Cool Down Jog', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Bodyweight strength': [
        TrainingPlan(
          name: 'Outdoor Calisthenics',
          exercises: [
            Exercise(name: 'Movement Flow Warm-up', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Handstand Practice', sets: 4, reps: 30, restBetweenSets: 60), // seconds
            Exercise(name: 'Muscle-up Progression', sets: 4, reps: 5, restBetweenSets: 120),
            Exercise(name: 'Pistol Squats', sets: 3, reps: 8, restBetweenSets: 90), // each leg
            Exercise(name: 'L-Sit Progression', sets: 4, reps: 20, restBetweenSets: 60), // seconds
            Exercise(name: 'Planche Lean Practice', sets: 4, reps: 30, restBetweenSets: 90), // seconds
            Exercise(name: 'Front Lever Work', sets: 4, reps: 15, restBetweenSets: 90), // seconds
            Exercise(name: 'Mobility & Stretch', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Rock climbing': [
        TrainingPlan(
          name: 'Climbing Prep',
          exercises: [
            Exercise(name: 'Dynamic Climbing Warm-up', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Dead Hangs', sets: 4, reps: 30, restBetweenSets: 90), // seconds
            Exercise(name: 'Pull-up Variations', sets: 4, reps: 6, restBetweenSets: 90),
            Exercise(name: 'Finger Board Training', sets: 3, reps: 20, restBetweenSets: 120), // seconds
            Exercise(name: 'Core Tension Exercises', sets: 3, reps: 45, restBetweenSets: 60), // seconds
            Exercise(name: 'Campus Board Basic', sets: 3, reps: 5, restBetweenSets: 120),
            Exercise(name: 'Traversing Practice', sets: 3, reps: 3, restBetweenSets: 180), // minutes
            Exercise(name: 'Flexibility Work', sets: 1, reps: 15, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 180,
        ),
      ],
      'Bench workout': [
        TrainingPlan(
          name: 'Park Bench Power',
          exercises: [
            Exercise(name: 'Dynamic Preparation', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Bench Jump-overs', sets: 4, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Incline Push-ups', sets: 4, reps: 15, restBetweenSets: 60),
            Exercise(name: 'Bulgarian Split Squats', sets: 3, reps: 12, restBetweenSets: 60), // each leg
            Exercise(name: 'Bench Dips', sets: 4, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Step-ups with Knee Drive', sets: 3, reps: 10, restBetweenSets: 45), // each leg
            Exercise(name: 'Bench Mountain Climbers', sets: 3, reps: 45, restBetweenSets: 45), // seconds
            Exercise(name: 'Cool Down Stretches', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Outdoor HIIT': [
        TrainingPlan(
          name: 'Nature HIIT',
          exercises: [
            Exercise(name: 'Dynamic HIIT Warm-up', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Hill Sprint-Walk', sets: 6, reps: 30, restBetweenSets: 30), // seconds
            Exercise(name: 'Natural Object Thrusters', sets: 4, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'Tree Branch Hang to Pull', sets: 4, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'Rock/Log Clean & Press', sets: 4, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'Terrain Sprint Circuit', sets: 4, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'Natural Obstacle Course', sets: 3, reps: 60, restBetweenSets: 45), // seconds
            Exercise(name: 'Cool Down Walk', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 60,
        ),
      ],
    },
    'Cardio': {
      'HIIT cardio': [
        TrainingPlan(
          name: 'High Intensity Intervals',
          exercises: [
            Exercise(name: 'Dynamic Warm-up (full body)', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Burpee Intervals (85-90% max HR)', sets: 8, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'Mountain Climbers (fast pace)', sets: 8, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'Jump Rope Double Unders', sets: 6, reps: 30, restBetweenSets: 30), // seconds
            Exercise(name: 'High Knees Sprint', sets: 6, reps: 30, restBetweenSets: 30), // seconds
            Exercise(name: 'Jumping Jacks (power)', sets: 6, reps: 30, restBetweenSets: 30), // seconds
            Exercise(name: 'Plank to Downward Dog', sets: 3, reps: 45, restBetweenSets: 30), // seconds
            Exercise(name: 'Cool Down Walk', sets: 1, reps: 5, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 60,
        ),
      ],
      'Steady state cardio': [
        TrainingPlan(
          name: 'Endurance Builder',
          exercises: [
            Exercise(name: 'Light Dynamic Stretching', sets: 1, reps: 5, restBetweenSets: 0), // minutes
            Exercise(name: 'Steady Pace Walk (Zone 2)', sets: 1, reps: 5, restBetweenSets: 0), // minutes
            Exercise(name: 'Light Jog (65-70% max HR)', sets: 1, reps: 20, restBetweenSets: 0), // minutes
            Exercise(name: 'Power Walking Intervals', sets: 4, reps: 3, restBetweenSets: 60), // minutes
            Exercise(name: 'Steady Run (70-75% max HR)', sets: 1, reps: 15, restBetweenSets: 0), // minutes
            Exercise(name: 'Incline Walking', sets: 3, reps: 5, restBetweenSets: 60), // minutes
            Exercise(name: 'Light Cool Down Jog', sets: 1, reps: 5, restBetweenSets: 0), // minutes
            Exercise(name: 'Stretching', sets: 1, reps: 5, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 30,
        ),
      ],
      'Rowing': [
        TrainingPlan(
          name: 'Rowing Power & Endurance',
          exercises: [
            Exercise(name: 'Dynamic Rowing Warm-up', sets: 1, reps: 500, restBetweenSets: 0), // meters
            Exercise(name: 'Technique Drills (legs-core-arms)', sets: 3, reps: 250, restBetweenSets: 60), // meters
            Exercise(name: 'Power Strokes (26-28 spm)', sets: 4, reps: 250, restBetweenSets: 90), // meters
            Exercise(name: 'Steady State (22-24 spm)', sets: 1, reps: 1000, restBetweenSets: 0), // meters
            Exercise(name: 'Sprint Intervals (30+ spm)', sets: 6, reps: 200, restBetweenSets: 60), // meters
            Exercise(name: 'Pyramid (20-24-28-24-20 spm)', sets: 1, reps: 1000, restBetweenSets: 0), // meters
            Exercise(name: 'Cool Down Row', sets: 1, reps: 500, restBetweenSets: 0), // meters
            Exercise(name: 'Upper Body Stretching', sets: 1, reps: 5, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
    },
    'Swimming': {
      'Freestyle technique': [
        TrainingPlan(
          name: 'Freestyle Mastery',
          exercises: [
            Exercise(name: 'Pool Deck Mobility', sets: 1, reps: 5, restBetweenSets: 0), // minutes
            Exercise(name: 'Kick Board Drills', sets: 4, reps: 50, restBetweenSets: 30), // meters
            Exercise(name: 'Pull Buoy Technique', sets: 4, reps: 50, restBetweenSets: 30), // meters
            Exercise(name: 'Catch Phase Practice', sets: 4, reps: 25, restBetweenSets: 20), // meters
            Exercise(name: 'Breathing Pattern (3-5-7)', sets: 3, reps: 50, restBetweenSets: 30), // meters
            Exercise(name: 'Sprint Form', sets: 6, reps: 25, restBetweenSets: 30), // meters
            Exercise(name: 'Distance Form', sets: 2, reps: 100, restBetweenSets: 60), // meters
            Exercise(name: 'Cool Down Easy Swim', sets: 1, reps: 200, restBetweenSets: 0), // meters
          ],
          restBetweenExercises: 90,
        ),
      ],
      'Endurance swimming': [
        TrainingPlan(
          name: 'Distance Swimming',
          exercises: [
            Exercise(name: 'Warm-up Mixed Strokes', sets: 1, reps: 400, restBetweenSets: 0), // meters
            Exercise(name: 'Pyramid Sets (50-100-150-200)', sets: 1, reps: 500, restBetweenSets: 60), // meters
            Exercise(name: 'Tempo Intervals', sets: 5, reps: 200, restBetweenSets: 45), // meters
            Exercise(name: 'Pull Sets (no kicks)', sets: 4, reps: 100, restBetweenSets: 30), // meters
            Exercise(name: 'Kick Sets (no arms)', sets: 4, reps: 50, restBetweenSets: 30), // meters
            Exercise(name: 'Distance Pace Work', sets: 1, reps: 400, restBetweenSets: 0), // meters
            Exercise(name: 'Sprint-Recovery Mix', sets: 4, reps: 100, restBetweenSets: 45), // meters
            Exercise(name: 'Cool Down Choice Stroke', sets: 1, reps: 200, restBetweenSets: 0), // meters
          ],
          restBetweenExercises: 120,
        ),
      ],
    },
    'Cycling': {
      'Road cycling': [
        TrainingPlan(
          name: 'Road Endurance',
          exercises: [
            Exercise(name: 'Dynamic Stretching', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Warm-up Spin (60-70% FTP)', sets: 1, reps: 15, restBetweenSets: 0), // minutes
            Exercise(name: 'Tempo Intervals (75-85% FTP)', sets: 4, reps: 10, restBetweenSets: 180), // minutes
            Exercise(name: 'Hill Climbs (85-95% FTP)', sets: 3, reps: 5, restBetweenSets: 180), // minutes
            Exercise(name: 'Sprint Bursts (>100% FTP)', sets: 5, reps: 30, restBetweenSets: 90), // seconds
            Exercise(name: 'Steady State (70-75% FTP)', sets: 1, reps: 20, restBetweenSets: 0), // minutes
            Exercise(name: 'Cool Down Spin', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Post-Ride Stretching', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Mountain biking': [
        TrainingPlan(
          name: 'Trail Skills & Power',
          exercises: [
            Exercise(name: 'Bike Check & Warm-up', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Technical Skills Course', sets: 3, reps: 10, restBetweenSets: 120), // minutes
            Exercise(name: 'Hill Climb Intervals', sets: 4, reps: 5, restBetweenSets: 180), // minutes
            Exercise(name: 'Descent Practice', sets: 4, reps: 3, restBetweenSets: 120), // minutes
            Exercise(name: 'Power Output Bursts', sets: 6, reps: 30, restBetweenSets: 60), // seconds
            Exercise(name: 'Balance & Control Drills', sets: 3, reps: 5, restBetweenSets: 60), // minutes
            Exercise(name: 'Trail Endurance Loop', sets: 1, reps: 15, restBetweenSets: 0), // minutes
            Exercise(name: 'Cool Down & Review', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 180,
        ),
      ],
    },
    'Martial arts': {
      'Boxing': [
        TrainingPlan(
          name: 'Boxing Fundamentals',
          exercises: [
            Exercise(name: 'Dynamic Boxing Warm-up', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Jump Rope Footwork', sets: 3, reps: 3, restBetweenSets: 60), // minutes
            Exercise(name: 'Shadow Boxing Rounds', sets: 4, reps: 3, restBetweenSets: 60), // minutes
            Exercise(name: 'Heavy Bag Combinations', sets: 5, reps: 3, restBetweenSets: 60), // minutes
            Exercise(name: 'Speed Bag Technique', sets: 3, reps: 2, restBetweenSets: 45), // minutes
            Exercise(name: 'Defensive Movement Drills', sets: 3, reps: 3, restBetweenSets: 60), // minutes
            Exercise(name: 'Core Boxing Circuit', sets: 3, reps: 3, restBetweenSets: 60), // minutes
            Exercise(name: 'Cool Down & Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Kickboxing': [
        TrainingPlan(
          name: 'Kickboxing Power',
          exercises: [
            Exercise(name: 'Dynamic Kick Warm-up', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Technical Kick Practice', sets: 4, reps: 20, restBetweenSets: 60), // kicks per side
            Exercise(name: 'Punch-Kick Combinations', sets: 5, reps: 3, restBetweenSets: 60), // minutes
            Exercise(name: 'Pad Work Rounds', sets: 4, reps: 3, restBetweenSets: 60), // minutes
            Exercise(name: 'Power Kick Drills', sets: 3, reps: 10, restBetweenSets: 45), // kicks per side
            Exercise(name: 'Defensive Movement', sets: 3, reps: 3, restBetweenSets: 60), // minutes
            Exercise(name: 'Cardio Kick Intervals', sets: 3, reps: 3, restBetweenSets: 60), // minutes
            Exercise(name: 'Flexibility & Cool Down', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
    },
    'Yoga and stretching': {
      'Power yoga': [
        TrainingPlan(
          name: 'Dynamic Flow',
          exercises: [
            Exercise(name: 'Sun Salutation A', sets: 3, reps: 5, restBetweenSets: 0), // flows
            Exercise(name: 'Standing Power Sequence', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Warrior Flow Series', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Balance Pose Series', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Core Power Sequence', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Inversion Practice', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Back Bending Series', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Savasana', sets: 1, reps: 5, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 30,
        ),
      ],
      'Flexibility training': [
        TrainingPlan(
          name: 'Full Body Flexibility',
          exercises: [
            Exercise(name: 'Joint Mobility Warm-up', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Dynamic Stretching Flow', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Lower Body Focus', sets: 3, reps: 45, restBetweenSets: 15), // seconds per stretch
            Exercise(name: 'Upper Body Series', sets: 3, reps: 45, restBetweenSets: 15), // seconds per stretch
            Exercise(name: 'Spine Mobility Work', sets: 3, reps: 45, restBetweenSets: 15), // seconds per movement
            Exercise(name: 'Split Training', sets: 4, reps: 60, restBetweenSets: 30), // seconds per side
            Exercise(name: 'Advanced Stretches', sets: 2, reps: 45, restBetweenSets: 15), // seconds per stretch
            Exercise(name: 'Relaxation Poses', sets: 1, reps: 5, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 60,
        ),
      ],
    },
    'CrossFit': {
      'WOD': [
        TrainingPlan(
          name: 'CrossFit Conditioning',
          exercises: [
            Exercise(name: 'Dynamic Mobility Flow', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Skill Practice (Olympic Lifts)', sets: 3, reps: 5, restBetweenSets: 60),
            Exercise(name: 'Strength Component (5-5-5-5)', sets: 4, reps: 5, restBetweenSets: 120),
            Exercise(name: 'MetCon - AMRAP', sets: 1, reps: 15, restBetweenSets: 0), // minutes
            Exercise(name: 'Core Stabilization', sets: 3, reps: 1, restBetweenSets: 30), // minute each
            Exercise(name: 'Olympic Lifting Technique', sets: 4, reps: 3, restBetweenSets: 90),
            Exercise(name: 'Gymnastics Skills', sets: 3, reps: 5, restBetweenSets: 60),
            Exercise(name: 'Cool Down & Mobility', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 120,
        ),
      ],
      'Strength focus': [
        TrainingPlan(
          name: 'CrossFit Strength',
          exercises: [
            Exercise(name: 'Movement Prep & Mobility', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Back Squat (Build to Heavy 5)', sets: 5, reps: 5, restBetweenSets: 180),
            Exercise(name: 'Deadlift Technique', sets: 4, reps: 3, restBetweenSets: 180),
            Exercise(name: 'Clean & Jerk Practice', sets: 5, reps: 2, restBetweenSets: 120),
            Exercise(name: 'Snatch Progression', sets: 4, reps: 2, restBetweenSets: 120),
            Exercise(name: 'Ring Work (Muscle-ups)', sets: 3, reps: 3, restBetweenSets: 90),
            Exercise(name: 'Handstand Push-ups', sets: 3, reps: 5, restBetweenSets: 90),
            Exercise(name: 'Recovery & Stretching', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 180,
        ),
      ],
    },
    'Pilates': {
      'Mat work': [
        TrainingPlan(
          name: 'Core Control',
          exercises: [
            Exercise(name: 'Breathing & Alignment Check', sets: 1, reps: 5, restBetweenSets: 0), // minutes
            Exercise(name: 'The Hundred', sets: 3, reps: 100, restBetweenSets: 45), // pulses
            Exercise(name: 'Roll-up Series', sets: 3, reps: 8, restBetweenSets: 30),
            Exercise(name: 'Single Leg Circles', sets: 2, reps: 10, restBetweenSets: 30), // each leg
            Exercise(name: 'Spine Stretch Forward', sets: 3, reps: 8, restBetweenSets: 30),
            Exercise(name: 'Rolling Like a Ball', sets: 3, reps: 6, restBetweenSets: 30),
            Exercise(name: 'Series of Five', sets: 1, reps: 10, restBetweenSets: 0), // each exercise
            Exercise(name: 'Rest & Integration', sets: 1, reps: 5, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 60,
        ),
      ],
      'Reformer': [
        TrainingPlan(
          name: 'Reformer Flow',
          exercises: [
            Exercise(name: 'Equipment Setup & Check', sets: 1, reps: 5, restBetweenSets: 0), // minutes
            Exercise(name: 'Footwork Series', sets: 3, reps: 10, restBetweenSets: 30),
            Exercise(name: 'Hundred on Reformer', sets: 2, reps: 100, restBetweenSets: 60), // pulses
            Exercise(name: 'Leg Circles', sets: 2, reps: 8, restBetweenSets: 30), // each leg
            Exercise(name: 'Short Box Series', sets: 2, reps: 8, restBetweenSets: 45),
            Exercise(name: 'Long Stretch Series', sets: 2, reps: 6, restBetweenSets: 45),
            Exercise(name: 'Knee Stretches', sets: 2, reps: 10, restBetweenSets: 30),
            Exercise(name: 'Cool Down Stretches', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 60,
        ),
      ],
    },
    'Dance fitness': {
      'Zumba': [
        TrainingPlan(
          name: 'Cardio Dance',
          exercises: [
            Exercise(name: 'Warm-up Routine', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Salsa Basic Steps', sets: 3, reps: 5, restBetweenSets: 30), // minutes
            Exercise(name: 'Merengue Combinations', sets: 3, reps: 5, restBetweenSets: 30), // minutes
            Exercise(name: 'Reggaeton Intensity', sets: 2, reps: 6, restBetweenSets: 45), // minutes
            Exercise(name: 'Cumbia Patterns', sets: 2, reps: 5, restBetweenSets: 30), // minutes
            Exercise(name: 'Choreography Block', sets: 2, reps: 8, restBetweenSets: 60), // minutes
            Exercise(name: 'High-Intensity Samba', sets: 2, reps: 4, restBetweenSets: 45), // minutes
            Exercise(name: 'Cool Down Dance', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 60,
        ),
      ],
      'Hip hop dance': [
        TrainingPlan(
          name: 'Urban Groove',
          exercises: [
            Exercise(name: 'Joint Warm-up & Isolation', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Basic Footwork', sets: 4, reps: 4, restBetweenSets: 30), // minutes
            Exercise(name: 'Top Rock Sequences', sets: 3, reps: 5, restBetweenSets: 45), // minutes
            Exercise(name: 'Power Moves Practice', sets: 3, reps: 4, restBetweenSets: 60), // minutes
            Exercise(name: 'Freestyle Circle', sets: 2, reps: 5, restBetweenSets: 45), // minutes
            Exercise(name: 'Choreography Learning', sets: 2, reps: 8, restBetweenSets: 60), // minutes
            Exercise(name: 'Battle Practice', sets: 2, reps: 3, restBetweenSets: 45), // minutes
            Exercise(name: 'Style Development', sets: 1, reps: 10, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 90,
        ),
      ],
    },
    'Meditation': {
      'Mindfulness': [
        TrainingPlan(
          name: 'Mind-Body Connection',
          exercises: [
            Exercise(name: 'Breathing Awareness', sets: 1, reps: 5, restBetweenSets: 0), // minutes
            Exercise(name: 'Body Scan Practice', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Focused Attention', sets: 3, reps: 5, restBetweenSets: 30), // minutes
            Exercise(name: 'Walking Meditation', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Loving-Kindness Practice', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Thought Observation', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Sound Awareness', sets: 1, reps: 5, restBetweenSets: 0), // minutes
            Exercise(name: 'Silent Reflection', sets: 1, reps: 5, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 30,
        ),
      ],
      'Guided meditation': [
        TrainingPlan(
          name: 'Stress Relief',
          exercises: [
            Exercise(name: 'Setting Intention', sets: 1, reps: 3, restBetweenSets: 0), // minutes
            Exercise(name: 'Progressive Relaxation', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Visualization Journey', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Breath Work', sets: 3, reps: 3, restBetweenSets: 30), // minutes
            Exercise(name: 'Emotional Awareness', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Gratitude Practice', sets: 1, reps: 5, restBetweenSets: 0), // minutes
            Exercise(name: 'Energy Clearing', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Integration Period', sets: 1, reps: 5, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 0,
        ),
      ],
    },
    'Recovery': {
      'Active recovery': [
        TrainingPlan(
          name: 'Movement Recovery',
          exercises: [
            Exercise(name: 'Light Joint Mobility', sets: 1, reps: 8, restBetweenSets: 0), // minutes
            Exercise(name: 'Walking (Zone 1)', sets: 1, reps: 15, restBetweenSets: 0), // minutes
            Exercise(name: 'Dynamic Stretching', sets: 2, reps: 5, restBetweenSets: 30), // minutes
            Exercise(name: 'Foam Rolling', sets: 1, reps: 12, restBetweenSets: 0), // minutes
            Exercise(name: 'Light Resistance Band Work', sets: 2, reps: 12, restBetweenSets: 45),
            Exercise(name: 'Balance Exercises', sets: 2, reps: 5, restBetweenSets: 30), // minutes
            Exercise(name: 'Mobility Flow', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Breathing Exercises', sets: 1, reps: 5, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 60,
        ),
      ],
      'Stretching and mobility': [
        TrainingPlan(
          name: 'Deep Recovery',
          exercises: [
            Exercise(name: 'Breathing & Centering', sets: 1, reps: 5, restBetweenSets: 0), // minutes
            Exercise(name: 'Myofascial Release', sets: 1, reps: 15, restBetweenSets: 0), // minutes
            Exercise(name: 'Joint Mobility Series', sets: 2, reps: 8, restBetweenSets: 30), // minutes
            Exercise(name: 'Static Stretching', sets: 3, reps: 30, restBetweenSets: 15), // seconds per stretch
            Exercise(name: 'PNF Stretching', sets: 2, reps: 6, restBetweenSets: 30), // each position
            Exercise(name: 'Movement Integration', sets: 1, reps: 10, restBetweenSets: 0), // minutes
            Exercise(name: 'Balance Work', sets: 2, reps: 5, restBetweenSets: 30), // minutes
            Exercise(name: 'Relaxation', sets: 1, reps: 8, restBetweenSets: 0), // minutes
          ],
          restBetweenExercises: 45,
        ),
      ],
    },
  };

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

    await _initializeTrainingPlansData(userTrainingPlansRef);
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
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }

    // Reinitialize with new data including videos
    await _initializeTrainingPlansData(userTrainingPlansRef);
  }

  // Helper method to initialize training plans data
  Future<void> _initializeTrainingPlansData(CollectionReference userTrainingPlansRef) async {
    // Initialize default training plans for each category and workout
    for (var categoryEntry in workoutSpecificPlans.entries) {
      final category = categoryEntry.key;
      final workouts = categoryEntry.value;
      
      for (var workoutEntry in workouts.entries) {
        final workoutName = workoutEntry.key;
        final plans = workoutEntry.value;
        
        await userTrainingPlansRef
            .doc('${category.toLowerCase().replaceAll(' ', '_')}_${workoutName.toLowerCase().replaceAll(' ', '_')}')
            .set({
          'category': category,
          'workoutName': workoutName,
          'plans': plans.map((plan) => plan.toMap()).toList(),
        });
      }
    }
  }

  // Get training plans for a specific workout
  Future<List<TrainingPlan>> getTrainingPlansForWorkout({
    required String category,
    required String workoutName,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    try {
      final docSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('workout_training_plans')
          .doc('${category.toLowerCase().replaceAll(' ', '_')}_${workoutName.toLowerCase().replaceAll(' ', '_')}')
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
} 