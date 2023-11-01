import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'create.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key, required this.title});
  final String title;
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<Meeting> meetings = <Meeting>[];

  @override
  void initState() {
    meetings = _getDataSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Month Agenda View')),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(meetings),
        monthViewSettings: MonthViewSettings(showAgenda: true),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleMeetingScreen()));
          setState(() {
            meetings = _getDataSource();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<Meeting> _getDataSource() {
    return MeetingData.meetings;
  }
}


class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
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
