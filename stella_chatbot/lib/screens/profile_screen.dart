// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:stella_chatbot/models/user.dart';
import 'package:stella_chatbot/services/database_service.dart';
import 'package:stella_chatbot/widgets/custom_text_field.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  ProfileScreen({required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _childrenController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name;
    _ageController.text = widget.user.age.toString();
    _childrenController.text = widget.user.children.join(', ');
  }

  void _updateProfile() async {
    final updatedUser = User(
      id: widget.user.id,
      name: _nameController.text,
      age: int.tryParse(_ageController.text) ?? 0,
      children: _childrenController.text.split(',').map((e) => e.trim()).toList(),
    );

    await _databaseService.updateUser(updatedUser);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
        backgroundColor: Colors.purple[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple[100]!, Colors.purple[300]!],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Edit Your Profile',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Name',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: _ageController,
                    hintText: 'Age',
                    icon: Icons.cake,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    controller: _childrenController,
                    hintText: 'Children (comma-separated)',
                    icon: Icons.child_care,
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: _updateProfile,
                      child: Text('Update Profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple[700], // Changed from primary to backgroundColor
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}