import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/features/game/widgets/board.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pvpGame = ref.watch(gameProvider);

    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Board(
            gameState: pvpGame.gameState,
            gradientColors: const [
              Colors.indigo,
              Colors.blue,
            ],
          ),
        ),
      ),
    );
  }
}
