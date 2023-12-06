import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiitd_mentorship/app/bloc/auth/auth_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _branchController;
  late TextEditingController _courseController;
  late TextEditingController _yearOfGraduationController;
  late TextEditingController _collegeController;
  late TextEditingController _companyController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _roleController;

  bool _isEditingCollege = false;
  bool _isEditingCompany = false;
  final _formKey = GlobalKey<FormState>();
  XFile? _profileImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _branchController = TextEditingController();
    _courseController = TextEditingController();
    _yearOfGraduationController = TextEditingController();
    _collegeController = TextEditingController();
    _companyController = TextEditingController();
    _roleController = TextEditingController();

    fetchUserProfile();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggleEditingCollege() {
    setState(() {
      _isEditingCollege = !_isEditingCollege;
    });
  }

  void _toggleEditingCompany() {
    setState(() {
      _isEditingCompany = !_isEditingCompany;
    });
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      // Show a loading Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Updating Profile...')),
      );

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'college': _collegeController.text,
            'company': _companyController.text,
            // Update other fields as necessary
          });

          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile Updated Successfully')),
          );
        } catch (e) {
          print('Error updating user data: $e');
          // Show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating profile')),
          );
        }
      }

      setState(() {
        _isEditingCollege = false;
        _isEditingCompany = false;
      });
    }
  }

  Future<void> fetchUserProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userProfile = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (userProfile.exists) {
          Map<String, dynamic> userData =
              userProfile.data() as Map<String, dynamic>;

          _nameController.text = userData['name'] ?? '';
          _emailController.text = userData['email'] ?? '';
          _collegeController.text = userData['college'] ?? 'Not available';
          _companyController.text = userData['company'] ?? 'Not available';
          _branchController.text = userData['branch'] ?? 'Not available';
          _courseController.text = userData['course'] ?? 'Not available';
          _yearOfGraduationController.text =
              userData['yearOfGraduation'] ?? 'Not available';

          // Set the profile image URL if available
          if (userData.containsKey('photoUrl') &&
              userData['photoUrl'] != null &&
              userData['photoUrl'].toString().isNotEmpty) {
            setState(() {
              _profileImage = XFile(userData['photoUrl']);
            });
          }

          bool isMentor = userData['isMentor'] ?? false;

          setState(() {
            _roleController.text = isMentor ? 'Mentor' : 'Mentee';
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
      }
    }
  }

  Future<void> _uploadProfileImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && _profileImage != null) {
      try {
        String fileName = Path.basename(_profileImage!.path);
        firebase_storage.Reference firebaseStorageRef = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('profile_images/${user.uid}/$fileName');

        firebase_storage.UploadTask uploadTask =
            firebaseStorageRef.putFile(File(_profileImage!.path));
        await uploadTask;

        // Once the image is uploaded, get the download URL
        String downloadURL = await firebaseStorageRef.getDownloadURL();

        // Update the Firestore user document with the new image URL
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'photoUrl': downloadURL,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile picture updated successfully')),
        );
      } catch (e) {
        print('Error uploading image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile picture')),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = pickedFile;
        });

        // After setting the profile image, upload it
        await _uploadProfileImage();
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          if (_isEditingCollege || _isEditingCompany)
            IconButton(
              icon: Icon(Icons.save), // Changed to save icon
              onPressed: _updateProfile,
            ),
          IconButton(
              onPressed: () =>
                  BlocProvider.of<AuthBloc>(context).add(AuthLogout()),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/onboarding', (Route<dynamic> route) => false);
          }
        }, builder: (context, state) {
          Widget widget;

          if (state is AuthLoading) {
            widget = const Center(
              child: Column(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  Text('Signing out...'),
                ],
              ),
            );
          } else if (state is Authenticated || state is AuthInitial) {
            widget = Form(
              key: _formKey,
              child: ListView(
                // Used ListView for scrollable content
                children: [
                  Stack(
                    clipBehavior: Clip
                        .none, // Allow overflowing of children outside the stack
                    alignment: Alignment
                        .center, // Align children to the center of the stack
                    children: [
                      CircleAvatar(
                        radius: 60, // Radius of the profile picture
                        backgroundImage: _profileImage != null
                            ? (_profileImage!.path
                                    .startsWith('http') // Check if it's a URL
                                ? NetworkImage(_profileImage!.path)
                                    as ImageProvider<Object>
                                : FileImage(File(_profileImage!.path))
                                    as ImageProvider<Object>)
                            : AssetImage('assets/profile_image.png')
                                as ImageProvider<
                                    Object>, // Default profile image
                      ),
                      Positioned(
                        right:
                            45, // Position the edit icon to the right of the CircleAvatar
                        bottom: 30,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255,
                                255), // White background for visibility
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.edit,
                                color: Theme.of(context).primaryColor),
                            onPressed: _pickImage, // Image picking function
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person), // Added icon
                      filled: true, // Filled text box
                      fillColor: Colors.grey[200], // Fill color
                      // suffixIcon: _isEditingName
                      //     ? null
                      //     : IconButton(
                      //         icon: Icon(Icons.edit),
                      //         onPressed: _toggleEditingName,
                      //       ),
                    ),
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                    // validator: (value) {
                    //   if (value == null || value.trim().isEmpty) {
                    //     return 'Name cannot be empty';
                    //   }
                    //   return null;
                    // },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email), // Added icon
                      filled: true, // Filled text box
                      fillColor: Colors.grey[200], // Fill color
                    ),
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: _roleController,
                    decoration: InputDecoration(
                      labelText: 'Role',
                      prefixIcon: Icon(Icons.badge), // Added icon
                      filled: true, // Filled text box
                      fillColor: Colors.grey[200], // Fill color
                    ),
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _courseController,
                    decoration: InputDecoration(
                      labelText: 'Course',
                      prefixIcon: Icon(Icons.school), // Added icon
                      filled: true, // Filled text box
                      fillColor: Colors.grey[200], // Fill color
                    ),
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _branchController,
                    decoration: InputDecoration(
                      labelText: 'Branch',
                      prefixIcon: Icon(Icons.domain_add), // Added icon
                      filled: true, // Filled text box
                      fillColor: Colors.grey[200], // Fill color
                    ),
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _yearOfGraduationController,
                    decoration: InputDecoration(
                      labelText: 'Year of Graduation',
                      prefixIcon: Icon(Icons.event), // Added icon
                      filled: true, // Filled text box
                      fillColor: Colors.grey[200], // Fill color
                    ),
                    readOnly: true,
                    style: TextStyle(fontSize: 16),
                  ),
                  if (_roleController.text != 'Mentee') ...[
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _collegeController,
                      decoration: InputDecoration(
                        labelText: 'College',
                        prefixIcon: Icon(Icons.history_edu), // Added icon
                        filled: true, // Filled text box
                        fillColor: Colors.grey[200], // Fill color
                        suffixIcon: _isEditingCollege
                            ? null
                            : IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: _toggleEditingCollege,
                              ),
                      ),
                      readOnly: false,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _companyController,
                      decoration: InputDecoration(
                        labelText: 'Company',
                        prefixIcon: Icon(Icons.business_center), // Added icon
                        filled: true, // Filled text box
                        fillColor: Colors.grey[200], // Fill color
                        suffixIcon: _isEditingCollege
                            ? null
                            : IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: _toggleEditingCompany,
                              ),
                      ),
                      readOnly: false,
                      style: TextStyle(fontSize: 16),
                    ),
                  ]
                ],
              ),
            );
          } else {
            widget = const Center(
              child: Text('Error fetching user data'),
            );
          }

          return widget;
        }),
      ),
    );
  }
}
