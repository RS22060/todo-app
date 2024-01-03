import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/login_screen.dart';
import 'screens/todo_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationScreen(),
    );
  }
}

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool _isLoggedIn = false; // Replace with your authentication logic

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isUserLoggedIn = prefs.getBool("isLoggedIn");

    setState(() {
      _isLoggedIn = isUserLoggedIn ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? TodoListScreen() : LoginScreen();
  }
}

