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
}


