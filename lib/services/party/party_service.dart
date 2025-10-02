import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'party_item.dart';

class PartyService {
  static const String collectionName = 'party_items';
  final FirebaseFirestore _db;
  final Random _random;

  PartyService({FirebaseFirestore? firestore, Random? random})
      : _db = firestore ?? FirebaseFirestore.instance,
        _random = random ?? Random();

  Future<PartyItem?> getRandomItem({
    required String type, // "pytanie" | "wyzwanie"
    required String gameCategory, // "klasyczna" | "dla par" | "imprezowa"
    String language = 'pl',
  }) async {
    // Query matching docs
    final query = await _db
        .collection(collectionName)
        .where('type', isEqualTo: type)
        .where('gameCategory', isEqualTo: gameCategory)
        .where('language', isEqualTo: language)
        .limit(100) // cap to avoid large memory usage; random pick from subset
        .get();

    if (query.docs.isEmpty) return null;
    final int idx = _random.nextInt(query.docs.length);
    final doc = query.docs[idx];
    return PartyItem.fromDoc(doc);
  }

  Future<void> addPartyItem({
    required String content,
    required String type, // "pytanie" | "wyzwanie"
    required String gameCategory, // "klasyczna" | "dla par" | "imprezowa"
    String language = 'pl',
  }) async {
    await _db.collection(collectionName).add({
      'content': content,
      'type': type,
      'gameCategory': gameCategory,
      'language': language,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> addPartyItemsBatch(List<Map<String, String>> items) async {
    if (items.isEmpty) return;
    final batch = _db.batch();
    final col = _db.collection(collectionName);
    for (final item in items) {
      final docRef = col.doc();
      batch.set(docRef, {
        'content': item['content'] ?? '',
        'type': item['type'] ?? 'pytanie',
        'gameCategory': item['gameCategory'] ?? 'klasyczna',
        'language': item['language'] ?? 'pl',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
    await batch.commit();
  }
}


