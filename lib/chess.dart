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

  @override
  void initState() {
    super.initState();
    setupBoard();
  }

  void setupBoard() {
    List<List<Piece?>> newBoard =
        List.generate(8, (_) => List.generate(8, (_) => null));

    // pawns
    for (int i = 0; i < 8; i++) {
      newBoard[1][i] = Piece(
        piece: PieceType.pawn,
        colour: 'black',
        imagePath: 'assets/bP.png',
      );
      newBoard[6][i] = Piece(
        piece: PieceType.pawn,
        colour: 'white',
        imagePath: 'assets/wP.png',
      );
    }

    // knights
    newBoard[0][1] = Piece(
      piece: PieceType.knight,
      colour: 'black',
      imagePath: 'assets/bN.png',
    );
    newBoard[0][6] = Piece(
      piece: PieceType.knight,
      colour: 'black',
      imagePath: 'assets/bN.png',
    );
    newBoard[7][1] = Piece(
      piece: PieceType.knight,
      colour: 'white',
      imagePath: 'assets/wN.png',
    );
    newBoard[7][6] = Piece(
      piece: PieceType.knight,
      colour: 'white',
      imagePath: 'assets/wN.png',
    );

    // bishops
    newBoard[0][2] = Piece(
      piece: PieceType.bishop,
      colour: 'black',
      imagePath: 'assets/bB.png',
    );
    newBoard[0][5] = Piece(
      piece: PieceType.bishop,
      colour: 'black',
      imagePath: 'assets/bB.png',
    );
    newBoard[7][2] = Piece(
      piece: PieceType.bishop,
      colour: 'white',
      imagePath: 'assets/wB.png',
    );
    newBoard[7][5] = Piece(
      piece: PieceType.bishop,
      colour: 'white',
      imagePath: 'assets/wB.png',
    );

    // rooks
    newBoard[0][0] = Piece(
      piece: PieceType.rook,
      colour: 'black',
      imagePath: 'assets/bR.png',
    );
    newBoard[0][7] = Piece(
      piece: PieceType.rook,
      colour: 'black',
      imagePath: 'assets/bR.png',
    );
    newBoard[7][0] = Piece(
      piece: PieceType.rook,
      colour: 'white',
      imagePath: 'assets/wR.png',
    );
    newBoard[7][7] = Piece(
      piece: PieceType.rook,
      colour: 'white',
      imagePath: 'assets/wR.png',
    );

    // queens
    newBoard[0][3] = Piece(
      piece: PieceType.queen,
      colour: 'black',
      imagePath: 'assets/bQ.png',
    );
    newBoard[7][3] = Piece(
      piece: PieceType.queen,
      colour: 'white',
      imagePath: 'assets/wQ.png',
    );

    // Place kings
    newBoard[0][4] = Piece(
      piece: PieceType.king,
      colour: 'black',
      imagePath: 'assets/bK.png',
    );
    newBoard[7][4] = Piece(
      piece: PieceType.king,
      colour: 'white',
      imagePath: 'assets/wK.png',
    );

    board = newBoard;
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
              int col = index % 8;

              return Square(
                colour: (row + col) % 2 == 0 ? 'white' : 'black',
                piece: board[row][col],
              );
            },
          ),
        ),
      ),
    );
  }
}
