import 'package:flutter/material.dart';

class ThirdOnboardingPage extends StatelessWidget {
  const ThirdOnboardingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: const Text(
        'Here are 250 coins for getting started',
        textAlign: TextAlign.center,
      ),
    );
  }
}
