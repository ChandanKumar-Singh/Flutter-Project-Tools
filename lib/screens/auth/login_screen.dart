import 'package:flutter/material.dart';

import '../../route_management/my_router.dart';
import '../../services/auth_service.dart';

/// The login screen.
class LoginScreen extends StatefulWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool loggingIn = false;
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
      setState(() {});
    });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (loggingIn) CircularProgressIndicator(value: controller.value),
          if (!loggingIn)
            ElevatedButton(
              onPressed: () {
                StreamAuthScope.of(context).signIn('test-user');
                setState(() {
                  loggingIn = true;
                });
              },
              child: const Text('Login'),
            ),
        ],
      ),
    ),
  );
}
