import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  // ⚠️ Ajusta estas URLs a tu entorno
  final String identityUrl = 'http://192.168.22.104:5138'; // IdentityServer
  final String apiUrl = 'http://192.168.22.104:5206/api'; // api-utilitarios

  // Cliente que configuraste en IdentityServer (app-client)
  final String clientId = 'app-client';
  final String clientSecret = 'secret'; // SOLO para pruebas

  String? _accessToken;

  bool get isLoggedIn => _accessToken != null;

  Future<bool> login(String username, String password) async {
    final uri = Uri.parse('$identityUrl/Connect/token');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'password',
        'client_id': clientId,
        'client_secret': clientSecret,
        'username': username,
        'password': password,
        'scope': 'openid profile email roles',
      },
    );

    print('STATUS LOGIN: ${response.statusCode}');
    print('BODY LOGIN: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      _accessToken = data['access_token'] as String?;
      return _accessToken != null;
    }

    return false;
  }

  Future<Map<String, dynamic>?> getProfile() async {
    if (_accessToken == null) return null;

    final uri = Uri.parse('$apiUrl/profile');

    final response = await http.get(
      uri,
      headers: {'Authorization': 'Bearer $_accessToken'},
    );

    print('STATUS API: ${response.statusCode}');
    print('BODY API: ${response.body}');

    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }

    return null;
  }
}
