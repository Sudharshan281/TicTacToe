import 'package:xox/backend/player.dart';

class Game {
  static const boardSize = 9;
  static const squareSize = 100.0;

  //Creating the empty board
  List<String>? board;

  static List<String>? initBoard() =>
      List.generate(boardSize, (index) => Player.empty);

  bool hasWon(String player) {
    int score = 0;
    for (int i = 0; i < 3; ++i) {
      for (int j = 0; j < 3; ++j) {
        if (board![i * 3 + j] == player) score += 1;
      }
      if (score == 3) return true;
      score = 0;
    }

    if (board![0] == player && board![4] == player && board![8] == player) {
      return true;
    } else if (board![2] == player &&
        board![4] == player &&
        board![6] == player) {
      return true;
    } else {
      int start = 0;
      int increment = 3;
      while (start < 3) {
        for (int j = 0; j < 3; ++j) {
          if (board![start + j * increment] == player) score += 1;
        }
        if (score == 3) return true;
        score = 0;
        start += 1;
      }
    }
    return false;
  }
}
