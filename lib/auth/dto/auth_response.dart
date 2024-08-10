class AuthResponse {
  final String token;
  final String name;
  final String email;
  final String picture;

  AuthResponse({
    required this.token,
    required this.name,
    required this.email,
    required this.picture,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'],
      name: json['name'],
      email: json['email'],
      picture: json['picture'],
    );
  }
}