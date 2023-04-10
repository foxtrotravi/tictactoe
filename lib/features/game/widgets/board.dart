import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/core/themes/theme.dart';

class Board extends StatelessWidget {
  const Board({
    super.key,
    required this.gradientColors,
  });

  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final boardDimensions = min(height, width);

    return Container(
      height: boardDimensions * 0.9,
      width: boardDimensions * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xFF444B64),
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
            child: GestureDetector(
              onTap: () {
                debugPrint('Clicked $index');
              },
              child: Container(
                color: AppTheme.scaffoldBackgroundColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
