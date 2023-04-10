import 'package:flutter/material.dart';
import 'package:tictactoe/features/game/widgets/board.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: const Board(
            gradientColors: [
              Colors.indigo,
              Colors.blue,
            ],
          ),
        ),
      ),
    );
  }
}
