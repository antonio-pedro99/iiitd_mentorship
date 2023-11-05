import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/views/screens/schedule/schedule.dart';

class ScheduleMeetingScreen extends StatefulWidget {
  const ScheduleMeetingScreen({super.key});

  @override
  _ScheduleMeetingScreenState createState() => _ScheduleMeetingScreenState();
}

class _ScheduleMeetingScreenState extends State<ScheduleMeetingScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schedule Meeting')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Meeting Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Meeting Description'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email IDs',
                hintText: 'e.g. mentor@example.com, mentee@example.com',
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              title: Text('Date'),
              subtitle: Text(_selectedDate == null
                  ? 'Select Date'
                  : _selectedDate.toLocal().toString().split(' ')[0]),
              trailing: Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            ListTile(
              title: Text('Start Time'),
              subtitle: Text(_startTime == null
                  ? 'Select Start Time'
                  : _startTime.format(context)),
              trailing: Icon(Icons.access_time),
              onTap: _pickStartTime,
            ),
            ListTile(
              title: Text('End Time'),
              subtitle: Text(_endTime == null
                  ? 'Select End Time'
                  : _endTime.format(context)),
              trailing: Icon(Icons.access_time),
              onTap: _pickEndTime,
            ),
            ElevatedButton(
              onPressed: _scheduleMeeting,
              child: Text('Schedule Meeting'),
            ),
          ],
        ),
      ),
    );
  }

  _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  _pickStartTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _startTime) {
      setState(() {
        _startTime = pickedTime;
      });
    }
  }

  _pickEndTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _endTime) {
      setState(() {
        _endTime = pickedTime;
      });
    }
  }

  _scheduleMeeting() {
    // Store the meeting data in a static list for simplicity
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _selectedDate != null &&
        _startTime != null &&
        _endTime != null) {
      MeetingData.addMeeting(
        Meeting(
          _titleController.text,
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day,
              _startTime.hour, _startTime.minute),
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day,
              _endTime.hour, _endTime.minute),
          Colors.blue,
          false,
        ),
      );
      Navigator.pop(context);
    }
  }
}

// Static class to store the meetings
class MeetingData {
  static List<Meeting> meetings = [];

  static addMeeting(Meeting meeting) {
    meetings.add(meeting);
  }
}
