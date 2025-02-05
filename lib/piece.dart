enum PieceType {pawn, knight, bishop, rook, queen, king}

class Piece {
  final PieceType piece;
  final String colour;
  final String image;

  Piece({
    required this.piece,
    required this.colour,
    required this.image,
  });
}
