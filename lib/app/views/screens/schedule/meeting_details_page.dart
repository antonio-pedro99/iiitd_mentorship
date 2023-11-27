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
        body: FutureBuilder<String>(
            future: MeetingService.getUserName(meeting.userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data == 'Unknown User') {
                return Center(child: Text('No Creator Information Available'));
              }
              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _creatorNameCard(context, snapshot.data!),
              meetingDetailCard(context, Icons.title, 'Title', meeting.title),
              meetingDetailCard(context, Icons.description, 'Description',
                  meeting.description),
              meetingDetailCard(
                  context, Icons.email, 'Invitees', meeting.emailIDs),
              meetingDetailCard(context, Icons.calendar_today, 'Start',
                  meeting.from.toString()),
              meetingDetailCard(
                  context, Icons.calendar_today, 'End', meeting.to.toString()),
              const SizedBox(height: 20),
              cancelMeetingButton(context),
            ],
          ),
        ),
      );
    }
      ),
    );
  }

  Widget _creatorNameCard(BuildContext context, String creatorName) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'Meeting created by: $creatorName',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
        ),
        SizedBox(height: 20), // Adjust the height as needed
      ],
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 26, vertical: 4),
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
