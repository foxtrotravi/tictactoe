import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictactoe/features/game/widgets/board.dart';

class BoardList extends StateNotifier<List<Board>> {
  BoardList({List<Board>? boards}) : super(boards ?? []);

  void buyBoard({required int id}) {
    final temp = state;
    temp[id] = temp[id].copyWith(isLocked: false);
    state = temp;
  }
}
