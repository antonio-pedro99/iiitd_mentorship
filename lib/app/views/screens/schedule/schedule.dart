import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/meeting.dart';
import 'package:iiitd_mentorship/app/data/repository/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'create.dart';

class MySchedulesScreen extends StatefulWidget {
  const MySchedulesScreen({super.key, required this.title});
  final String title;
  @override
  State<MySchedulesScreen> createState() => _MySchedulesScreenState();
}

class _MySchedulesScreenState extends State<MySchedulesScreen> {
  List<Meeting> meetings = <Meeting>[];

  @override
  void initState() {
    meetings = MeetingData.getDataSource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Month Agenda View')),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(meetings),
        monthViewSettings: const MonthViewSettings(showAgenda: true),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ScheduleMeetingScreen()));
          setState(() {
            meetings = MeetingData.getDataSource();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

