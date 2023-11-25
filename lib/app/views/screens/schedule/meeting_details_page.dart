import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/meeting.dart';
import 'package:iiitd_mentorship/app/data/services/meeting.dart';

class MeetingDetailsPage extends StatelessWidget {
  final Meeting meeting;

  const MeetingDetailsPage({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meeting Details'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              meetingDetailCard(context, Icons.title, 'Title', meeting.title),
              meetingDetailCard(context, Icons.description, 'Description',
                  meeting.description),
              meetingDetailCard(
                  context, Icons.email, 'Email IDs', meeting.emailIDs),
              meetingDetailCard(context, Icons.calendar_today, 'Start',
                  meeting.from.toString()),
              meetingDetailCard(
                  context, Icons.calendar_today, 'End', meeting.to.toString()),
              const SizedBox(height: 20),
              cancelMeetingButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget meetingDetailCard(
      BuildContext context, icon, String label, String content) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(label),
        subtitle: Text(content),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget cancelMeetingButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _cancelMeeting(context),
      icon: const Icon(Icons.cancel, color: Colors.white),
      label:
          const Text('Cancel Meeting', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(fontSize: 16),
      ),
    );
  }

  void _cancelMeeting(BuildContext context) {
    // Implementation of the cancel meeting functionality
    MeetingService.deleteMeeting(meeting.eventId).then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    });
  }
}
