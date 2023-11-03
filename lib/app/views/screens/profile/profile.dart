import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditingName = false;
  bool _isEditingEmail = false;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>(); // Add a key for the form

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: "Antonio Pedro");
    _emailController = TextEditingController(text: "tonio.pedro99@gmail.com");
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _toggleEditingName() {
    setState(() {
      _isEditingName = !_isEditingName;
    });
  }

  void _toggleEditingEmail() {
    setState(() {
      _isEditingEmail = !_isEditingEmail;
    });
  }

  void _updateProfile() {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar and update the profile
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile Updated')),
      );
      setState(() {
        _isEditingName = false;
        _isEditingEmail = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          if (_isEditingName || _isEditingEmail)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: _updateProfile,
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Set the form key
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 70, // Increased radius for a larger profile picture
                    backgroundImage: AssetImage('assets/profile_image.png'),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors
                          .white, // A white background to ensure visibility
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        // Placeholder for functionality to change profile picture
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32), // Increased padding
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  suffixIcon: _isEditingName
                      ? null
                      : IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: _toggleEditingName,
                        ),
                ),
                readOnly: !_isEditingName,
                style: TextStyle(fontSize: 20), // Increased font size
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Name cannot be empty';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24), // Increased padding
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  suffixIcon: _isEditingEmail
                      ? null
                      : IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: _toggleEditingEmail,
                        ),
                ),
                readOnly: !_isEditingEmail,
                style: TextStyle(fontSize: 20), // Increased font size
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email cannot be empty';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
