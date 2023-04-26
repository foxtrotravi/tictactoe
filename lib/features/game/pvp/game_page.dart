import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/enums/enums.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/utils/utils.dart';
import 'package:tictactoe/features/game/widgets/board.dart';

class GamePage extends ConsumerStatefulWidget {
  const GamePage({super.key});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
  bool isGameOver = false;

  @override
  Widget build(BuildContext context) {
    ref.listen(
      gameProvider,
      (previous, next) {
        checkWinner(context, next.gameState);
      },
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
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
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final _ = ref.refresh(gameProvider);
                  isGameOver = false;
                },
                child: const Text('Restart'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkWinner(BuildContext context, List<List<Player>> gameState) {
    final winningPlayer = gameWinner(gameState);

    late String winner;
    switch (winningPlayer) {
      case GameWinner.x:
        winner = 'X wins';
        break;
      case GameWinner.o:
        winner = 'O wins';
        break;
      case GameWinner.draw:
        winner = 'Draw';
        break;
      default:
        break;
    }
    if (!isGameOver) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(winner),
        ),
      );
      isGameOver = true;
    }
  }
}
