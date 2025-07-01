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
          Exercise(
            name: 'Incline Bench Press',
            sets: 4,
            reps: 8,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=SrqOu55lrYU',
            videoTitle: 'Incline Bench Press Tutorial',
            videoDescription: 'Learn how to perform the incline bench press with proper form.',
          ),
          Exercise(
            name: 'Weighted Pull-ups',
            sets: 4,
            reps: 8,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=ivg_Yc-YDYo',
            videoTitle: 'Weighted Pull-ups Guide',
            videoDescription: 'How to do weighted pull-ups safely and effectively.',
          ),
          Exercise(
            name: 'Standing Military Press',
            sets: 4,
            reps: 8,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=B-aVuyhvLHU',
            videoTitle: 'Standing Military Press Tutorial',
            videoDescription: 'Proper technique for the standing military press.',
          ),
          Exercise(
            name: 'Barbell Rows',
            sets: 4,
            reps: 10,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=G8l_8chR5BE',
            videoTitle: 'Barbell Row Form',
            videoDescription: 'Master the barbell row for a strong back and proper posture.',
          ),
          Exercise(
            name: 'Lateral Raises',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=3VcKaXpzqRo',
            videoTitle: 'Lateral Raises Tutorial',
            videoDescription: 'How to do lateral raises for shoulder development.',
          ),
          Exercise(
            name: 'Face Pulls',
            sets: 3,
            reps: 15,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=rep-qVOkqgk',
            videoTitle: 'Face Pulls Tutorial',
            videoDescription: 'Face pulls for healthy shoulders and posture.',
          ),
          Exercise(
            name: 'Skull Crushers',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=d_KZxkY_0cM',
            videoTitle: 'Skull Crushers Tutorial',
            videoDescription: 'How to perform skull crushers for triceps.',
          ),
          Exercise(
            name: 'Hammer Curls',
            sets: 3,
            reps: 12,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=zC3nLlEvin4',
            videoTitle: 'Hammer Curls Tutorial',
            videoDescription: 'Hammer curls for forearm and biceps strength.',
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
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=SW_C1A-rejs',
            videoTitle: 'Proper Barbell Back Squat Form',
            videoDescription: 'Learn the correct form for barbell back squats with proper depth and technique.'
          ),
          Exercise(
            name: 'Romanian Deadlifts',
            sets: 4,
            reps: 8,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2SHsk9AzdjA',
            videoTitle: 'Romanian Deadlift Tutorial',
            videoDescription: 'How to perform Romanian Deadlifts for hamstring and glute strength. Focus on hip hinge and flat back.'
          ),
          Exercise(
            name: 'Bulgarian Split Squats',
            sets: 3,
            reps: 12,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=2C-uNgKwPLE',
            videoTitle: 'Bulgarian Split Squat Guide',
            videoDescription: 'Step-by-step guide to Bulgarian Split Squats for unilateral leg strength and balance.'
          ),
          Exercise(
            name: 'Leg Press',
            sets: 4,
            reps: 10,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=IZxyjW7MPJQ',
            videoTitle: 'Leg Press Machine Tutorial',
            videoDescription: 'Learn proper leg press technique to maximize quad, hamstring, and glute activation.'
          ),
          Exercise(
            name: 'Walking Lunges',
            sets: 3,
            reps: 20,
            restBetweenSets: 90,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=wrwwXE_x-pQ',
            videoTitle: 'Walking Lunge Exercise',
            videoDescription: 'Demonstration of walking lunges for leg strength, stability, and coordination.'
          ),
          Exercise(
            name: 'Calf Raises',
            sets: 4,
            reps: 15,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=-M4-G8p8fmc',
            videoTitle: 'Standing Calf Raise Tutorial',
            videoDescription: 'How to do standing calf raises for calf muscle development and ankle strength.'
          ),
          Exercise(
            name: 'Leg Extensions',
            sets: 3,
            reps: 15,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=8iPEnn-ltC8',
            videoTitle: 'Leg Extension Machine Guide',
            videoDescription: 'Proper use of the leg extension machine to isolate and strengthen the quadriceps.'
          ),
          Exercise(
            name: 'Leg Curls',
            sets: 3,
            reps: 15,
            restBetweenSets: 60,
            youtubeVideoUrl: 'https://www.youtube.com/watch?v=1Tq3QdYUuHs',
            videoTitle: 'Leg Curl Machine Tutorial',
            videoDescription: 'Learn how to use the leg curl machine for effective hamstring training.'
          ),
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
};