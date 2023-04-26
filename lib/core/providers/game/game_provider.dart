import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/core/enums/enums.dart';
import 'package:tictactoe/core/utils/utils.dart';

@immutable
class GameState {
  final List<List<Player>> gameState;
  final bool isMyTurn;

  const GameState({
    required this.gameState,
    required this.isMyTurn,
  });

  GameState updateGameState(int x, int y, Player player) {
    final list = [
      [Player.none, Player.none, Player.none],
      [Player.none, Player.none, Player.none],
      [Player.none, Player.none, Player.none],
    ];

    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (i != x || j != y) {
          list[i][j] = gameState[i][j];
        } else {
          list[i][j] = player;
        }
      }
    }
    return GameState(
      gameState: list,
      isMyTurn: isMyTurn,
    );
  }

  GameState copyWith({
    List<List<Player>>? gameState,
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
              [Player.none, Player.none, Player.none],
              [Player.none, Player.none, Player.none],
              [Player.none, Player.none, Player.none],
            ],
            isMyTurn: true,
          ),
        );

  void set(int x, int y, Player player) {
    state = state.updateGameState(x, y, player);
    toggle();
  }

  void toggle() {
    state = state.copyWith(isMyTurn: !state.isMyTurn);
  }

  void aiMove() {
    final bestMove = nextMove(state.gameState, Player.o);
    state = state.copyWith(
      gameState: bestMove,
      isMyTurn: true,
    );
  }
}

final gameProvider =
    StateNotifierProvider.autoDispose<GameStateNotifier, GameState>(
  (ref) => GameStateNotifier(),
);
