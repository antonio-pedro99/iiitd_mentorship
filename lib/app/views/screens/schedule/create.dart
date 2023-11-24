import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/data/model/meeting.dart';
import 'package:iiitd_mentorship/app/data/repository/meeting.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_button.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';

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
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 15, // Set the font size
            color: Colors.black, // Set the color
          ),
          child: ListView(
            children: [
              const Text('Meeting Title'),
              const SizedBox(height: 10),
              CustomTextBox(
                controller: _titleController,
                validationMessage: 'Please enter meeting title',
                hintText: 'Meeting Title',
              ),
              const SizedBox(height: 16),
              const Text('Meeting Description'),
              const SizedBox(height: 10),
              CustomTextBox(
                controller: _descriptionController,
                validationMessage: 'Please enter meeting description',
                hintText: 'Meeting Description',
              ),
              const SizedBox(height: 16),
              const Text('Email IDs'),
              const SizedBox(height: 10),
              CustomTextBox(
                controller: _emailController,
                //keyboardType: TextInputType.emailAddress,
                validationMessage: 'Please enter email IDs',
                hintText: 'e.g. mentor@example.com, mentee@example.com',
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
              CustomButton(
                rounded: true,
                onPressed: _scheduleMeeting,
                child: const Text('Schedule Meeting'),
              ),
            ],
          ),
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

  _scheduleMeeting() async {
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      DateTime startDateTime = DateTime(_selectedDate.year, _selectedDate.month,
          _selectedDate.day, _startTime.hour, _startTime.minute);

      DateTime endDateTime = DateTime(_selectedDate.year, _selectedDate.month,
          _selectedDate.day, _endTime.hour, _endTime.minute);

      String currentUserID = FirebaseAuth.instance.currentUser?.uid ?? '';

      Meeting newMeeting = Meeting(
        _titleController.text, // Event Name
        _titleController.text, // Title
        _descriptionController.text, // Description
        _emailController.text, // Email IDs
        startDateTime, // Start Time
        endDateTime, // End Time
        Theme.of(context).primaryColor, // Background Color
        false, // isAllDay
        currentUserID, // User ID
      );

      await MeetingData.addMeeting(newMeeting);

      Navigator.pop(context);
    } else {
      // Show an error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
    }
  }
}
