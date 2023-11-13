import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/meeting.dart';
import 'package:iiitd_mentorship/app/data/repository/meeting.dart';

class ScheduleMeetingScreen extends StatefulWidget {
  const ScheduleMeetingScreen({super.key});

  @override
  State<ScheduleMeetingScreen> createState() => _ScheduleMeetingScreenState();
}

class _ScheduleMeetingScreenState extends State<ScheduleMeetingScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule Meeting')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Meeting Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Meeting Description'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email IDs',
                hintText: 'e.g. mentor@example.com, mentee@example.com',
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Date'),
              subtitle: Text(_selectedDate == null
                  ? 'Select Date'
                  : _selectedDate.toLocal().toString().split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: _pickDate,
            ),
            ListTile(
              title: const Text('Start Time'),
              subtitle: Text(_startTime == null
                  ? 'Select Start Time'
                  : _startTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: _pickStartTime,
            ),
            ListTile(
              title: const Text('End Time'),
              subtitle: Text(_endTime == null
                  ? 'Select End Time'
                  : _endTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: _pickEndTime,
            ),
            ElevatedButton(
              onPressed: _scheduleMeeting,
              child: const Text('Schedule Meeting'),
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
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
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
        _descriptionController.text.isNotEmpty) {
      MeetingData.addMeeting(
        Meeting(
          _titleController.text,
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day,
              _startTime.hour, _startTime.minute),
          DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day,
              _endTime.hour, _endTime.minute),
          Theme.of(context).primaryColor,
          false,
        ),
      );
      Navigator.pop(context);
    }
  }
}