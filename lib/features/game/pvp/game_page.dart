import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/utils/utils.dart';
import 'package:tictactoe/features/game/widgets/board.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      gameProvider.select((value) => value.gameState),
      (previous, next) {
        if (isGameOver(next)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Game Over'),
            ),
          );
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Consumer(
            builder: (context, ref, child) {
              return Board(
                gameState: ref.watch(gameProvider).gameState,
                gradientColors: const [
                  Colors.indigo,
                  Colors.blue,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
