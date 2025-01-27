import 'dart:io';
import 'player.dart';

class Game {
  late List<String> board;
  late Player player1;
  late Player player2;
  late Player currentPlayer;

  Game() {
     print("Player 1, enter your name: ");
    String? name1 = stdin.readLineSync();
    print("Player 1, choose your marker (X or O): ");
    String? marker1 = stdin.readLineSync()?.toUpperCase();
    marker1 = (marker1 == 'O') ? 'O' : 'X';

    print("Player 2, enter your name: ");
    String? name2 = stdin.readLineSync();
    String marker2 = marker1 == 'X' ? 'O' : 'X';

    player1 = Player(name1 ?? "Player 1", marker1);
    player2 = Player(name2 ?? "Player 2", marker2);
    currentPlayer = player1;

    print(player1.name + "is "+ marker1 +" and "+ player2.name+ " is " +marker2 +" the game begin!");
  }

  void initialize() {
   board = List.generate(9, (index) => (index + 1).toString());
  }

  void start() {
    bool gameOver = false;

    while (!gameOver) {
      printBoard();
      print(currentPlayer.name+ " , it's your turn. Enter your move (1-9): ");
      int? move = getValidMove();

      if (move != null) {
        board[move - 1] = currentPlayer.marker;
        gameOver = checkWin() || checkDraw();

        if (!gameOver) 
          switchTurn();
        
      }
    }

    printBoard();
  }

  void printBoard() {
    //this print methodology is more readable 
    print("""
       ${board[0]} | ${board[1]} | ${board[2]} 
      ---+---+---
       ${board[3]} | ${board[4]} | ${board[5]} 
      ---+---+---
       ${board[6]} | ${board[7]} | ${board[8]} 
    """);
  }

  int? getValidMove() {
    while (true) {
      String? input = stdin.readLineSync();
      int? move = int.tryParse(input ?? "");

      if (move != null && move >= 1 && move <= 9 && board[move - 1] != 'X' && board[move - 1] != 'O')
        return move;
      

      print("Invalid move. Please enter a number between 1-9 corresponding to an empty cell:");
    }
  }

  bool checkWin() {
    List<List<int>> winConditions = [
      [0, 1, 2], // Rows check
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6], // Columns check
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8], // Diagonals check
      [2, 4, 6]
    ];

    for (var condition in winConditions) {
      if (board[condition[0]] == currentPlayer.marker &&
          board[condition[1]] == currentPlayer.marker &&
          board[condition[2]] == currentPlayer.marker) {
        print(currentPlayer.name+ " wins");
        return true;
      }
    }

    return false;
  }

  bool checkDraw() {
    if (board.every((cell) => cell == 'X' || cell == 'O')) {
      print("It's a draw");
      return true;
    }

    return false;
  }

  void switchTurn() {
    currentPlayer = currentPlayer == player1 ? player2 : player1;
  }
}
