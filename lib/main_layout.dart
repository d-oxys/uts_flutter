// lib/main_layout.dart

import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'login_model.dart';
import 'profile_page.dart';
import 'permission_page.dart'; // Import PermissionPage

class MainLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final LoginModel loginModel;

  MainLayout({
    required this.title,
    required this.body,
    required this.loginModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.teal,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              color: Colors.teal,
              height: 80,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.teal),
              title: Text('Home'),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              onTap: () => _navigateWithSplash(context, '/home'),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.teal),
              title: Text('Profile'),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              onTap: () =>
                  _navigateWithSplash(context, '/profile', isProfile: true),
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.teal),
              title: Text('Permission'), // Change Settings to Permission
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              onTap: () => _navigateWithSplash(
                  context, '/permission'), // Navigate to PermissionPage
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.teal),
              title: Text('Logout'),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
              onTap: () => _navigateWithSplash(context, '/login'),
            ),
          ],
        ),
      ),
      body: body,
    );
  }

  // Fungsi untuk navigasi dengan splash screen dan mengirimkan employeeId
  void _navigateWithSplash(BuildContext context, String routeName,
      {bool isProfile = false}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SplashScreen(
          loginModel: loginModel,
          nextRoute: routeName,
        ),
      ),
    );

    if (isProfile) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProfilePage(
              employeeId: loginModel.user?['nip'] ?? 0,
              loginModel: loginModel,
            ),
          ),
        );
      });
    } else {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacementNamed(routeName);
      });
    }
  }
}
