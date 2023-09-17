import 'package:flutter/material.dart';
import 'package:tictactoe/core/widgets/coins.dart';

class ThirdOnboardingPage extends StatelessWidget {
  const ThirdOnboardingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Coin(),
          SizedBox(height: 20),
          Text(
            'Here are 250 coins for getting started',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
