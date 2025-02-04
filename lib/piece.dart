enum PieceType {pawn, knight, bishop, rook, queen, king}

class Piece {
  final PieceType piece;
  final String colour;
  final String imagePath;

  Piece({
    required this.piece,
    required this.colour,
    required this.imagePath,
  });
}
