import 'dart:convert';
import "package:http/http.dart" as http;

import '../auth/dto/auth_response.dart';
import '../config/constants.dart';

class UserApi {
  static final UserApi _instance = UserApi._internal();

  factory UserApi() {
    return _instance;
  }

  UserApi._internal();


  Future<AuthResponse?> sendAuthCodeToServer(String authCode) async {
    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/api/v1/auth/code/google?code=$authCode'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(utf8.decode(response.bodyBytes));
        final authData = responseData['data'];

        final authResponse = AuthResponse.fromJson(authData);
        return authResponse;
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
