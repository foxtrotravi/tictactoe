import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/core/enums/enums.dart';

GameWinner gameWinner(List<List<Player>> gameState) {
  for (var i = 0; i < 3; i++) {
    final winner = isRowWin(gameState[i], GameWinner.x);
    if (winner == GameWinner.x) {
      return GameWinner.x;
    }
  }

  for (var i = 0; i < 3; i++) {
    final winner = isRowWin(gameState[i], GameWinner.o);
    if (winner == GameWinner.o) {
      return GameWinner.o;
    }
  }

  for (var i = 0; i < 3; i++) {
    final winner = isColWin(gameState, i, Player.x);
    if (winner == GameWinner.x) {
      return GameWinner.x;
    }
  }

  for (var i = 0; i < 3; i++) {
    final winner = isColWin(gameState, i, Player.o);
    if (winner == GameWinner.o) {
      return GameWinner.o;
    }
  }

  // diagonal
  Player diagonalWin = isDiagonalWin(gameState);
  switch (diagonalWin) {
    case Player.x:
      return GameWinner.x;
    case Player.o:
      return GameWinner.o;
    default:
      break;
  }

  bool noChancesLeft = true;
  // no chances left
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (gameState[i][j] == Player.none) {
        noChancesLeft = false;
        break;
      }
    }
  }

  return noChancesLeft ? GameWinner.draw : GameWinner.none;
}

GameWinner isRowWin(List<Player> list, GameWinner gameWinner) {
  final first = list[0];
  final second = list[1];
  final third = list[2];

  if (first == second && first == third && first != Player.none) {
    return gameWinner;
  }
  return GameWinner.none;
}

GameWinner isColWin(List<List<Player>> list, int i, Player player) {
  final first = list[0][i];
  final second = list[1][i];
  final third = list[2][i];

  if (first == second && first == third && first == player) {
    if (player == Player.x) return GameWinner.x;
    if (player == Player.o) return GameWinner.o;
  }
  return GameWinner.none;
}

Player isDiagonalWin(List<List<Player>> list) {
  var first = list[0][0];
  var second = list[1][1];
  var third = list[2][2];
  bool diagonalWin = first == second && first == third && first != Player.none;

  first = list[0][2];
  third = list[2][0];

  diagonalWin = diagonalWin ||
      (first == second && first == third && first != Player.none);

  return diagonalWin ? second : Player.none;
}

List<List<Player>> nextMove(List<List<Player>> currentState, Player player) {
  GameWinner winner = gameWinner(currentState);
  if (winner != GameWinner.none) return currentState;

  int bestScore = -1 << 12;
  var bestMove = <int>[];
  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      if (currentState[i][j] == Player.none) {
        currentState[i][j] = player;
        int currentScore = minimax(currentState, 0, 0, false);
        currentState[i][j] = Player.none;
        debugPrint('currentScore: $currentScore');
        if (currentScore > bestScore) {
          bestScore = currentScore;
          bestMove = [i, j];
        }
      }
    }
  }
  currentState[bestMove[0]][bestMove[1]] = player;

  return currentState;
}

int winningScore(GameWinner winner) {
  switch (winner) {
    case GameWinner.x:
      return -1;
    case GameWinner.o:
      return 1;
    default:
      return 0;
  }
}

int minimax(List<List<Player>> list, int depth, int score, bool isMaximizing) {
  final winner = gameWinner(list);
  if (winner != GameWinner.none) {
    return winningScore(winner);
  }

  if (isMaximizing) {
    int bestScore = -1 << 20;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (list[i][j] == Player.none) {
          list[i][j] = Player.o;
          bestScore = minimax(list, depth + 1, score, false);
          list[i][j] = Player.none;
          score = max(bestScore, score);
        }
      }
    }
    return score;
  } else {
    int bestScore = 1 >> 20;
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (list[i][j] == Player.none) {
          list[i][j] = Player.x;
          bestScore = minimax(list, depth + 1, score, true);
          list[i][j] = Player.none;
          score = min(bestScore, score);
        }
      }
    }
    return score;
  }
}
