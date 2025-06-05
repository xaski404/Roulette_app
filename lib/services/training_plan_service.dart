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

  // Default training plans for specific workouts
  final Map<String, Map<String, List<TrainingPlan>>> workoutSpecificPlans = {
    'Strength training at the gym': {
      'Full body workout': [
        TrainingPlan(
          name: 'Full Body Strength',
          exercises: [
            Exercise(name: 'Barbell Back Squats', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Bench Press', sets: 4, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Deadlifts', sets: 4, reps: 8, restBetweenSets: 120),
            Exercise(name: 'Pull-ups', sets: 3, reps: 10, restBetweenSets: 90),
            Exercise(name: 'Overhead Press', sets: 3, reps: 10, restBetweenSets: 90),
            Exercise(name: 'Barbell Rows', sets: 3, reps: 10, restBetweenSets: 90),
            Exercise(name: 'Dips', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Plank', sets: 3, reps: 45, restBetweenSets: 45), // reps in seconds
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
    },
    'Strength training at home': {
      'Bodyweight circuit': [
        TrainingPlan(
          name: 'Bodyweight Intensity',
          exercises: [
            Exercise(name: 'Diamond Push-ups', sets: 4, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Jump Squats', sets: 4, reps: 15, restBetweenSets: 60),
            Exercise(name: 'Pull-ups', sets: 3, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Pike Push-ups', sets: 3, reps: 12, restBetweenSets: 60),
            Exercise(name: 'Pistol Squats', sets: 3, reps: 8, restBetweenSets: 90),
            Exercise(name: 'Burpees', sets: 3, reps: 15, restBetweenSets: 60),
            Exercise(name: 'L-Sits', sets: 3, reps: 20, restBetweenSets: 60), // reps in seconds
            Exercise(name: 'Mountain Climbers', sets: 3, reps: 30, restBetweenSets: 45),
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
    },
    'Athletics': {
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