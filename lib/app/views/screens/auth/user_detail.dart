import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_button.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_dropdown.dart';

class UserDetailsScreen extends StatefulWidget {
  final String name;
  final String email;

  const UserDetailsScreen({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController yearOfJoiningController;
  late TextEditingController yearOfGraduationController;
  late TextEditingController collegeController;
  late TextEditingController companyController;
  String? selectedCourse;
  String? selectedBranch;

  // Define courses and branches
  final List<String> courses = [
    'B.Tech',
    'Dual Degree (MTech)',
    'MTech',
    'PhD'
  ];
  final Map<String, List<String>> branches = {
    'B.Tech': ['CSE', 'ECE', 'CSAM', 'CSD', 'CSS', 'CSB', 'CSAI', 'EVE'],
    'Dual Degree (MTech)': ['CSE', 'ECE', 'CSSS', 'CSD', 'CSB', 'CSAI', 'CSAM'],
    'MTech': ['CSE', 'ECE', 'CB'],
    'PhD': ['CB', 'CSE', 'ECE', 'HCD', 'Maths', 'SSH'],
  };

  @override
  void initState() {
    super.initState();
    yearOfJoiningController = TextEditingController();
    yearOfGraduationController = TextEditingController();
    collegeController = TextEditingController();
    companyController = TextEditingController();
  }

  @override
  void dispose() {
    yearOfJoiningController.dispose();
    yearOfGraduationController.dispose();
    collegeController.dispose();
    companyController.dispose();
    super.dispose();
  }

  bool isMentor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              CustomTextBox(
                controller: yearOfJoiningController,
                hintText: 'Year of Joining',
                validationMessage: 'Please enter the year of joining',
              ),
              SizedBox(height: 20),
              CustomTextBox(
                controller: yearOfGraduationController,
                hintText: 'Year of Graduation',
                validationMessage: 'Please enter the year of graduation',
              ),
              SizedBox(height: 20),
              CustomDropdown(
                labelText: 'Course',
                value: selectedCourse,
                items: courses.map((String course) {
                  return DropdownMenuItem(value: course, child: Text(course));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCourse = newValue;
                    selectedBranch = null; // Reset branch when course changes
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a course' : null,
              ),
              if (selectedCourse != null) SizedBox(height: 20),
              CustomDropdown(
                labelText: 'Branch',
                value: selectedBranch,
                items: (selectedCourse != null &&
                        branches.containsKey(selectedCourse))
                    ? branches[selectedCourse]!.map((String branch) {
                        return DropdownMenuItem(
                            value: branch, child: Text(branch));
                      }).toList()
                    : [], // Provide an empty list if selectedCourse is null or not in branches
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBranch = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a branch' : null,
              ),
              SizedBox(height: 20),
              SwitchListTile(
                title: const Text('Are you interested to become a mentor?'),
                value: isMentor,
                onChanged: (bool value) {
                  setState(() {
                    isMentor = value;
                  });
                },
              ),
              if (isMentor) ...[
                SizedBox(height: 20),
                CustomTextBox(
                  controller: collegeController,
                  hintText: 'College',
                  validationMessage: 'Please enter the college name',
                ),
                SizedBox(height: 20),
                CustomTextBox(
                  controller: companyController,
                  hintText: 'Company',
                  validationMessage: 'Please enter the company name',
                ),
              ],
              SizedBox(height: 20),
              CustomButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    // Fetch the current user
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      // Prepare the data to be stored
                      Map<String, dynamic> userData = {
                        'name': widget.name, // Passed from the previous screen
                        'email':
                            widget.email, // Passed from the previous screen
                        'yearOfJoining': yearOfJoiningController.text,
                        'yearOfGraduation': yearOfGraduationController.text,
                        'course': selectedCourse,
                        'branch': selectedBranch,
                        'isMentor': isMentor,
                        'adminApproval': false, // Default value
                      };

                      if (isMentor) {
                        userData['college'] = collegeController.text;
                        userData['company'] = companyController.text;
                      }

                      // Store in Firestore
                      try {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid) // Using Firebase Auth user ID
                            .set(userData);

                        // Handle successful submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Details submitted successfully!')),
                        );

                        // Optionally navigate to another screen or reset the form
                        // Navigator.pushReplacement(...);
                      } catch (e) {
                        // Display error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Failed to submit details: ${e.toString()}')),
                        );
                      }
                    } else {
                      // Handle user not logged in scenario
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'No authenticated user found. Please log in.')),
                      );
                    }
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
