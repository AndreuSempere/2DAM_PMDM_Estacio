import 'package:flutter/material.dart';

class YesNoScreen extends StatelessWidget {
  final bool isYes;

  const YesNoScreen({super.key, required this.isYes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Has votado',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 10),
            Image.asset(
              isYes ? 'lib/assets/yes.jpg' : 'lib/assets/no.jpg',
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
