import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/enums/enums.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/themes/theme.dart';
import 'package:tictactoe/core/utils/utils.dart';

class Board extends StatelessWidget {
  const Board({
    super.key,
    this.id = -1,
    required this.gradientColors,
    required this.gameState,
    this.isAi = false,
    this.dimension,
    this.cost = 0,
    this.cashback = 0,
    this.isLocked = true,
  });

  final List<Color> gradientColors;
  final double? dimension;
  final List<List<Player>> gameState;
  final bool isAi;
  final int cost;
  final int cashback;
  final int id;
  final bool isLocked;

  Board copyWith({
    List<Color>? gradientColors,
    double? dimension,
    List<List<Player>>? gameState,
    bool? isAi,
    int? cost,
    int? cashback,
    bool? isLocked,
  }) {
    return Board(
      gradientColors: gradientColors ?? this.gradientColors,
      gameState: gameState ?? this.gameState,
      cashback: cashback ?? this.cashback,
      cost: cost ?? this.cost,
      dimension: dimension ?? this.dimension,
      isAi: isAi ?? this.isAi,
      isLocked: isLocked ?? this.isLocked,
    );
  }

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

          return AnimatedContainer(
            duration: const Duration(seconds: 1),
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
              isAi: isAi,
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
    required this.isAi,
  });

  final int x;
  final int y;
  final Player value;
  final bool isAi;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(gameProvider.select((value) => value.gameState[x][y]));
    return GestureDetector(
      onTap: () async {
        var game = ref.read(gameProvider);
        if (game.gameState[x][y] != Player.none ||
            gameWinner(game.gameState) != GameWinner.none) {
          debugPrint('Returning');
          debugPrint(
              'gameWinner(game.gameState) != GameWinner.none: ${gameWinner(game.gameState)}');
          return;
        }
        final isMyTurn = game.isMyTurn;
        final gameNotifierProvider = ref.read(gameProvider.notifier);
        gameNotifierProvider.set(x, y, isMyTurn ? Player.x : Player.o);
        if (isAi) {
          await Future.delayed(
            const Duration(milliseconds: 250),
          );
          game = ref.read(gameProvider);
          if (gameWinner(game.gameState) == GameWinner.none && isAi) {
            gameNotifierProvider.aiMove();
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.center,
        child: value == Player.none
            ? null
            : Text(
                value == Player.x ? 'X' : 'O',
              ),
      ),
    );
  }
}
