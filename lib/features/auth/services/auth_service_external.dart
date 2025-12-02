import 'package:flutter_appauth/flutter_appauth.dart';

class AuthServiceExternal {
  final FlutterAppAuth _appAuth = const FlutterAppAuth();

  // 👇 Ajusta estas URLs / IDs a tu entorno
  final String issuer = 'http://192.168.22.104:5138'; //Identity
  final String clientId = 'app-client'; // el client de Code+PKCE que creaste
  final String redirectUrl = 'com.example.appSecurity://oauthredirect';
  final String postLogoutRedirectUrl =
      'com.example.appSecurity://signout-callback';

  // La URL base de tu API de datos
  final String apiBaseUrl =
      'http://192.168.22.104:5206/api'; // ej: https://192.168.22.104:5001

  // Scopes que debe pedir el cliente Flutter
  final List<String> scopes = const [
    'openid',
    'profile',
    'email',
    'roles',
    'api-datos',
  ];

  String? _accessToken;
  String? _idToken;

  bool get isLoggedIn => _accessToken != null;

  /// Login interactivo (muestra la pantalla de IdentityServer: local + Google)
  Future<bool> loginWithGoogle() async {
    try {
      // Esto hace: /connect/authorize + /connect/token (Authorization Code + PKCE)
      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientId,
          redirectUrl,
          issuer: issuer,
          scopes: scopes,
          // opcional:
          // promptValues: ['login'], // para forzar login cada vez
        ),
      );

      if (result == null) {
        print('Login cancelado o sin respuesta.');
        return false;
      }

      _accessToken = result.accessToken;
      _idToken = result.idToken;

      print('ACCESS TOKEN: ${_accessToken?.substring(0, 30)}...');
      print('ID TOKEN: ${_idToken?.substring(0, 30)}...');

      return _accessToken != null;
    } catch (e) {
      print('Error en login con flutter_appauth: $e');
      return false;
    }
  }

  void logout() {
    _accessToken = null;
    _idToken = null;
  }
}
