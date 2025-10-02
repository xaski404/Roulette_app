import '../../training_plan_models.dart';

final Map<String, Map<String, List<TrainingPlan>>> strengthTrainingAtTheGymPlans = {
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
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=ultWZbUMPL8',
            videoTitle: 'How To Squat: Proper Form',
            videoDescription: 'Learn the correct form for barbell back squats with this step-by-step guide from ATHLEAN-X.'
          ),
          Exercise(
            name: 'Bench Press',
            sets: 4,
            reps: 8,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=gRVjAtPip0Y',
            videoTitle: 'How To: Barbell Bench Press',
            videoDescription: 'A complete tutorial on the barbell bench press for strength and muscle, by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Deadlifts',
            sets: 4,
            reps: 8,
            restBetweenSets: 120,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=op9kVnSso6Q',
            videoTitle: 'How To Deadlift: Conventional Deadlift Form',
            videoDescription: 'Deadlift form and technique explained by Jeff Nippard.'
          ),
          Exercise(
            name: 'Pull-ups',
            sets: 3,
            reps: 10,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=eGo4IYlbE5g',
            videoTitle: 'How To Do Pull-Ups For Beginners',
            videoDescription: 'Pull-up progression and form tips from Calisthenicmovement.'
          ),
          Exercise(
            name: 'Overhead Press',
            sets: 3,
            reps: 10,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2yjwXTZQDDg',
            videoTitle: 'How To: Overhead Press',
            videoDescription: 'Military press form and technique by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Barbell Rows',
            sets: 3,
            reps: 10,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=vT2GjY_Umpw',
            videoTitle: 'How To: Barbell Row',
            videoDescription: 'Barbell row form and back activation by Buff Dudes.'
          ),
          Exercise(
            name: 'Dips',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2z8JmcrW-As',
            videoTitle: 'How To: Dips',
            videoDescription: 'Proper dip form for chest and triceps by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Plank',
            sets: 3,
            reps: 45,
            restBetweenSets: 45,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=pSHjTRCQxIw',
            videoTitle: 'How To Do A Plank Correctly',
            videoDescription: 'Plank technique and tips for core strength by Bowflex.'
          ),
        ],
        restBetweenExercises: 120,
      ),
    ],
    'Upper body focus': [
      TrainingPlan(
        name: 'Upper Body Power',
        exercises: [
          Exercise(
            name: 'Incline Bench Press',
            sets: 4,
            reps: 8,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=SrqOu55lrYU',
            videoTitle: 'How To: Incline Bench Press',
            videoDescription: 'Incline bench press form and tips by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Weighted Pull-ups',
            sets: 4,
            reps: 8,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=ivg_Yc-YDYo',
            videoTitle: 'How To: Weighted Pull-Ups',
            videoDescription: 'Weighted pull-up progression and form by Calisthenicmovement.'
          ),
          Exercise(
            name: 'Standing Military Press',
            sets: 4,
            reps: 8,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2yjwXTZQDDg',
            videoTitle: 'How To: Overhead Press',
            videoDescription: 'Military press form and technique by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Barbell Rows',
            sets: 4,
            reps: 10,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=vT2GjY_Umpw',
            videoTitle: 'How To: Barbell Row',
            videoDescription: 'Barbell row form and back activation by Buff Dudes.'
          ),
          Exercise(
            name: 'Lateral Raises',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=3VcKaXpzqRo',
            videoTitle: 'How To: Lateral Raise',
            videoDescription: 'Lateral raise form and shoulder activation by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Face Pulls',
            sets: 3,
            reps: 15,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=rep-qVOkqgk',
            videoTitle: 'How To: Face Pulls',
            videoDescription: 'Face pulls for healthy shoulders and posture by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Skull Crushers',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=d_KZxkY_0cM',
            videoTitle: 'How To: Skull Crushers',
            videoDescription: 'Skull crushers for triceps by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Hammer Curls',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=zC3nLlEvin4',
            videoTitle: 'How To: Hammer Curl',
            videoDescription: 'Hammer curl form and biceps activation by ScottHermanFitness.'
          ),
        ],
        restBetweenExercises: 90,
      ),
    ],
    'Lower body focus': [
      TrainingPlan(
        name: 'Lower Body Power',
        exercises: [
          Exercise(
            name: 'Back Squats',
            sets: 5,
            reps: 5,
            restBetweenSets: 120,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=ultWZbUMPL8',
            videoTitle: 'How To Squat: Proper Form',
            videoDescription: 'Learn the correct form for barbell back squats with this step-by-step guide from ATHLEAN-X.'
          ),
          Exercise(
            name: 'Romanian Deadlifts',
            sets: 4,
            reps: 8,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2SHsk9AzdjA',
            videoTitle: 'How To: Romanian Deadlift',
            videoDescription: 'Romanian deadlift form and tips by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Bulgarian Split Squats',
            sets: 3,
            reps: 12,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2C-uNgKwPLE',
            videoTitle: 'How To: Bulgarian Split Squat',
            videoDescription: 'Bulgarian split squat form and balance tips by Jeff Nippard.'
          ),
          Exercise(
            name: 'Leg Press',
            sets: 4,
            reps: 10,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=IZxyjW7MPJQ',
            videoTitle: 'How To: Leg Press',
            videoDescription: 'Leg press machine technique and safety by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Walking Lunges',
            sets: 3,
            reps: 20,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=wrwwXE_x-pQ',
            videoTitle: 'How To: Walking Lunge',
            videoDescription: 'Walking lunge demonstration and tips by Buff Dudes.'
          ),
          Exercise(
            name: 'Calf Raises',
            sets: 4,
            reps: 15,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=-M4-G8p8fmc',
            videoTitle: 'How To: Standing Calf Raise',
            videoDescription: 'Standing calf raise form and ankle strength by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Leg Extensions',
            sets: 3,
            reps: 15,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=8iPEnn-ltC8',
            videoTitle: 'How To: Leg Extension',
            videoDescription: 'Leg extension machine guide for quadriceps by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Leg Curls',
            sets: 3,
            reps: 15,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=1Tq3QdYUuHs',
            videoTitle: 'How To: Leg Curl',
            videoDescription: 'Leg curl machine tutorial for hamstrings by ScottHermanFitness.'
          ),
        ],
        restBetweenExercises: 120,
      ),
    ],
    'Push day': [
      TrainingPlan(
        name: 'Push Power',
        exercises: [
          Exercise(
            name: 'Flat Barbell Bench Press',
            sets: 4,
            reps: 8,
            restBetweenSets: 120,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=gRVjAtPip0Y',
            videoTitle: 'How To: Barbell Bench Press',
            videoDescription: 'A complete tutorial on the barbell bench press for strength and muscle, by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Standing Military Press',
            sets: 4,
            reps: 8,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2yjwXTZQDDg',
            videoTitle: 'How To: Overhead Press',
            videoDescription: 'Military press form and technique by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Incline Dumbbell Press',
            sets: 3,
            reps: 10,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=8iPEnn-ltC8',
            videoTitle: 'How To: Incline Dumbbell Press',
            videoDescription: 'Incline dumbbell press for upper chest by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Lateral Raises',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=3VcKaXpzqRo',
            videoTitle: 'How To: Lateral Raise',
            videoDescription: 'Lateral raise form and shoulder activation by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Tricep Rope Pushdowns',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2-LAMcpzODU',
            videoTitle: 'How To: Tricep Rope Pushdown',
            videoDescription: 'Tricep rope pushdown technique for triceps isolation by Buff Dudes.'
          ),
          Exercise(
            name: 'Dips',
            sets: 3,
            reps: 10,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2z8JmcrW-As',
            videoTitle: 'How To: Dips',
            videoDescription: 'Proper dip form for chest and triceps by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Front Raises',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=-t7fuZ0KhDA',
            videoTitle: 'How To: Front Raise',
            videoDescription: 'Front raise for anterior deltoid by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Tricep Overhead Extensions',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=_gsUck-7M74',
            videoTitle: 'How To: Overhead Tricep Extension',
            videoDescription: 'Overhead tricep extension for long head triceps by ScottHermanFitness.'
          ),
        ],
        restBetweenExercises: 90,
      ),
    ],
    'Pull day': [
      TrainingPlan(
        name: 'Pull Power',
        exercises: [
          Exercise(
            name: 'Deadlifts',
            sets: 4,
            reps: 6,
            restBetweenSets: 120,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=op9kVnSso6Q',
            videoTitle: 'How To Deadlift: Conventional Deadlift Form',
            videoDescription: 'Deadlift form and technique explained by Jeff Nippard.'
          ),
          Exercise(
            name: 'Weighted Pull-ups',
            sets: 4,
            reps: 8,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=ivg_Yc-YDYo',
            videoTitle: 'How To: Weighted Pull-Ups',
            videoDescription: 'Weighted pull-up progression and form by Calisthenicmovement.'
          ),
          Exercise(
            name: 'Barbell Rows',
            sets: 3,
            reps: 10,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=vT2GjY_Umpw',
            videoTitle: 'How To: Barbell Row',
            videoDescription: 'Barbell row form and back activation by Buff Dudes.'
          ),
          Exercise(
            name: 'Face Pulls',
            sets: 3,
            reps: 15,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=rep-qVOkqgk',
            videoTitle: 'How To: Face Pulls',
            videoDescription: 'Face pulls for healthy shoulders and posture by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Barbell Curls',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=kwG2ipFRgfo',
            videoTitle: 'How To: Barbell Curl',
            videoDescription: 'Barbell curl for biceps strength and size by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Hammer Curls',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=zC3nLlEvin4',
            videoTitle: 'How To: Hammer Curl',
            videoDescription: 'Hammer curl form and biceps activation by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Lat Pulldowns',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=CAwf7n6Luuc',
            videoTitle: 'How To: Lat Pulldown',
            videoDescription: 'Lat pulldown machine for back width and strength by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Reverse Flyes',
            sets: 3,
            reps: 15,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=6kALZikXxLc',
            videoTitle: 'How To: Reverse Fly',
            videoDescription: 'Reverse fly for rear deltoid and upper back by Buff Dudes.'
          ),
        ],
        restBetweenExercises: 90,
      ),
    ],
    'Leg day': [
      TrainingPlan(
        name: 'Leg Power',
        exercises: [
          Exercise(
            name: 'Back Squats',
            sets: 5,
            reps: 5,
            restBetweenSets: 120,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=ultWZbUMPL8',
            videoTitle: 'How To Squat: Proper Form',
            videoDescription: 'Learn the correct form for barbell back squats with this step-by-step guide from ATHLEAN-X.'
          ),
          Exercise(
            name: 'Romanian Deadlifts',
            sets: 4,
            reps: 8,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2SHsk9AzdjA',
            videoTitle: 'How To: Romanian Deadlift',
            videoDescription: 'Romanian deadlift form and tips by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Leg Press',
            sets: 4,
            reps: 10,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=IZxyjW7MPJQ',
            videoTitle: 'How To: Leg Press',
            videoDescription: 'Leg press machine technique and safety by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Bulgarian Split Squats',
            sets: 3,
            reps: 12,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2C-uNgKwPLE',
            videoTitle: 'How To: Bulgarian Split Squat',
            videoDescription: 'Bulgarian split squat form and balance tips by Jeff Nippard.'
          ),
          Exercise(
            name: 'Leg Extensions',
            sets: 3,
            reps: 15,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=8iPEnn-ltC8',
            videoTitle: 'How To: Leg Extension',
            videoDescription: 'Leg extension machine guide for quadriceps by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Leg Curls',
            sets: 3,
            reps: 15,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=1Tq3QdYUuHs',
            videoTitle: 'How To: Leg Curl',
            videoDescription: 'Leg curl machine tutorial for hamstrings by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Standing Calf Raises',
            sets: 4,
            reps: 15,
            restBetweenSets: 45,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=-M4-G8p8fmc',
            videoTitle: 'How To: Standing Calf Raise',
            videoDescription: 'Standing calf raise form and ankle strength by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Seated Calf Raises',
            sets: 3,
            reps: 20,
            restBetweenSets: 45,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=YMmgqO8Jo-k',
            videoTitle: 'How To: Seated Calf Raise',
            videoDescription: 'Seated calf raise for soleus muscle activation by ScottHermanFitness.'
          ),
        ],
        restBetweenExercises: 120,
      ),
    ],
    'Core workout': [
      TrainingPlan(
        name: 'Core Strength',
        exercises: [
          Exercise(
            name: 'Weighted Planks',
            sets: 3,
            reps: 45,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=pSHjTRCQxIw',
            videoTitle: 'How To Do A Plank Correctly',
            videoDescription: 'Plank technique and tips for core strength by Bowflex.'
          ),
          Exercise(
            name: 'Cable Woodchoppers',
            sets: 3,
            reps: 12,
            restBetweenSets: 45,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=QnQe0xW_JY4',
            videoTitle: 'How To: Cable Woodchopper',
            videoDescription: 'Cable woodchopper for rotational core strength by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Hanging Leg Raises',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=JB2oyawG9KI',
            videoTitle: 'How To: Hanging Leg Raise',
            videoDescription: 'Hanging leg raise for lower abs and hip flexors by Calisthenicmovement.'
          ),
          Exercise(
            name: 'Ab Wheel Rollouts',
            sets: 3,
            reps: 10,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=VmB1G1K7v94',
            videoTitle: 'How To: Ab Wheel Rollout',
            videoDescription: 'Ab wheel rollout for core and shoulder stability by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Cable Crunches',
            sets: 3,
            reps: 15,
            restBetweenSets: 45,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=QJYkFf09p1E',
            videoTitle: 'How To: Cable Crunch',
            videoDescription: 'Cable crunch for rectus abdominis activation by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Russian Twists',
            sets: 3,
            reps: 20,
            restBetweenSets: 45,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=wkD8rjkodUI',
            videoTitle: 'How To: Russian Twist',
            videoDescription: 'Russian twist for oblique and core strength by Buff Dudes.'
          ),
          Exercise(
            name: 'Dragon Flags',
            sets: 3,
            reps: 8,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=UdsNBIzsmlI',
            videoTitle: 'How To: Dragon Flag',
            videoDescription: 'Dragon flag for advanced core strength by Calisthenicmovement.'
          ),
          Exercise(
            name: 'Pallof Press',
            sets: 3,
            reps: 12,
            restBetweenSets: 45,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=5UmB-F7wVOc',
            videoTitle: 'How To: Pallof Press',
            videoDescription: 'Pallof press for anti-rotational core stability by ATHLEAN-X.'
          ),
        ],
        restBetweenExercises: 60,
      ),
    ],
    'HIIT circuit': [
      TrainingPlan(
        name: 'High Intensity Circuit',
        exercises: [
          Exercise(
            name: 'Battle Rope Waves',
            sets: 4,
            reps: 30,
            restBetweenSets: 30,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=Q08bOe1eC5Y',
            videoTitle: 'How To: Battle Rope Waves',
            videoDescription: 'Battle rope waves for conditioning and upper body endurance by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Kettlebell Swings',
            sets: 4,
            reps: 20,
            restBetweenSets: 30,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=6u6HHPmF2Rc',
            videoTitle: 'How To: Kettlebell Swing',
            videoDescription: 'Kettlebell swing for explosive hip power and conditioning by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Box Jumps',
            sets: 4,
            reps: 12,
            restBetweenSets: 30,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=52r_U6O-5U8',
            videoTitle: 'How To: Box Jump',
            videoDescription: 'Box jump for lower body power and explosiveness by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Burpees',
            sets: 4,
            reps: 10,
            restBetweenSets: 30,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=TU8QYVW0gDU',
            videoTitle: 'How To: Burpee',
            videoDescription: 'Burpee form and technique by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Medicine Ball Slams',
            sets: 4,
            reps: 15,
            restBetweenSets: 30,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2H8l5M6V8gE',
            videoTitle: 'How To: Medicine Ball Slam',
            videoDescription: 'Medicine ball slam for power and conditioning by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Rowing Sprints',
            sets: 4,
            reps: 200,
            restBetweenSets: 45,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=9A4ASwTzFdo',
            videoTitle: 'How To: Rowing Sprint',
            videoDescription: 'Rowing sprint for full-body cardio and power by Concept2.'
          ),
          Exercise(
            name: 'Mountain Climbers',
            sets: 4,
            reps: 30,
            restBetweenSets: 30,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=nmwgirgXLYM',
            videoTitle: 'How To: Mountain Climber',
            videoDescription: 'Mountain climber for cardio and core by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Jump Rope',
            sets: 4,
            reps: 50,
            restBetweenSets: 30,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=1BZMwQ6cD-c',
            videoTitle: 'How To: Jump Rope',
            videoDescription: 'Jump rope for cardio, coordination, and footwork by ATHLEAN-X.'
          ),
        ],
        restBetweenExercises: 60,
      ),
    ],
    'Powerlifting session': [
      TrainingPlan(
        name: 'Power Development',
        exercises: [
          Exercise(
            name: 'Dynamic Warm-up & Mobility',
            sets: 1,
            reps: 12,
            restBetweenSets: 0,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=6t2I8K0l2lU',
            videoTitle: 'How To: Dynamic Warm-up',
            videoDescription: 'Dynamic warm-up routine to prepare your body for heavy lifting by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Back Squat (Progressive: 60-75-85-90% 1RM)',
            sets: 4,
            reps: 5,
            restBetweenSets: 180,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=ultWZbUMPL8',
            videoTitle: 'How To Squat: Proper Form',
            videoDescription: 'Learn the correct form for barbell back squats with this step-by-step guide from ATHLEAN-X.'
          ),
          Exercise(
            name: 'Bench Press (Progressive: 60-75-85-90% 1RM)',
            sets: 4,
            reps: 5,
            restBetweenSets: 180,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=gRVjAtPip0Y',
            videoTitle: 'How To: Barbell Bench Press',
            videoDescription: 'A complete tutorial on the barbell bench press for strength and muscle, by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Deadlift (Progressive: 60-75-85-90% 1RM)',
            sets: 4,
            reps: 3,
            restBetweenSets: 240,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=op9kVnSso6Q',
            videoTitle: 'How To Deadlift: Conventional Deadlift Form',
            videoDescription: 'Deadlift form and technique explained by Jeff Nippard.'
          ),
          Exercise(
            name: 'Accessory: Rows',
            sets: 3,
            reps: 8,
            restBetweenSets: 120,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=vT2GjY_Umpw',
            videoTitle: 'How To: Barbell Row',
            videoDescription: 'Barbell row form and back activation by Buff Dudes.'
          ),
          Exercise(
            name: 'Accessory: Core Work',
            sets: 3,
            reps: 12,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=VmB1G1K7v94',
            videoTitle: 'How To: Ab Wheel Rollout',
            videoDescription: 'Ab wheel rollout for core and shoulder stability by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Technique Practice (Light Weight)',
            sets: 2,
            reps: 5,
            restBetweenSets: 120,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=QF0BQS2W80k',
            videoTitle: 'How To: Barbell Technique Practice',
            videoDescription: 'Practice barbell technique with light weight to improve form and safety by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Cool Down & Stretching',
            sets: 1,
            reps: 10,
            restBetweenSets: 0,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2L2lnxIcNmo',
            videoTitle: 'How To: Full Body Cool Down',
            videoDescription: 'Full body cool down and stretching routine after heavy lifting by ATHLEAN-X.'
          ),
        ],
        restBetweenExercises: 240,
      ),
    ],
    'Strength and cardio mix': [
      TrainingPlan(
        name: 'Hybrid Performance',
        exercises: [
          Exercise(
            name: 'Dynamic Warm-up Circuit',
            sets: 1,
            reps: 10,
            restBetweenSets: 0,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=6t2I8K0l2lU',
            videoTitle: 'How To: Dynamic Warm-up',
            videoDescription: 'Dynamic warm-up routine to prepare your body for a hybrid session by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Heavy Compound Lift (Squat/Deadlift)',
            sets: 4,
            reps: 6,
            restBetweenSets: 120,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=ultWZbUMPL8',
            videoTitle: 'How To Squat: Proper Form',
            videoDescription: 'Learn the correct form for barbell back squats with this step-by-step guide from ATHLEAN-X.'
          ),
          Exercise(
            name: 'Rowing Sprint',
            sets: 3,
            reps: 250,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=9A4ASwTzFdo',
            videoTitle: 'How To: Rowing Sprint',
            videoDescription: 'Rowing sprint for full-body cardio and power by Concept2.'
          ),
          Exercise(
            name: 'Upper Body Push/Pull Superset',
            sets: 3,
            reps: 10,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2yjwXTZQDDg',
            videoTitle: 'How To: Overhead Press',
            videoDescription: 'Military press form and technique by ScottHermanFitness.'
          ),
          Exercise(
            name: 'Box Jumps',
            sets: 3,
            reps: 8,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=52r_U6O-5U8',
            videoTitle: 'How To: Box Jump',
            videoDescription: 'Box jump for lower body power and explosiveness by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Battle Rope Intervals',
            sets: 4,
            reps: 30,
            restBetweenSets: 45,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=Q08bOe1eC5Y',
            videoTitle: 'How To: Battle Rope Waves',
            videoDescription: 'Battle rope waves for conditioning and upper body endurance by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Kettlebell Complex',
            sets: 3,
            reps: 6,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=6u6HHPmF2Rc',
            videoTitle: 'How To: Kettlebell Swing',
            videoDescription: 'Kettlebell swing for explosive hip power and conditioning by ATHLEAN-X.'
          ),
          Exercise(
            name: 'Cool Down Cardio',
            sets: 1,
            reps: 8,
            restBetweenSets: 0,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2L2lnxIcNmo',
            videoTitle: 'How To: Full Body Cool Down',
            videoDescription: 'Full body cool down and stretching routine after a hybrid session by ATHLEAN-X.'
          ),
        ],
        restBetweenExercises: 120,
      ),
    ],
  },
};