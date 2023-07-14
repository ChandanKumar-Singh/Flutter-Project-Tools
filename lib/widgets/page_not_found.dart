import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/src/state.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key, required this.state});
  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/images/error_image.png', // Replace with your own image path
            //   width: 200,
            //   height: 200,
            // ),

            const SizedBox(height: 20),
            Text(
              'Page Not Found\n\n\n${state}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Oops! The page you are looking for does not exist.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // TODO: Handle button press, e.g., navigate to home page
                // context.go('/');
                Navigator.pop(context);
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
