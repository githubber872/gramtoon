import 'package:flutter/material.dart';

import '../data/book_data.dart';
import '../widgets/book_detail_body.dart';

class BookOfTheDayScreen extends StatelessWidget {
  const BookOfTheDayScreen({super.key});

  void _showHelp(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Book of the day'),
        content: const Text(
          'Every day we pick one book and sell it at a special discounted price.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book of the day'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () => _showHelp(context),
          ),
        ],
      ),
      body: BookDetailBody(book: bookOfTheDay),
    );
  }
}
