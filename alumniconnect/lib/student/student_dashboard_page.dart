import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StudentDashboardPage extends StatefulWidget {
  final Map<String, dynamic> studentData;

  const StudentDashboardPage({Key? key, required this.studentData})
      : super(key: key);

  @override
  State<StudentDashboardPage> createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
        actions: [
          IconButton(
            icon: Icon(MdiIcons.accountCircle),
            onPressed: () => Navigator.pushNamed(context, '/student_profile',
                arguments: widget.studentData),
            tooltip: 'Student Profile',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Icon(MdiIcons.account,
                        size: 40, color: Colors.blueAccent),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.studentData['name'] ?? 'N/A',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.studentData['konguEmail'] ?? 'N/A',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(MdiIcons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                // Already on home page
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.forum),
              title: Text('Discussion Forum'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/discussion_forum',
                    arguments: widget.studentData);
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.accountGroup),
              title: Text('Connect'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/connect',
                    arguments: widget.studentData);
              },
            ),
            ListTile(
              leading: Icon(MdiIcons.dotsHorizontal),
              title: Text('Others'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/others',
                    arguments: widget.studentData);
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(MdiIcons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey.shade200,
                            child: Icon(MdiIcons.account,
                                size: 40, color: Colors.blueAccent),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.studentData['name'] ?? 'N/A',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  widget.studentData['rollNo'] ?? 'N/A',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Colors.grey.shade700,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Academic Information',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(MdiIcons.school),
                        title: Text('Department'),
                        subtitle:
                            Text(widget.studentData['department'] ?? 'N/A'),
                      ),
                      ListTile(
                        leading: Icon(MdiIcons.calendar),
                        title: Text('Academic Period'),
                        subtitle: Text(
                            '${widget.studentData['joiningYear'] ?? 'N/A'} - ${widget.studentData['passingYear'] ?? 'N/A'}'),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Contact Information',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(MdiIcons.email),
                        title: Text('Academic Email'),
                        subtitle:
                            Text(widget.studentData['konguEmail'] ?? 'N/A'),
                      ),
                      ListTile(
                        leading: Icon(MdiIcons.email),
                        title: Text('Personal Email'),
                        subtitle:
                            Text(widget.studentData['personalEmail'] ?? 'N/A'),
                      ),
                      ListTile(
                        leading: Icon(MdiIcons.phone),
                        title: Text('Phone'),
                        subtitle: Text(widget.studentData['phone'] ?? 'N/A'),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Social Media',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(MdiIcons.linkedin, color: Colors.blue),
                        title: Text('LinkedIn'),
                        subtitle: Text(
                            widget.studentData['linkedin'] ?? 'Not provided'),
                        onTap: () {
                          // Open LinkedIn profile if provided
                        },
                      ),
                      ListTile(
                        leading: Icon(MdiIcons.instagram, color: Colors.pink),
                        title: Text('Instagram'),
                        subtitle: Text(
                            widget.studentData['instagram'] ?? 'Not provided'),
                        onTap: () {
                          // Open Instagram profile if provided
                        },
                      ),
                      ListTile(
                        leading: Icon(MdiIcons.github, color: Colors.black),
                        title: Text('GitHub'),
                        subtitle: Text(
                            widget.studentData['github'] ?? 'Not provided'),
                        onTap: () {
                          // Open GitHub profile if provided
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Handle navigation based on selected index
          switch (index) {
            case 0: // Home - already on dashboard
              break;
            case 1: // Discussion Forum
              Navigator.pushNamed(context, '/discussion_forum',
                  arguments: widget.studentData);
              break;
            case 2: // Connect
              Navigator.pushNamed(context, '/connect',
                  arguments: widget.studentData);
              break;
            case 3: // More
              Navigator.pushNamed(context, '/others',
                  arguments: widget.studentData);
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.forum),
            label: 'Discuss',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.accountGroup),
            label: 'Connect',
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.dotsHorizontal),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
