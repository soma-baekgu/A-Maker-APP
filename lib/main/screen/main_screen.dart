import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/provider/auth_provider.dart';
import '../../auth/screen/login_screen.dart';
import '../../home_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final token = Provider.of<AuthProvider>(context).token;

    if (token != null) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }
}
