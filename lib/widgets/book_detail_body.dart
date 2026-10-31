import 'package:flutter/material.dart';

import '../models/book.dart';
import 'book_cover.dart';

/// The detail layout shared by the book detail screen and Book of the day.
/// It is a StatefulWidget: tapping Favorite calls setState and redraws.
class BookDetailBody extends StatefulWidget {
  const BookDetailBody({super.key, required this.book});

  final Book book;

  @override
  State<BookDetailBody> createState() => _BookDetailBodyState();
}

class _BookDetailBodyState extends State<BookDetailBody> {
  void _toggleFavorite() {
    setState(() {
      widget.book.isFavorite = !widget.book.isFavorite;
    });

    final message = widget.book.isFavorite
        ? 'Added to favorites'
        : 'Removed from favorites';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _buy() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${widget.book.title}" added to your order')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: BookCover(book: book, width: 200, height: 290)),
          const SizedBox(height: 16),
          Text(
            book.category,
            style: textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
          ),
          Text(book.title, style: textTheme.headlineSmall),
          const SizedBox(height: 8),

          // A real decision: show the discount layout only when there is one.
          if (book.hasDiscount)
            Row(
              children: [
                Text(formatRupiah(book.finalPrice), style: textTheme.titleLarge),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('${book.discountPercent}%'),
                ),
                const SizedBox(width: 8),
                Text(
                  formatRupiah(book.price),
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          else
            Text(formatRupiah(book.price), style: textTheme.titleLarge),

          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: _toggleFavorite,
            icon: Icon(book.isFavorite ? Icons.favorite : Icons.favorite_border),
            label: const Text('Favorite'),
          ),
          const SizedBox(height: 8),
          FilledButton(onPressed: _buy, child: const Text('Buy now')),
          const SizedBox(height: 24),
          Text('Description:', style: textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(book.description),
        ],
      ),
    );
  }
}
