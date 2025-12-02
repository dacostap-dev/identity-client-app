import 'package:app_security/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userController = TextEditingController(text: 'admin');
  final _passController = TextEditingController(text: '12345678!Ab');
  final _authService = AuthService();

  String _status = '';

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _doLogin() async {
    setState(() => _status = 'Logeando...');

    final ok = await _authService.login(
      _userController.text,
      _passController.text,
    );

    if (!mounted) return;

    if (ok) {
      setState(() => _status = 'Login OK, llamando API...');
      final data = await _authService.getProfile();
      setState(() => _status = 'Respuesta API: $data');
    } else {
      setState(() => _status = 'Login falló');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login con IdentityServer')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _userController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _doLogin, child: const Text('Login')),
            const SizedBox(height: 16),
            Text(_status),
          ],
        ),
      ),
    );
  }
}
