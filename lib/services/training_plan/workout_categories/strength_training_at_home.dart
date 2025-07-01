import '../../training_plan_models.dart';

final Map<String, Map<String, List<TrainingPlan>>> strengthTrainingAtHomePlans = {
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
};