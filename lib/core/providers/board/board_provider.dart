import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/providers/index.dart';
import 'package:tictactoe/core/providers/shop/shop_provider.dart';
import 'package:tictactoe/features/game/widgets/board.dart';

final boardsProvider = StateNotifierProvider<BoardList, List<Board>>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider).value!;

  return BoardList(boards: [
    Board(
      id: 0,
      gradientColors: const [Colors.blue, Colors.indigo],
      gameState: GameState.initial().gameState,
      cashback: 25,
      cost: 0,
      isLocked: false,
    ),
    Board(
      id: 1,
      gradientColors: const [Colors.pink, Colors.red],
      gameState: GameState.initial().gameState,
      cashback: 50,
      cost: 200,
      isLocked: sharedPreferences.getInt('board_1') != 1,
    ),
    Board(
      id: 2,
      gradientColors: const [Colors.yellow, Colors.orange],
      gameState: GameState.initial().gameState,
      cashback: 100,
      cost: 500,
      isLocked: sharedPreferences.getInt('board_2') != 1,
    ),
    Board(
      id: 3,
      gradientColors: const [Colors.green, Colors.lime],
      gameState: GameState.initial().gameState,
      cashback: 500,
      cost: 2500,
      isLocked: sharedPreferences.getInt('board_3') != 1,
    ),
  ]);
});
