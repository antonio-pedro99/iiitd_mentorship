import 'package:flutter/material.dart';

class Meeting {
  late String eventId;
  String eventName;
  String title;
  String description;
  String emailIDs;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String userId;

  Meeting(this.eventName, this.title, this.description, this.emailIDs,
      this.from, this.to, this.background, this.isAllDay, this.userId);

  Meeting.fromMap(Map<String, dynamic> data, this.eventId)
      : eventName = data['eventName'],
        title = data['title'],
        description = data['description'],
        emailIDs = data['emailIDs'],
        from = data['from'].toDate(),
        to = data['to'].toDate(),
        background = Color(data['background']),
        isAllDay = data['isAllDay'],
        userId = data['userId'];

  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'title': title,
      'description': description,
      'emailIDs': emailIDs,
      'from': from,
      'to': to,
      'background': background.value,
      'isAllDay': isAllDay,
      'userId': userId,
    };
  }
}
