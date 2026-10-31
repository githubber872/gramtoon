import 'package:flutter/material.dart';

import '../models/book.dart';

/// Shows the cover image if it exists in assets, otherwise a colored box
/// with the title, so the app still looks fine without image files.
class BookCover extends StatelessWidget {
  const BookCover({super.key, required this.book, this.width, this.height});

  final Book book;
  final double? width;
  final double? height;

  Color _placeholderColor() {
    final colors = [
      Colors.red.shade400,
      Colors.indigo.shade300,
      Colors.teal.shade400,
      Colors.orange.shade400,
      Colors.purple.shade300,
      Colors.pink.shade300,
    ];
    return colors[book.title.length % colors.length];
  }

  Widget _placeholder() {
    return Container(
      width: width,
      height: height,
      color: _placeholderColor(),
      padding: const EdgeInsets.all(6),
      alignment: Alignment.center,
      child: Text(
        book.title,
        textAlign: TextAlign.center,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final asset = book.coverAsset;
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: asset == null
          ? _placeholder()
          : Image.asset(
              asset,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => _placeholder(),
            ),
    );
  }
}
