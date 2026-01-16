import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Stream to get all clubs in real-time
  Stream<QuerySnapshot> getClubsStream() {
    return _db.collection('clubs').snapshots();
  }

  // Stream a single club's document
  Stream<DocumentSnapshot> getClubStream(String clubId) {
    return _db.collection('clubs').doc(clubId).snapshots();
  }

  // Add current user to club members
  Future<void> joinClub(String clubId, String userId) async {
    await _db.collection('clubs').doc(clubId).update({
      'members': FieldValue.arrayUnion([userId]),
    });
  }

  // Remove current user from club members
  Future<void> leaveClub(String clubId, String userId) async {
    await _db.collection('clubs').doc(clubId).update({
      'members': FieldValue.arrayRemove([userId]),
    });
  }

  // Add a new event to the club
  Future<void> addEvent(String clubId, Map<String, dynamic> eventData) async {
    final docRef = _db.collection('clubs').doc(clubId);
    await docRef.update({
      'events': FieldValue.arrayUnion([eventData])
    });
  }

  // Add a new announcement to the club
  Future<void> addAnnouncement(String clubId, Map<String, dynamic> announcementData) async {
    final docRef = _db.collection('clubs').doc(clubId);
    await docRef.update({
      'announcements': FieldValue.arrayUnion([announcementData])
    });
  }
}
