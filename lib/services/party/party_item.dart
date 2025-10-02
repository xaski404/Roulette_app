import 'package:cloud_firestore/cloud_firestore.dart';

class PartyItem {
  final String id;
  final String content; // Treść zadania
  final String type; // "pytanie" | "wyzwanie"
  final String gameCategory; // np. "klasyczna" | "dla par" | "imprezowa"
  final String language; // np. "pl"

  const PartyItem({
    required this.id,
    required this.content,
    required this.type,
    required this.gameCategory,
    required this.language,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'type': type,
      'gameCategory': gameCategory,
      'language': language,
    };
  }

  factory PartyItem.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return PartyItem(
      id: doc.id,
      content: (data['content'] ?? '') as String,
      type: (data['type'] ?? '') as String,
      gameCategory: (data['gameCategory'] ?? '') as String,
      language: (data['language'] ?? 'pl') as String,
    );
  }
}


