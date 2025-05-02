import 'package:flutter/material.dart';
import 'package:alumniconnect/login/login_page.dart';
import 'package:alumniconnect/admin/admin_portal.dart';
import 'package:alumniconnect/student/student_dashboard_page.dart';
import 'package:alumniconnect/student/student_profile_page.dart';
import 'package:alumniconnect/alumni/alumni_signup_page.dart';
import 'package:alumniconnect/alumni/alumni_dashboard_page.dart';
import 'package:alumniconnect/alumni/alumni_profile_page.dart';
// Add imports for new pages
import 'package:alumniconnect/student/discussion_forum_page.dart';
import 'package:alumniconnect/student/connect_page.dart';
import 'package:alumniconnect/student/others_page.dart';

void main() {
  runApp(AlumniConnectApp());
}

class AlumniConnectApp extends StatelessWidget {
  const AlumniConnectApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlumniConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // Remove the fontFamily specification to use system font until we fix the font issue
        // fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(color: Colors.blueAccent),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cardTheme: CardTheme(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/admin_portal': (context) => AdminPortalPage(),
        '/student_dashboard': (context) {
          // Add null safety check for route arguments
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Map<String, dynamic>) {
            return StudentDashboardPage(studentData: args);
          } else {
            // Return a default or error page if no valid arguments
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: No student data provided'),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/'),
                      child: Text('Back to Login'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        '/student_profile': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Map<String, dynamic>) {
            return StudentProfilePage(studentData: args);
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: No student data provided'),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Back'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        '/alumni_signup': (context) => AlumniSignupPage(),
        '/alumni_dashboard': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Map<String, dynamic>) {
            return AlumniDashboardPage(alumniData: args);
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: No alumni data provided'),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/'),
                      child: Text('Back to Login'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        '/alumni_profile': (context) {
          final args = ModalRoute.of(context)?.settings.arguments;
          if (args is Map<String, dynamic>) {
            return AlumniProfilePage(alumniData: args);
          } else {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: No alumni data provided'),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Back'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        // Add null safety for the new routes
        '/discussion_forum': (context) => DiscussionForumPage(
            studentData: ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>?),
        '/connect': (context) => ConnectPage(
            studentData: ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>?),
        '/others': (context) => OthersPage(
            studentData: ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>?),
      },
    );
  }
}
