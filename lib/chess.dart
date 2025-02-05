import 'square.dart';
import 'package:flutter/material.dart';
import 'piece.dart';

class Chess extends StatefulWidget {
  const Chess({super.key});

  @override
  State<Chess> createState() => _ChessState();
}

class _ChessState extends State<Chess> {
  late List<List<Piece?>> board;

  Piece? selectedPiece;
  int selectedRow = -1;
  int selectedColumn = -1;

  List<List<int>> validMoves = [];

  @override
  void initState() {
    super.initState();
    setupBoard();
  }

  bool validCoordinates(int row, int col) {
    return row >= 0 && row < 8 && col >= 0 && col < 8;
  }

  void setupBoard() {
    List<List<Piece?>> newBoard = List.generate(
      8,
      (_) => List.generate(8, (_) => null),
    );

    // pawns
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = Piece(
        piece: PieceType.pawn,
        colour: 'black',
        image: 'assets/bP.png',
      );
      newBoard[6][i] = Piece(
        piece: PieceType.pawn,
        colour: 'white',
        image: 'assets/wP.png',
      );
    }

    // newBoard[3][4] = Piece(piece: PieceType.king, colour: 'white', image: 'assets/wK.png');
    // newBoard[4][5] = Piece(piece: PieceType.king, colour: 'black', image: 'assets/bK.png');

    // knights
    newBoard[0][1] = Piece(
      piece: PieceType.knight,
      colour: 'black',
      image: 'assets/bN.png',
    );
    newBoard[0][6] = Piece(
      piece: PieceType.knight,
      colour: 'black',
      image: 'assets/bN.png',
    );
    newBoard[7][1] = Piece(
      piece: PieceType.knight,
      colour: 'white',
      image: 'assets/wN.png',
    );
    newBoard[7][6] = Piece(
      piece: PieceType.knight,
      colour: 'white',
      image: 'assets/wN.png',
    );

    // bishops
    newBoard[0][2] = Piece(
      piece: PieceType.bishop,
      colour: 'black',
      image: 'assets/bB.png',
    );
    newBoard[0][5] = Piece(
      piece: PieceType.bishop,
      colour: 'black',
      image: 'assets/bB.png',
    );
    newBoard[7][2] = Piece(
      piece: PieceType.bishop,
      colour: 'white',
      image: 'assets/wB.png',
    );
    newBoard[7][5] = Piece(
      piece: PieceType.bishop,
      colour: 'white',
      image: 'assets/wB.png',
    );

    // rooks
    newBoard[0][0] = Piece(
      piece: PieceType.rook,
      colour: 'black',
      image: 'assets/bR.png',
    );
    newBoard[0][7] = Piece(
      piece: PieceType.rook,
      colour: 'black',
      image: 'assets/bR.png',
    );
    newBoard[7][0] = Piece(
      piece: PieceType.rook,
      colour: 'white',
      image: 'assets/wR.png',
    );
    newBoard[7][7] = Piece(
      piece: PieceType.rook,
      colour: 'white',
      image: 'assets/wR.png',
    );

    // queens
    newBoard[0][3] = Piece(
      piece: PieceType.queen,
      colour: 'black',
      image: 'assets/bQ.png',
    );
    newBoard[7][3] = Piece(
      piece: PieceType.queen,
      colour: 'white',
      image: 'assets/wQ.png',
    );

    // kings
    newBoard[0][4] = Piece(
      piece: PieceType.king,
      colour: 'black',
      image: 'assets/bK.png',
    );
    newBoard[7][4] = Piece(
      piece: PieceType.king,
      colour: 'white',
      image: 'assets/wK.png',
    );

    board = newBoard;
  }

  void selectPiece(int row, int column) {
    setState(() {
      if (board[row][column] != null) {
        selectedPiece = board[row][column];
        selectedRow = row;
        selectedColumn = column;
      }
      validMoves =
          calculateValidMoves(selectedPiece, selectedRow, selectedColumn);
    });
  }

  List<List<int>> calculateValidMoves(Piece? piece, int row, int column) {
    List<List<int>> validMoves = [];

    // different directions based on their color
    int direction = piece!.colour == 'white' ? -1 : 1;

    switch (piece.piece) {
      case PieceType.pawn:
        // moving one square
        if (validCoordinates(row + direction, column) &&
            board[row + direction][column] == null) {
          validMoves.add([row + direction, column]);
        }

        // moving two squares on first move
        if ((row == 1 && piece.colour == 'black') ||
            (row == 6 && piece.colour == 'white')) {
          if (validCoordinates(row + 2 * direction, column) &&
              board[row + 2 * direction][column] == null &&
              board[row + direction][column] == null) {
            validMoves.add([row + 2 * direction, column]);
          }
        }
        // note: left and right is the perspective from that colour's side
        // white capture left
        if (validCoordinates(row + direction, column - 1) &&
            board[row + direction][column - 1] != null &&
            board[row + direction][column - 1]!.colour == 'white') {
          validMoves.add([row + direction, column - 1]);
        }
        // white capture right
        if (validCoordinates(row + direction, column + 1) &&
            board[row + direction][column + 1] != null &&
            board[row + direction][column + 1]!.colour == 'white') {
          validMoves.add([row + direction, column + 1]);
        }
        // black capture left
        if (validCoordinates(row + direction, column + 1) &&
            board[row + direction][column + 1] != null &&
            board[row + direction][column + 1]!.colour == 'black') {
          validMoves.add([row + direction, column + 1]);
        }
        // black capture right
        if (validCoordinates(row + direction, column - 1) &&
            board[row + direction][column - 1] != null &&
            board[row + direction][column - 1]!.colour == 'black') {
          validMoves.add([row + direction, column - 1]);
        }

        break;

      case PieceType.knight:
        // all eight possible L shapes that knight can move
        var knightMoves = [
          [-2, -1], // up 2 left 1
          [-2, 1], // up 2 right 1
          [-1, -2], // up 1 left 2
          [-1, 2], // up 1 right 2
          [1, -2], // down 1 left 2
          [1, 2], // down 1 right 2
          [2, -1], // down 2 left 1
          [2, 1], // down 2 right 1
        ];

        for (var move in knightMoves) {
          var newRow = row + move[0];
          var newColumn = column + move[1];
          if (!validCoordinates(newRow, newColumn)) {
            continue;
          }
          // capturing
          if (board[newRow][newColumn] != null) {
            if (board[newRow][newColumn]!.colour != piece.colour) {
              validMoves.add([newRow, newColumn]);
            }
            continue;
          }
          // normal move
          validMoves.add([newRow, newColumn]);
        }

        break;

      case PieceType.bishop:
        // diagonal directions
        var directions = [
          [-1, -1], // up left
          [-1, 1], // up right
          [1, -1], // down left
          [1, 1], // down right
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newColumn = column + i * direction[1];
            if (!validCoordinates(newRow, newColumn)) {
              break;
            }
            // capturing
            if (board[newRow][newColumn] != null) {
              if (board[newRow][newColumn]!.colour != piece.colour) {
                validMoves.add([newRow, newColumn]);
              }
              break;
            }
            validMoves.add([newRow, newColumn]);
            i++;
          }
        }
        break;

      case PieceType.rook:
        // horizontal and vertical directions
        var directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], // left
          [0, 1], // right
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newColumn = column + i * direction[1];
            if (!validCoordinates(newRow, newColumn)) {
              break;
            }
            if (board[newRow][newColumn] != null) {
              // capture
              if (board[newRow][newColumn]!.colour != piece.colour) {
                validMoves.add([newRow, newColumn]);
              }
              break;
            }
            validMoves.add([newRow, newColumn]);
            i++;
          }
        }
        break;

      case PieceType.queen:
        // all eight directions
        var directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], // left
          [0, 1], // right
          [-1, -1], // up left
          [-1, 1], // up right
          [1, -1], // down left
          [1, 1], // down right
        ];

        for (var direction in directions) {
          var i = 1;
          while (true) {
            var newRow = row + i * direction[0];
            var newColumn = column + i * direction[1];
            if (!validCoordinates(newRow, newColumn)) {
              break;
            }
            // capturing
            if (board[newRow][newColumn] != null) {
              if (board[newRow][newColumn]!.colour != piece.colour) {
                validMoves.add([newRow, newColumn]);
              }
              break;
            }
            // normal move
            validMoves.add([newRow, newColumn]);
            i++;
          }
        }
        break;

      case PieceType.king:
        // all eight directions
        var directions = [
          [-1, 0], // up
          [1, 0], // down
          [0, -1], // left
          [0, 1], // right
          [-1, -1], // up left
          [-1, 1], // up right
          [1, -1], // down left
          [1, 1], // down right
        ];

        for (var direction in directions) {
          var newRow = row + direction[0];
          var newColumn = column + direction[1];
          if (!validCoordinates(newRow, newColumn)) {
            continue;
          }
          // capturing
          if (board[newRow][newColumn] != null) {
            if (board[newRow][newColumn]!.colour != piece.colour) {
              validMoves.add([newRow, newColumn]);
            }
            continue;
          }
          // normal move
          validMoves.add([newRow, newColumn]);
        }

        break;
    }

    return validMoves;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: GridView.builder(
            itemCount: 64,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8),
            itemBuilder: (context, index) {
              int row = index ~/ 8;
              int column = index % 8;

              bool selected =
                  (selectedRow == row) && (selectedColumn == column);

              bool isValidMove = false;
              for (var position in validMoves) {
                if (position[0] == row && position[1] == column) {
                  isValidMove = true;
                }
              }

              return Square(
                colour: (row + column) % 2 == 0 ? 'white' : 'black',
                piece: board[row][column],
                selected: selected,
                isValidMove: isValidMove,
                onTap: () => selectPiece(row, column),
              );
            },
          ),
        ),
      ),
    );
  }
}
