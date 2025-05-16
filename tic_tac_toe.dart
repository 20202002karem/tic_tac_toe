import 'dart:io';

void main() {
  runGame();
}

/// Runs the Tic-Tac-Toe game, allowing players to play multiple rounds
void runGame() {
  bool playAgain = true;
  print('Welcome to Tic-Tac-Toe!');

  while (playAgain) {
    List<List<String>> board = initializeBoard();
    String currentPlayer = 'X';
    bool gameEnded = false;

    while (!gameEnded) {
      displayBoard(board);
      int move = getPlayerMove(board, currentPlayer);
      makeMove(board, move, currentPlayer);

      if (checkWin(board, currentPlayer)) {
        displayBoard(board);
        print('Player $currentPlayer wins!');
        gameEnded = true;
      } else if (isBoardFull(board)) {
        displayBoard(board);
        print('It\'s a draw!');
        gameEnded = true;
      } else {
        // Switch players
        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
      }
    }

    // Ask if players want to play again
    print('Would you like to play again? (y/n): ');
    String answer = stdin.readLineSync()?.trim().toLowerCase() ?? '';
    playAgain = (answer == 'y' || answer == 'yes');
  }

  print('Thanks for playing!');
}

/// Initializes the game board as a 3x3 grid filled with empty strings
List<List<String>> initializeBoard() {
  return List.generate(3, (_) => List.generate(3, (_) => ' '));
}

/// Displays the current state of the board
void displayBoard(List<List<String>> board) {
  print('\nCurrent Board:');
  for (int i = 0; i < 3; i++) {
    print(' ${board[i][0]} | ${board[i][1]} | ${board[i][2]} ');
    if (i < 2) {
      print('---+---+---');
    }
  }
  print('');
}

/// Prompts the current player for a move and validates input
int getPlayerMove(List<List<String>> board, String player) {
  while (true) {
    print('Player $player, enter your move (1-9): ');
    String? input = stdin.readLineSync();

    if (input == null) {
      print('Invalid input. Please enter a number between 1 and 9.');
      continue;
    }

    int? move = int.tryParse(input.trim());

    if (move == null || move < 1 || move > 9) {
      print('Invalid input. Please enter a number between 1 and 9.');
      continue;
    }

    // Map move to board coordinates
    int row = (move - 1) ~/ 3;
    int col = (move - 1) % 3;

    if (board[row][col] != ' ') {
      print('Cell already taken. Please choose another move.');
    } else {
      return move;
    }
  }
}

/// Places the player's mark on the board at the specified move
void makeMove(List<List<String>> board, int move, String player) {
  int row = (move - 1) ~/ 3;
  int col = (move - 1) % 3;
  board[row][col] = player;
}

/// Checks all possible winning conditions
bool checkWin(List<List<String>> board, String player) {
  // Check rows
  for (int i = 0; i < 3; i++) {
    if (board[i][0] == player &&
        board[i][1] == player &&
        board[i][2] == player) {
      return true;
    }
  }

  // Check columns
  for (int i = 0; i < 3; i++) {
    if (board[0][i] == player &&
        board[1][i] == player &&
        board[2][i] == player) {
      return true;
    }
  }

  // Check diagonals
  if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {
    return true;
  }
  if (board[0][2] == player && board[1][1] == player && board[2][0] == player) {
    return true;
  }

  return false;
}

/// Checks if the board is fully filled
bool isBoardFull(List<List<String>> board) {
  for (var row in board) {
    if (row.contains(' ')) {
      return false;
    }
  }
  return true;
}
