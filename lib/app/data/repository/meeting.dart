import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MeetingData {
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


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments?[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments?[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments?[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments?[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments?[index].isAllDay;
  }
}
