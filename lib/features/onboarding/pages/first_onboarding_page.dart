import 'package:flutter/material.dart';
import 'package:tictactoe/core/providers/game/game_provider.dart';
import 'package:tictactoe/core/themes/theme.dart';
import 'package:tictactoe/features/game/widgets/board.dart';

class FirstOnboardingPage extends StatelessWidget {
  const FirstOnboardingPage({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Colorful boards',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 40),
          IgnorePointer(
            child: Board(
              gradientColors: gradients[index],
              gameState: GameState.initial().gameState,
            ),
          ),
        ],
      ),
    );
  }
}
