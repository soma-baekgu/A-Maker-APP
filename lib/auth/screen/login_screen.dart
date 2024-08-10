import 'package:a_maker_app/config/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../api/user_api.dart';
import '../../main/screen/main_screen.dart';
import '../provider/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserApi _userApi = UserApi();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: GOOGLE_CLIENT_ID,
    scopes: ['email', 'profile', 'openid'],
  );

  Future<void> _handleSignIn() async {
    try {
      print("hi");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      print(googleUser);
      final String? authCode = googleUser?.serverAuthCode;
      if (authCode != null) {
        final authResponse = await _userApi.sendAuthCodeToServer(authCode);
        if (authResponse != null) {
          Provider.of<AuthProvider>(context, listen: false)
              .setToken(authResponse.token);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        }
      }
    } catch (error) {
      print('Sign in failed: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF90D49E),
      body: SafeArea(
        child: Stack(
          children: [
            const Center(
              child: Text(
                'A - MAKER',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ElevatedButton.icon(
                  onPressed: _handleSignIn,
                  icon: Image.asset(
                    'assets/google_logo.png',
                    height: 24,
                    width: 24,
                  ),
                  label: const Text('Google 로그인'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    // 텍스트 색상을 검은색으로 설정
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
