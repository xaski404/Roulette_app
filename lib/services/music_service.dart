import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MusicService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Music categories
  static const List<String> categories = [
    'Song',
    'Album',
    'Playlist',
    'Music genre'
  ];

  // Default music options for each category
  final Map<String, List<String>> defaultMusicOptions = {
    'Song': [
      'Bohemian Rhapsody - Queen',
      'Stairway to Heaven - Led Zeppelin',
      'Hotel California - Eagles',
      'Sweet Child O\' Mine - Guns N\' Roses',
      'Smells Like Teen Spirit - Nirvana',
      'Billie Jean - Michael Jackson',
      'Sweet Home Alabama - Lynyrd Skynyrd',
      'Don\'t Stop Believin\' - Journey',
      'Sweet Caroline - Neil Diamond',
      'Livin\' on a Prayer - Bon Jovi'
    ],
    'Album': [
      'Thriller - Michael Jackson',
      'The Dark Side of the Moon - Pink Floyd',
      'Abbey Road - The Beatles',
      'Back in Black - AC/DC',
      'Rumours - Fleetwood Mac',
      'Nevermind - Nirvana',
      'Purple Rain - Prince',
      'Born to Run - Bruce Springsteen',
      'The Joshua Tree - U2',
      'Appetite for Destruction - Guns N\' Roses'
    ],
    'Playlist': [
      'Top Hits 2024',
      'Chill Vibes',
      'Workout Mix',
      'Classic Rock',
      'Jazz Essentials',
      'Hip Hop Classics',
      'Indie Discoveries',
      'Party Anthems',
      'Acoustic Sessions',
      'Electronic Beats'
    ],
    'Music genre': [
      'Rock',
      'Pop',
      'Hip Hop',
      'Jazz',
      'Classical',
      'Electronic',
      'R&B',
      'Country',
      'Blues',
      'Reggae'
    ]
  };

  // Initialize default music options for a user
  Future<void> initializeDefaultMusicOptions() async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final userMusicRef = _firestore.collection('users').doc(userId).collection('music');
    
    // Check if user already has music options initialized
    final snapshot = await userMusicRef.limit(1).get();
    if (snapshot.docs.isNotEmpty) return;

    // Initialize default music options for each category
    for (var category in categories) {
      await userMusicRef.doc(category.toLowerCase().replaceAll(' ', '_')).set({
        'options': defaultMusicOptions[category],
        'category': category,
      });
    }
  }

  // Get music options for a specific category
  Future<List<String>> getMusicOptionsForCategory(String category) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return [];

    try {
      final docSnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('music')
          .doc(category.toLowerCase().replaceAll(' ', '_'))
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();
        return List<String>.from(data?['options'] ?? []);
      }
      return defaultMusicOptions[category] ?? [];
    } catch (e) {
      print('Error getting music options: $e');
      return [];
    }
  }

  // Add a new music option to a category
  Future<void> addMusicOptionToCategory(String category, String option) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('music')
        .doc(category.toLowerCase().replaceAll(' ', '_'));

    await _firestore.runTransaction((transaction) async {
      final docSnapshot = await transaction.get(docRef);
      if (docSnapshot.exists) {
        final currentOptions = List<String>.from(docSnapshot.data()?['options'] ?? []);
        if (!currentOptions.contains(option)) {
          currentOptions.add(option);
          transaction.update(docRef, {'options': currentOptions});
        }
      } else {
        transaction.set(docRef, {
          'options': [option],
          'category': category,
        });
      }
    });
  }

  // Remove a music option from a category
  Future<void> removeMusicOptionFromCategory(String category, String option) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('music')
        .doc(category.toLowerCase().replaceAll(' ', '_'));

    await _firestore.runTransaction((transaction) async {
      final docSnapshot = await transaction.get(docRef);
      if (docSnapshot.exists) {
        final currentOptions = List<String>.from(docSnapshot.data()?['options'] ?? []);
        currentOptions.remove(option);
        transaction.update(docRef, {'options': currentOptions});
      }
    });
  }

  // Get Spotify URL for a music option
  String getSpotifyUrl(String category, String option) {
    final encodedOption = Uri.encodeComponent(option);
    switch (category) {
      case 'Song':
        return 'https://open.spotify.com/search/$encodedOption';
      case 'Album':
        return 'https://open.spotify.com/search/$encodedOption';
      case 'Playlist':
        return 'https://open.spotify.com/search/$encodedOption';
      case 'Music genre':
        return 'https://open.spotify.com/search/$encodedOption';
      default:
        return 'https://open.spotify.com';
    }
  }
} 