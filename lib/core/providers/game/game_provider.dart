import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class GameState {
  final List<List<int>> gameState;
  final bool isMyTurn;

  const GameState({
    required this.gameState,
    required this.isMyTurn,
  });

  GameState updateGameState(int x, int y, int value) {
    final list = [
      [-1, -1, -1],
      [-1, -1, -1],
      [-1, -1, -1],
    ];

    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (i != x || j != y) {
          list[i][j] = gameState[i][j];
        } else {
          list[i][j] = value;
        }
      }
    }
    return GameState(
      gameState: list,
      isMyTurn: isMyTurn,
    );
  }

  GameState copyWith({
    List<List<int>>? gameState,
    bool? isMyTurn,
  }) {
    return GameState(
      gameState: gameState ?? this.gameState,
      isMyTurn: isMyTurn ?? this.isMyTurn,
    );
  }

  @override
  String toString() {
    return gameState.toString();
  }
}

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier()
      : super(
          const GameState(
            gameState: [
              [-1, -1, -1],
              [-1, -1, -1],
              [-1, -1, -1],
            ],
            isMyTurn: true,
          ),
        );

  void set(int x, int y, int value) {
    state = state.updateGameState(x, y, value);
  }

  void toggle() {
    state = state.copyWith(isMyTurn: !state.isMyTurn);
  }
}

final gameProvider =
    StateNotifierProvider.autoDispose<GameStateNotifier, GameState>(
  (ref) => GameStateNotifier(),
);
