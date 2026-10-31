import 'package:flutter/material.dart';

import '../data/book_data.dart';
import '../models/book.dart';
import '../widgets/book_cover.dart';
import 'add_book_screen.dart';
import 'book_detail_screen.dart';

class PopularBooksScreen extends StatefulWidget {
  const PopularBooksScreen({super.key});

  @override
  State<PopularBooksScreen> createState() => _PopularBooksScreenState();
}

class _PopularBooksScreenState extends State<PopularBooksScreen> {
  Future<void> _openDetail(Book book) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
    );
    // The favorite may have changed on the detail screen, so redraw.
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _addBook() async {
    final newBook = await Navigator.push<Book>(
      context,
      MaterialPageRoute(builder: (context) => const AddBookScreen()),
    );
    if (!mounted) return;
    if (newBook != null) {
      setState(() {
        popularBooks.add(newBook);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('"${newBook.title}" was added')),
      );
    }
  }

  void _toggleFavorite(Book book) {
    setState(() {
      book.isFavorite = !book.isFavorite;
    });
  }

  Widget _favoriteButton(Book book) {
    return IconButton(
      icon: Icon(book.isFavorite ? Icons.favorite : Icons.favorite_border),
      onPressed: () => _toggleFavorite(book),
    );
  }

  /// Rank #1 gets a big card, like in the design.
  Widget _buildFeatured(Book book) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () => _openDetail(book),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookCover(book: book, width: 110, height: 160),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#1 · ${book.category}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      book.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(formatRupiah(book.finalPrice)),
                    const SizedBox(height: 8),
                    Text(
                      book.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Read more...',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
              _favoriteButton(book),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(Book book, int index) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '${index + 1}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          BookCover(book: book, width: 40, height: 56),
        ],
      ),
      title: Text(book.title),
      subtitle: Text('${book.category}\n${formatRupiah(book.finalPrice)}'),
      isThreeLine: true,
      trailing: _favoriteButton(book),
      onTap: () => _openDetail(book),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular books')),
      body: ListView.builder(
        itemCount: popularBooks.length,
        itemBuilder: (context, index) {
          final book = popularBooks[index];
          if (index == 0) {
            return _buildFeatured(book);
          } else {
            return _buildRow(book, index);
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addBook,
        icon: const Icon(Icons.add),
        label: const Text('Add book'),
      ),
    );
  }
}
