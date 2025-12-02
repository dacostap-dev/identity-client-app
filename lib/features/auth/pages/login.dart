import 'package:app_security/core/app_colors.dart';
import 'package:app_security/features/auth/pages/home.dart';
import 'package:app_security/features/auth/services/auth_service.dart';
import 'package:app_security/features/auth/services/auth_service_external.dart';
import 'package:app_security/features/auth/widgets/clippers.dart';
import 'package:flutter/material.dart';

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> with TickerProviderStateMixin {
  late final AnimationController animationController;

  final _userController = TextEditingController(text: 'admin');
  final _passController = TextEditingController(text: '12345678!Ab');

  final _authService = AuthService();
  final _authServiceExterno = AuthServiceExternal();

  String _status = '';

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();

    animationController.addListener(() {
      if (animationController.isCompleted) {
        //  animationController.reverse();
      }
      setState(() {});
    });

    super.initState();
  }

  Future<void> _doLogin() async {
    setState(() => _status = 'Logeando...');

    final ok = await _authService.login(
      _userController.text,
      _passController.text,
    );

    if (!mounted) return;

    if (ok) {
      // Navegamos al Home y reemplazamos la pantalla de login
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage(authService: _authService)),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Algo salió mal')));
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() => _status = 'Iniciando login...');

    final ok = await _authServiceExterno.loginWithGoogle();

    if (!mounted) return;

    if (ok) {
      setState(() => _status = 'Login OK, llamando API...');
      final profile = await _authService.getProfile();
      setState(() => _status = 'Respuesta API: $profile');
    } else {
      setState(() => _status = 'Login falló o fue cancelado.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          AppHeader(animationController: animationController),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(30),
                  child: TextFormField(
                    controller: _passController,
                    decoration: const InputDecoration(
                      // isDense: true,
                      hintText: 'Email',
                      prefixIcon: Icon(
                        Icons.email,
                        color: AppColors.kprimaryColor,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(30),
                  child: TextFormField(
                    controller: _userController,
                    decoration: const InputDecoration(
                      // isDense: true,
                      hintText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: AppColors.kprimaryColor,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    backgroundColor: AppColors.kprimaryColor,
                    foregroundColor: Colors.white,
                    fixedSize: Size(screenSize.width / 1, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _doLogin,
                  child: const Text('Login'),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'FORGOT PASSWORD?',
                    style: TextStyle(color: AppColors.kprimaryColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No tienes cuenta?',
                      style: TextStyle(fontWeight: FontWeight.w300),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Regístrate',
                        style: TextStyle(
                          color: AppColors.kprimaryColor,
                          fontWeight: FontWeight.w300,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.animationController});

  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: MyClipperTwo(animationController.value),
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0x22ff3a5a), Color(0x22fe494d)],
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: MyClipperThree(animationController.value),
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0x22ff3a5a), Color(0x22fe494d)],
              ),
            ),
          ),
        ),
        ClipPath(
          clipper: MyClipperOne(animationController.value),
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xffff3a5a), Color(0xfffe494d)],
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(height: 50),
                Icon(Icons.flutter_dash, size: 60, color: Colors.white),
                SizedBox(height: 8),
                Text(
                  'Flutter',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
