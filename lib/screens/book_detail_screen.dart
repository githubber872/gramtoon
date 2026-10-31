import 'package:flutter/material.dart';

import '../models/book.dart';
import '../widgets/book_detail_body.dart';

/// Receives the tapped book through its constructor.
class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book details')),
      body: BookDetailBody(book: book),
    );
  }
}
