import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/enums/enums.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/utils/utils.dart';
import 'package:tictactoe/core/widgets/game_button.dart';
import 'package:tictactoe/features/game/widgets/board.dart';

class AIGamePage extends ConsumerStatefulWidget {
  const AIGamePage({super.key});

  @override
  ConsumerState<AIGamePage> createState() => _AIGamePageState();
}

class _AIGamePageState extends ConsumerState<AIGamePage> {
  bool isGameOver = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, ref, child) {
                ref.listen(
                  gameProvider,
                  (previous, next) {
                    checkWinner(context, next.gameState);
                  },
                );
                return Board(
                  isAi: true,
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
              child: GameButton(
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
    final winner = gameWinner(gameState);
    late String player;
    if (winner != GameWinner.none) {
      switch (winner) {
        case GameWinner.x:
          player = 'X wins';
          break;
        case GameWinner.o:
          player = 'O wins';
          break;
        case GameWinner.draw:
          player = 'Game Draw';
          break;
        default:
          break;
      }

      if (!isGameOver) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(player),
          ),
        );
      }
      isGameOver = true;
    }
  }
}
