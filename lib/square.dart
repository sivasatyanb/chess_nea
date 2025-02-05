import 'package:flutter/material.dart';
import 'piece.dart';

class Square extends StatelessWidget {
  final String colour;
  final Piece? piece;
  final bool selected;
  final bool isValidMove;
  final void Function()? onTap;

  const Square({
    super.key,
    required this.colour,
    required this.piece,
    required this.selected,
    required this.isValidMove,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    Color? squareColour;

    if (selected) {
      squareColour = Colors.green;
    }
    else if (isValidMove) {
      squareColour = Colors.green[200];
    }
    else if (colour == 'white') {
      squareColour = Colors.grey[400];
    }
    else if (colour == 'black') {
      squareColour = Colors.brown;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: squareColour,
        child: piece != null ? Image.asset(piece!.image) : null,
      ),
    );
  }
}
