import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StreakService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Record user activity for the current day
  Future<void> recordActivity() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final today = DateTime.now();
    final dateString = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('activity')
        .doc(dateString)
        .set({
      'timestamp': FieldValue.serverTimestamp(),
      'date': dateString,
      'lastSpinTime': FieldValue.serverTimestamp(),
    });
  }

  // Check if user has used their daily spin and get next available time
  Future<Map<String, dynamic>> checkDailySpin() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return {'canSpin': false, 'nextSpinTime': null};

    final today = DateTime.now();
    final dateString = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('activity')
        .doc(dateString)
        .get();

    if (!doc.exists) {
      return {'canSpin': true, 'nextSpinTime': null};
    }

    final lastSpinTime = doc.data()?['lastSpinTime'] as Timestamp?;
    if (lastSpinTime == null) {
      return {'canSpin': true, 'nextSpinTime': null};
    }

    final lastSpinDateTime = lastSpinTime.toDate();
    final nextAvailableTime = DateTime(
      lastSpinDateTime.year,
      lastSpinDateTime.month,
      lastSpinDateTime.day + 1,
    );

    return {
      'canSpin': today.isAfter(nextAvailableTime),
      'nextSpinTime': nextAvailableTime,
    };
  }

  // Get user's activity for a specific month
  Future<Map<String, bool>> getMonthlyActivity(int year, int month) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return {};

    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0);
    final startDateString = '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
    final endDateString = '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';

    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('activity')
        .where('date', isGreaterThanOrEqualTo: startDateString)
        .where('date', isLessThanOrEqualTo: endDateString)
        .get();

    final Map<String, bool> activityMap = {};
    for (var doc in snapshot.docs) {
      activityMap[doc.id] = true;
    }

    return activityMap;
  }

  // Calculate current streak
  Future<int> getCurrentStreak() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return 0;

    final today = DateTime.now();
    var currentDate = today;
    var streak = 0;

    while (true) {
      final dateString = '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}';
      
      final doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('activity')
          .doc(dateString)
          .get();

      if (!doc.exists) {
        // If we're checking today and there's no activity, don't break the streak
        if (currentDate.year == today.year && 
            currentDate.month == today.month && 
            currentDate.day == today.day) {
          streak++;
        }
        break;
      }

      streak++;
      currentDate = currentDate.subtract(const Duration(days: 1));
    }

    return streak;
  }

  // Get the best streak
  Future<int> getBestStreak() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return 0;

    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .get();

    return doc.data()?['bestStreak'] ?? 0;
  }

  // Update best streak if current streak is higher
  Future<void> updateBestStreak(int currentStreak) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .get();

    final bestStreak = doc.data()?['bestStreak'] ?? 0;
    if (currentStreak > bestStreak) {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({'bestStreak': currentStreak});
    }
  }
} 