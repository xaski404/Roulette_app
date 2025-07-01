import '../../training_plan_models.dart';

final Map<String, Map<String, List<TrainingPlan>>> teamSportsPlans = {
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
}; 