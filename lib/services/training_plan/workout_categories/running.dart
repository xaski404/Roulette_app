import '../../training_plan_models.dart';

final Map<String, Map<String, List<TrainingPlan>>> runningPlans = {
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
}; 