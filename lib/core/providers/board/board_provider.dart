import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardState {
  final List<Color> gradientColors;
  final int cashback;

  const BoardState({
    this.gradientColors = const [Colors.blue, Colors.indigo],
    this.cashback = 50,
  });

  factory BoardState.initial() {
    return const BoardState();
  }
}

class BoardStateNotifier extends StateNotifier<BoardState> {
  BoardStateNotifier() : super(BoardState.initial());
}

final boardProvider = StateNotifierProvider(
  (ref) => BoardStateNotifier(),
);
