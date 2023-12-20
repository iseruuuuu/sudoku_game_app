// Function to fill a given square with numbers 1 - 9 and produce a list of boards

import 'package:sudoku_game_app/models/position_model.dart';

import 'board_square.dart';

List<List<BoardSquare>> solveBoard(List<List<int>> simpleBoard) {
  List<List<BoardSquare>> board = convertIntToBoard(simpleBoard);

  List<BoardSquare> flatBoard = board.expand((element) => element).toList();

  Position position = getNextEmptySquare(flatBoard);

  List<List<List<BoardSquare>>> newBoards = createNewBoards(position, board);

  for (List<List<BoardSquare>> board in newBoards) {
    if (checkLegal(board) == true) {
      if (hasBlanks(board) == false) {
        return board;
      } else {
        List<List<BoardSquare>> unsolvedBoard = solveBoard(
          List.generate(
            9,
            (int row) => List.generate(
              9,
              (int column) => board[row][column].value,
            ),
          ),
        );
        if (unsolvedBoard != null) {
          return unsolvedBoard;
        }
      }
    }
  }
}

Position getNextEmptySquare(List<BoardSquare> flatBoard) {
  BoardSquare square = flatBoard.firstWhere((element) => element.value == 0);
  return square.position;
}

List<List<List<BoardSquare>>> createNewBoards(
    Position position, List<List<BoardSquare>> board) {
  List<List<List<BoardSquare>>> updatedBoards = [];

  for (int i = 1; i < 10; i++) {
    List<List<BoardSquare>> newBoard = createNewBoard(board);
    newBoard[position.x][position.y].value = i;
    updatedBoards.add(newBoard);
  }
  return updatedBoards;
}

bool hasBlanks(List<List<BoardSquare>> board) {
  bool noBlanks = true;
  for (List<BoardSquare> row in board) {
    noBlanks = row.any((element) => element.value == 0);
  }
  return noBlanks;
}

List<dynamic> checkLegal(List<List<BoardSquare>> board) {
  List<List<BoardSquare>> subsets = createFullSublist(board);
  var isUnique = [
    true,
    [Position(), Position()]
  ];
  for (List<BoardSquare> boardList in subsets) {
    List<BoardSquare> newSet = [];
    for (BoardSquare square in boardList) {
      for (BoardSquare square1 in newSet) {
        if (square.value == square1.value && square.value != 0) {
          isUnique[0] = false;
          isUnique[1] = [square.position, square1.position];
          break;
        }
      }
      newSet.add(square);
    }
  }
  return isUnique;
}

List<List<BoardSquare>> createFullSublist(List<List<BoardSquare>> board) {
  List<List<BoardSquare>> combinedList = [];
  List<List<BoardSquare>> rows = getSublistOfRows(board);
  List<List<BoardSquare>> columns = getSublistOfColumns(board);
  List<List<BoardSquare>> threeXThree = getSublistThreeXThree(board);
  combinedList = rows + columns + threeXThree;
  return combinedList;
}

// Function to get a list of Rows. This is easy.
List<List<BoardSquare>> getSublistOfRows(List<List<BoardSquare>> board) {
  List<List<BoardSquare>> _listOfRows = [];
  for (int i = 0; i < 9; i++) {
    _listOfRows.add(board[i]);
  }
  return _listOfRows;
}

// Function to get a list of Columns. This was harder because it required nested for loops
List<List<BoardSquare>> getSublistOfColumns(List<List<BoardSquare>> board) {
  List<List<BoardSquare>> _listOfColumns = [];
  for (int i = 0; i < 9; i++) {
    List<BoardSquare> _listOfBoardSquares = [];
    for (int j = 0; j < 9; j++) {
      _listOfBoardSquares.add(board[j][i]);
    }
    _listOfColumns.add(_listOfBoardSquares);
  }
  return _listOfColumns;
}

// Function to create list of the small 3x3 grids
List<List<BoardSquare>> getSublistThreeXThree(List<List<BoardSquare>> board) {
  List<List<BoardSquare>> _listOfThreeXThree = [];
  for (int i = 0; i < 9; i += 3) {
    for (int j = 0; j < 9; j += 3) {
      List<BoardSquare> _subListOfBoardSquares = [];
      _subListOfBoardSquares.add(board[i][j]);
      _subListOfBoardSquares.add(board[i][j + 1]);
      _subListOfBoardSquares.add(board[i][j + 2]);
      _subListOfBoardSquares.add(board[i + 1][j]);
      _subListOfBoardSquares.add(board[i + 1][j + 1]);
      _subListOfBoardSquares.add(board[i + 1][j + 2]);
      _subListOfBoardSquares.add(board[i + 2][j]);
      _subListOfBoardSquares.add(board[i + 2][j + 1]);
      _subListOfBoardSquares.add(board[i + 2][j + 2]);
      _listOfThreeXThree.add(_subListOfBoardSquares);
    }
  }
  return _listOfThreeXThree;
}

// Helper function to create a new board from existing board
List<List<BoardSquare>> createNewBoard(List<List<BoardSquare>> oldBoard) {
  List<List<BoardSquare>> newBoard = List.generate(
    9,
    (int row) => List.generate(
      9,
      (int column) => BoardSquare(
          position: Position(x: row, y: column),
          value: oldBoard[row][column].value),
    ),
  );
  return newBoard;
}

// Helper function to convert an ordered list of numbers into a Board
List<List<BoardSquare>> convertIntToBoard(List<List<int>> simpleBoard) {
  List<List<BoardSquare>> newBoard = List.generate(
    9,
    (int row) => List.generate(
      9,
      (int column) => BoardSquare(
          position: Position(x: row, y: column),
          value: simpleBoard[row][column]),
    ),
  );
  return newBoard;
}
