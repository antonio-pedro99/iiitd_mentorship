import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iiitd_mentorship/app/data/model/meeting.dart';

import 'package:rxdart/rxdart.dart';

class MeetingService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> addMeeting(Meeting meeting) async {
    await _firestore.collection('meetings').add(meeting.toMap());
  }

  static Stream<List<Meeting>> getMeetingsStream() async* {
    String currentUserEmail = _auth.currentUser?.email ?? '';
    String currentUserId = _auth.currentUser?.uid ?? '';

    // Stream of meetings created by the user
    var userMeetingsStream = _firestore
        .collection('meetings')
        .where('userId', isEqualTo: currentUserId)
        .snapshots();

    // Stream of all meetings
    var allMeetingsStream = _firestore.collection('meetings').snapshots();

    await for (var combinedSnapshot in Rx.combineLatest2(userMeetingsStream, allMeetingsStream, (userMeetings, allMeetings) {
      return userMeetings.docs.map((doc) => Meeting.fromMap(doc.data(), doc.id)).toList()
        ..addAll(allMeetings.docs
            .where((doc) => doc.data()['emailIDs'].toString().split(',').map((email) => email.trim()).contains(currentUserEmail))
            .map((doc) => Meeting.fromMap(doc.data(), doc.id))
            .toList());
    })) {
      yield combinedSnapshot.toSet().toList(); // To remove duplicates
    }
  }
  static Future<void> deleteMeeting(String eventId) async {
    await _firestore.collection('meetings').doc(eventId).delete();
  }

  static Future<String> getUserName(String userId) async {
    var userDocument = await _firestore.collection('users').doc(userId).get();
    return userDocument.data()?['name'] ?? 'Unknown User';
  }
}