import 'package:flutter/widgets.dart';
import 'package:iiitd_mentorship/app/data/model/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingServiceRepository extends CalendarDataSource {
  MeetingServiceRepository(List<Meeting> source) {
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
