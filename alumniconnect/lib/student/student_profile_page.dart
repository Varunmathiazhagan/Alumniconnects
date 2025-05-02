import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:http/http.dart' as http;

class StudentProfilePage extends StatefulWidget {
  final Map<String, dynamic> studentData;

  const StudentProfilePage({Key? key, required this.studentData})
      : super(key: key);

  @override
  _StudentProfilePageState createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _linkedinController;
  late TextEditingController _instagramController;
  late TextEditingController _githubController;
  late TextEditingController _phoneController;
  late TextEditingController _personalEmailController;
  late TextEditingController _departmentController;
  late TextEditingController _joiningYearController;
  late TextEditingController _passingYearController;

  @override
  void initState() {
    super.initState();
    _linkedinController =
        TextEditingController(text: widget.studentData['linkedin'] ?? '');
    _instagramController =
        TextEditingController(text: widget.studentData['instagram'] ?? '');
    _githubController =
        TextEditingController(text: widget.studentData['github'] ?? '');
    _phoneController =
        TextEditingController(text: widget.studentData['phone'] ?? '');
    _personalEmailController =
        TextEditingController(text: widget.studentData['personalEmail'] ?? '');
    _departmentController =
        TextEditingController(text: widget.studentData['department'] ?? '');
    _joiningYearController =
        TextEditingController(text: widget.studentData['joiningYear'] ?? '');
    _passingYearController =
        TextEditingController(text: widget.studentData['passingYear'] ?? '');
  }

  @override
  void dispose() {
    _linkedinController.dispose();
    _instagramController.dispose();
    _githubController.dispose();
    _phoneController.dispose();
    _personalEmailController.dispose();
    _departmentController.dispose();
    _joiningYearController.dispose();
    _passingYearController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse('http://localhost:3000/api/student/update'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'username': widget.studentData['username'],
            'linkedin': _linkedinController.text,
            'instagram': _instagramController.text,
            'github': _githubController.text,
            'phone': _phoneController.text,
            'personalEmail': _personalEmailController.text,
            'department': _departmentController.text,
            'joiningYear': _joiningYearController.text,
            'passingYear': _passingYearController.text,
          }),
        );

        // Handle response
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully')),
          );

          // Update the data in the parent and return
          final updatedData = Map<String, dynamic>.from(widget.studentData);
          updatedData['linkedin'] = _linkedinController.text;
          updatedData['instagram'] = _instagramController.text;
          updatedData['github'] = _githubController.text;
          updatedData['phone'] = _phoneController.text;
          updatedData['personalEmail'] = _personalEmailController.text;
          updatedData['department'] = _departmentController.text;
          updatedData['joiningYear'] = _joiningYearController.text;
          updatedData['passingYear'] = _passingYearController.text;

          Navigator.pop(context, updatedData);
        } else {
          final data = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Error: ${data['message'] ?? "Update failed"}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(MdiIcons.account,
                              size: 50, color: Colors.blueAccent),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.studentData['name'] ?? 'N/A',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          widget.studentData['rollNo'] ?? 'N/A',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text('Academic Information',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _departmentController,
                    decoration: InputDecoration(
                      labelText: 'Department',
                      prefixIcon: Icon(MdiIcons.school),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value!.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _joiningYearController,
                          decoration: InputDecoration(
                            labelText: 'Joining Year',
                            prefixIcon: Icon(MdiIcons.calendar),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Required' : null,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _passingYearController,
                          decoration: InputDecoration(
                            labelText: 'Passing Year',
                            prefixIcon: Icon(MdiIcons.calendarCheck),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Required' : null,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text('Contact Information',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _personalEmailController,
                    decoration: InputDecoration(
                      labelText: 'Personal Email',
                      prefixIcon: Icon(MdiIcons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isNotEmpty && !value.contains('@')
                            ? 'Invalid email'
                            : null,
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      prefixIcon: Icon(MdiIcons.phone),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text('Social Media Profiles',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  TextFormField(
                    controller: _linkedinController,
                    decoration: InputDecoration(
                      labelText: 'LinkedIn Profile',
                      prefixIcon: Icon(MdiIcons.linkedin),
                      border: OutlineInputBorder(),
                      hintText: 'linkedin.com/in/yourprofile',
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _instagramController,
                    decoration: InputDecoration(
                      labelText: 'Instagram Handle',
                      prefixIcon: Icon(MdiIcons.instagram),
                      border: OutlineInputBorder(),
                      hintText: '@yourusername',
                    ),
                  ),
                  SizedBox(height: 12),
                  TextFormField(
                    controller: _githubController,
                    decoration: InputDecoration(
                      labelText: 'GitHub Username',
                      prefixIcon: Icon(MdiIcons.github),
                      border: OutlineInputBorder(),
                      hintText: 'github.com/yourusername',
                    ),
                  ),
                  SizedBox(height: 24),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _updateProfile,
                      icon: Icon(MdiIcons.contentSave),
                      label: Text('Save Profile'),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 12),
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
