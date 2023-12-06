import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/meeting.dart';
import 'package:iiitd_mentorship/app/data/repository/meeting.dart';
import 'package:iiitd_mentorship/app/data/services/meeting.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'create.dart';
import 'meeting_details_page.dart';

class MySchedulesScreen extends StatefulWidget {
  const MySchedulesScreen({super.key, required this.title});
  final String title;

  @override
  State<MySchedulesScreen> createState() => _MySchedulesScreenState();
}

class _MySchedulesScreenState extends State<MySchedulesScreen> {
  DateTime _initialSelectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Month Agenda View')),
      body: StreamBuilder<List<Meeting>>(
        stream: MeetingService.getMeetingsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("No Meetings Found"));
          }
          return SfCalendar(
            view: CalendarView.month,
            dataSource: MeetingServiceRepository(snapshot.data!),
            initialSelectedDate: _initialSelectedDate,
            initialDisplayDate: _initialSelectedDate,
            monthViewSettings: const MonthViewSettings(showAgenda: true),
            onTap: (CalendarTapDetails details) {
              if (details.targetElement == CalendarElement.appointment ||
                  details.targetElement == CalendarElement.agenda) {
                Meeting meeting = details.appointments![0] as Meeting;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MeetingDetailsPage(meeting: meeting),
                  ),
                );
              }
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ScheduleMeetingScreen()));
          setState(() {
            // Update the calendar to reflect new meetings
            _initialSelectedDate = DateTime.now();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
