import 'package:flutter/material.dart';
import 'piece.dart';

class Square extends StatelessWidget {
  final String colour;
  final Piece? piece;
  const Square({
    super.key,
    required this.colour,
    required this.piece,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colour == 'white' ? Colors.grey[400] : Colors.brown,
      child: piece != null ? Image.asset(piece!.imagePath) : null,
    );
  }
}
