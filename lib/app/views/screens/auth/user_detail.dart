import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iiitd_mentorship/app/data/model/user.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_button.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_dropdown.dart';

class UserDetailsScreen extends StatefulWidget {
  final String? name;
  final String? email;

  const UserDetailsScreen({
    super.key,
    this.name,
    this.email,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
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

  final List<String> topics = [];
  final List<String> selectedTopics = [];

  @override
  void initState() {
    super.initState();
    yearOfJoiningController = TextEditingController();
    yearOfGraduationController = TextEditingController();
    collegeController = TextEditingController();
    companyController = TextEditingController();
    loadTopics();
  }

  loadTopics() async {
    final dbTopicsCollection =
        await FirebaseFirestore.instance.collection('topics').get();

    dbTopicsCollection.docs.forEach((element) {
      topics.add(element.data()['name']);
    });
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

  Future<void> completeUserDetails(DBUser user) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .set(user.toJson());
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextBox(
                controller: yearOfGraduationController,
                hintText: 'Year of Graduation',
                validationMessage: 'Please enter the year of graduation',
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              if (selectedCourse != null) const SizedBox(height: 20),
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
              const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                CustomTextBox(
                  controller: collegeController,
                  hintText: 'College',
                  validationMessage: 'Please enter the college name',
                ),
                const SizedBox(height: 20),
                CustomTextBox(
                  controller: companyController,
                  hintText: 'Company',
                  validationMessage: 'Please enter the company name',
                ),
                // list of topics of interests in selectable chips

                const SizedBox(height: 20),
                const Text("Select your topics of interest"),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8.0,
                  children: topics.map((topic) {
                    bool isSelected = selectedTopics.contains(topic);
                    return FilterChip(
                      label: Text(topic),
                      selected: isSelected,
                      showCheckmark: true,
                      onSelected: (bool value) {
                        setState(() {
                          selectedTopics.add(topic);
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 20),
              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    DBUser userMentor = DBUser(
                        uid: user!.uid,
                        name: widget.name,
                        email: widget.email,
                        yearOfGraduation: yearOfGraduationController.text,
                        yearOfJoining: yearOfJoiningController.text,
                        course: selectedCourse,
                        branch: selectedBranch,
                        isMentor: isMentor,
                        college: collegeController.text,
                        company: companyController.text,
                        topics: selectedTopics,
                        adminApproval: false,
                        isProfileComplete: true);

                    DBUser userStudent = DBUser(
                        uid: user.uid,
                        name: widget.name,
                        email: widget.email,
                        yearOfGraduation: yearOfGraduationController.text,
                        yearOfJoining: yearOfJoiningController.text,
                        course: selectedCourse,
                        branch: selectedBranch,
                        isMentor: isMentor,
                        topics: [],
                        adminApproval: true,
                        isProfileComplete: true);

                    if (isMentor) {
                      completeUserDetails(userMentor).then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/driver', (route) => false);
                      });
                    } else {
                      completeUserDetails(userStudent).then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/driver', (route) => false);
                      });
                    }
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
