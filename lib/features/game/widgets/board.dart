import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/themes/theme.dart';
import 'package:tictactoe/core/utils/utils.dart';

class Board extends StatelessWidget {
  const Board({
    super.key,
    required this.gradientColors,
    required this.gameState,
    this.dimension,
  });

  final List<Color> gradientColors;
  final double? dimension;
  final List<List<int>> gameState;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final boardDimensions = min(height, width);

    final indexMap = {
      0: [0, 0],
      1: [0, 1],
      2: [0, 2],
      3: [1, 0],
      4: [1, 1],
      5: [1, 2],
      6: [2, 0],
      7: [2, 1],
      8: [2, 2],
    };

    return Container(
      height: dimension ?? boardDimensions * 0.9,
      width: dimension ?? boardDimensions * 0.9,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(4),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 9,
        itemBuilder: (context, index) {
          final x = indexMap[index]![0];
          final y = indexMap[index]![1];
          final value = gameState[x][y];

          return Container(
            decoration: BoxDecoration(
              color: AppTheme.scaffoldBackgroundColor,
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(4),
            child: Cell(
              x: x,
              y: y,
              value: value,
            ),
          );
        },
      ),
    );
  }
}

class Cell extends ConsumerWidget {
  const Cell({
    super.key,
    required this.x,
    required this.y,
    required this.value,
  });

  final int x;
  final int y;
  final int value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(gameProvider.select((value) => value.gameState[x][y]));
    return GestureDetector(
      onTap: () async {
        var game = ref.read(gameProvider);
        if (game.gameState[x][y] != -1 || isGameOver(game.gameState)) return;
        final isMyTurn = game.isMyTurn;
        final gameNotifierProvider = ref.read(gameProvider.notifier);
        gameNotifierProvider.set(x, y, isMyTurn ? 0 : 1);
        await Future.delayed(
          const Duration(milliseconds: 250),
        );
        game = ref.read(gameProvider);
        if (!isGameOver(game.gameState)) {
          gameNotifierProvider.aiMove();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: value == -1 ? null : Text(value == 0 ? 'X' : 'O'),
      ),
    );
  }
}
