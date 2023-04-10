bool isGameOver(List<List<int>> gameState) {
  // row
  bool rowWin = isRowWin(gameState[0]) ||
      isRowWin(gameState[1]) ||
      isRowWin(gameState[2]);
  // column
  bool colWin = isColWin(gameState, 0) ||
      isColWin(gameState, 1) ||
      isColWin(gameState, 2);
  // diagonal
  bool diagonalWin = isDiagonalWin(gameState);
  return rowWin || colWin || diagonalWin;
}

bool isRowWin(List<int> list) {
  final first = list[0];
  final second = list[1];
  final third = list[2];

  return first == second && first == third && first != -1;
}

bool isColWin(List<List<int>> list, int i) {
  final first = list[0][i];
  final second = list[1][i];
  final third = list[2][i];

  return first == second && first == third && first != -1;
}

bool isDiagonalWin(List<List<int>> list) {
  var first = list[0][0];
  var second = list[1][1];
  var third = list[2][2];
  bool diagonalWin = first == second && first == third && first != -1;

  first = list[0][2];
  third = list[2][0];

  diagonalWin =
      diagonalWin || (first == second && first == third && first != -1);

  return diagonalWin;
}

List<List<int>> nextMove(List<List<int>> currentState, int xo) {
  if (isGameOver(currentState)) return currentState;

  int bestScore = -1 << 10;
  var bestMove = <int>[];
  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      if (currentState[i][j] == -1) {
        currentState[i][j] = xo;
        int currentScore = minimax(currentState);
        if (currentScore > bestScore) {
          bestScore = currentScore;
          bestMove = [i, j];
        }
        currentState[i][j] = -1;
      }
    }
  }
  currentState[bestMove[0]][bestMove[1]] = xo;

  return currentState;
}

int minimax(List<List<int>> list) {
  return 1;
}
