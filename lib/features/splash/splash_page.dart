import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    handleNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Icon(Icons.home),
      ),
    );
  }

  Future<void> handleNavigation() async {
    await Future.delayed(
      const Duration(seconds: 1),
    );

    // Check for already logged in user
    // Navigate to onboarding page if user is new
    // Navigate to home page if user already exists
  }
}
