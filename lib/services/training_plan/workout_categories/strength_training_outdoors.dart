import '../../training_plan_models.dart';

final Map<String, Map<String, List<TrainingPlan>>> strengthTrainingOutdoorsPlans = {
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
}; 