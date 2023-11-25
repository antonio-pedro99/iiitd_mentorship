import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iiitd_mentorship/app/data/model/meeting.dart';

class MeetingService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> addMeeting(Meeting meeting) async {
    await _firestore.collection('meetings').add(meeting.toMap());
  }

  static Stream<List<Meeting>> getMeetingsStream() {
    return _firestore
        .collection('meetings')
        .where('userId', isEqualTo: _auth.currentUser?.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Meeting.fromMap(doc.data(), doc.id))
            .toList());
  }

  static Future<void> deleteMeeting(String eventId) async {
    await _firestore.collection('meetings').doc(eventId).delete();
  }
}