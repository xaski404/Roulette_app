import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../lib/services/exercise_video_service.dart';
import '../lib/firebase_options.dart';

/// Automatyczne generowanie mapy przypisań ćwiczeń do planów i filmików
Future<List<Map<String, String>>> generateAssignments() async {
  final file = File('Roulette/lib/services/training_plan_service.dart');
  final lines = await file.readAsLines();
  final assignments = <Map<String, String>>[];
  String? currentCategory;
  String? currentWorkout;
  final RegExp categoryExp = RegExp(r"'([^']+)': \{");
  final RegExp workoutExp = RegExp(r"'([^']+)': \[");
  final RegExp planNameExp = RegExp(r"name: '([^']+)',");
  final RegExp exerciseExp = RegExp(r"Exercise\(([^)]*)\)");
  final RegExp nameExp = RegExp(r"name: '([^']+)'[,)]");
  final RegExp urlExp = RegExp(r"youtubeVideoUrl: '([^']+)'[,)]");
  final RegExp titleExp = RegExp(r"videoTitle: '([^']+)'[,)]");
  final RegExp descExp = RegExp(r"videoDescription: '([^']+)'[,)]");

  for (int i = 0; i < lines.length; i++) {
    final line = lines[i];
    final catMatch = categoryExp.firstMatch(line);
    if (catMatch != null) {
      currentCategory = catMatch.group(1);
      continue;
    }
    final workoutMatch = workoutExp.firstMatch(line);
    if (workoutMatch != null) {
      currentWorkout = workoutMatch.group(1);
      continue;
    }
    if (line.contains('TrainingPlan(')) {
      // planName is on next line
      final planLine = lines[i+1];
      final planMatch = planNameExp.firstMatch(planLine);
      if (planMatch != null) {
        currentWorkout = planMatch.group(1);
      }
      continue;
    }
    final exMatch = exerciseExp.firstMatch(line);
    if (exMatch != null) {
      final exFields = exMatch.group(1)!;
      final nameMatch = nameExp.firstMatch(exFields);
      final urlMatch = urlExp.firstMatch(exFields);
      final titleMatch = titleExp.firstMatch(exFields);
      final descMatch = descExp.firstMatch(exFields);
      final exerciseName = nameMatch?.group(1) ?? 'UNKNOWN';
      final youtubeVideoUrl = urlMatch?.group(1);
      final videoTitle = titleMatch?.group(1);
      final videoDescription = descMatch?.group(1);
      assignments.add({
        'exerciseName': exerciseName,
        'youtubeVideoUrl': youtubeVideoUrl ?? 'https://www.youtube.com/watch?v=VIDEO_PLACEHOLDER',
        'videoTitle': videoTitle ?? 'Instruktaż do $exerciseName',
        'videoDescription': videoDescription ?? 'Brak opisu. Uzupełnij.',
        'category': currentCategory ?? 'UNKNOWN',
        'workoutName': currentWorkout ?? 'UNKNOWN',
      });
    }
  }
  return assignments;
}

Future<void> main() async {
  print('Inicjalizacja Firebase...');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // UWAGA: Musisz być zalogowany jako admin lub użytkownik z uprawnieniami do zapisu!
  final auth = FirebaseAuth.instance;
  if (auth.currentUser == null) {
    print('Zaloguj się przed uruchomieniem narzędzia!');
    return;
  }

  print('Generuję mapę przypisań ćwiczeń do filmików...');
  final assignments = await generateAssignments();
  print('Liczba ćwiczeń do aktualizacji: ${assignments.length}');

  final service = ExerciseVideoService();
  print('Aktualizuję filmiki dla ćwiczeń...');
  try {
    await service.batchUpdateAllMissingVideos(assignments);
    print('Aktualizacja zakończona sukcesem!');
  } catch (e) {
    print('Błąd podczas aktualizacji:');
    print(e);
  }
} 