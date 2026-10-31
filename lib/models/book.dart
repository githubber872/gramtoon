class Book {
  final String title;
  final String category;

  /// Normal price in rupiah (before discount).
  final int price;

  /// 0 means no discount.
  final int discountPercent;
  final String description;

  /// Optional cover image, e.g. 'assets/covers/kagurabachi_01.png'.
  /// If the file is missing, a colored placeholder is shown instead.
  final String? coverAsset;

  bool isFavorite;

  Book({
    required this.title,
    required this.category,
    required this.price,
    this.discountPercent = 0,
    this.description = 'No description yet.',
    this.coverAsset,
    this.isFavorite = false,
  });

  bool get hasDiscount => discountPercent > 0;

  int get finalPrice => price - (price * discountPercent ~/ 100);
}

/// 45000 -> "Rp 45.000"
String formatRupiah(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(digits[i]);
  }
  return 'Rp $buffer';
}
