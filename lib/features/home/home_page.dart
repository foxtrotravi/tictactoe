import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/routing/routes.dart';
import 'package:tictactoe/features/game/widgets/board.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final dimension = min(width, height);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Tic Tac Toe',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(40),
                child: IgnorePointer(
                  child: Board(
                    gradientColors: const [Colors.blue, Colors.indigo],
                    gameState: GameState.initial().gameState,
                    dimension: dimension * 0.7,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(Routes.aiGame);
                },
                child: const Text('vs AI'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(Routes.game);
                },
                child: const Text('vs Human'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
