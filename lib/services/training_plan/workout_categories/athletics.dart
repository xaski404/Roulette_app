import '../../training_plan_models.dart';

final Map<String, Map<String, List<TrainingPlan>>> athleticsPlans = {
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
}; 