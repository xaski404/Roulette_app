import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExerciseVideoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Add or update video data for an exercise
  Future<void> addExerciseVideo({
    required String exerciseName,
    required String youtubeVideoUrl,
    String? videoTitle,
    String? videoDescription,
    String? category,
    String? workoutName,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');

    final videoData = {
      'exerciseName': exerciseName,
      'youtubeVideoUrl': youtubeVideoUrl,
      'videoTitle': videoTitle,
      'videoDescription': videoDescription,
      'category': category,
      'workoutName': workoutName,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('exercise_videos')
        .doc(exerciseName.toLowerCase().replaceAll(' ', '_'))
        .set(videoData, SetOptions(merge: true));
  }

  /// Get video data for a specific exercise
  Future<Map<String, dynamic>?> getExerciseVideo(String exerciseName) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return null;

    try {
      final docSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('exercise_videos')
          .doc(exerciseName.toLowerCase().replaceAll(' ', '_'))
          .get();

      if (docSnapshot.exists) {
        return docSnapshot.data();
      }
      return null;
    } catch (e) {
      print('Error getting exercise video: $e');
      return null;
    }
  }

  /// Get all exercise videos for a user
  Future<List<Map<String, dynamic>>> getAllExerciseVideos() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('exercise_videos')
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => doc.data())
          .toList();
    } catch (e) {
      print('Error getting all exercise videos: $e');
      return [];
    }
  }

  /// Get exercise videos for a specific category
  Future<List<Map<String, dynamic>>> getExerciseVideosByCategory(String category) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('exercise_videos')
          .where('category', isEqualTo: category)
          .orderBy('createdAt', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => doc.data())
          .toList();
    } catch (e) {
      print('Error getting exercise videos by category: $e');
      return [];
    }
  }

  /// Delete video data for an exercise
  Future<void> deleteExerciseVideo(String exerciseName) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('exercise_videos')
        .doc(exerciseName.toLowerCase().replaceAll(' ', '_'))
        .delete();
  }

  /// Batch update exercise videos for a training plan
  Future<void> updateTrainingPlanVideos({
    required String category,
    required String workoutName,
    required List<Map<String, dynamic>> exerciseVideos,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');

    final batch = _firestore.batch();
    final videosRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('exercise_videos');

    for (final videoData in exerciseVideos) {
      final exerciseName = videoData['exerciseName'] as String;
      final docRef = videosRef.doc(exerciseName.toLowerCase().replaceAll(' ', '_'));
      
      batch.set(docRef, {
        ...videoData,
        'category': category,
        'workoutName': workoutName,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }

    await batch.commit();
  }

  /// Search exercise videos by name
  Future<List<Map<String, dynamic>>> searchExerciseVideos(String searchTerm) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('exercise_videos')
          .get();

      return querySnapshot.docs
          .map((doc) => doc.data())
          .where((video) => video['exerciseName']
              .toString()
              .toLowerCase()
              .contains(searchTerm.toLowerCase()))
          .toList();
    } catch (e) {
      print('Error searching exercise videos: $e');
      return [];
    }
  }

  /// Get video statistics for analytics
  Future<Map<String, dynamic>> getVideoStatistics() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return {};

    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('exercise_videos')
          .get();

      final videos = querySnapshot.docs.map((doc) => doc.data()).toList();
      
      return {
        'totalVideos': videos.length,
        'categories': videos.map((v) => v['category']).whereType<String>().toSet().length,
        'workouts': videos.map((v) => v['workoutName']).whereType<String>().toSet().length,
        'recentVideos': videos.take(5).toList(),
      };
    } catch (e) {
      print('Error getting video statistics: $e');
      return {};
    }
  }
} 