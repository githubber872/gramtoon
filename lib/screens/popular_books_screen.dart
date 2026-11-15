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
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _openDetail(Book book) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookDetailScreen(book: book)),
    );
    if (!mounted) return;
    setState(() {});
  }

  // CREATE
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
      _showMessage('"${newBook.title}" was added');
    }
  }

  // UPDATE
  Future<void> _editBook(int index) async {
    final updatedBook = await Navigator.push<Book>(
      context,
      MaterialPageRoute(
        builder: (context) => AddBookScreen(book: popularBooks[index]),
      ),
    );
    if (!mounted) return;
    if (updatedBook != null) {
      setState(() {
        popularBooks[index] = updatedBook;
      });
      _showMessage('"${updatedBook.title}" was updated');
    }
  }

  // DELETE
  Future<void> _deleteBook(int index) async {
    final book = popularBooks[index];
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete book'),
        content: Text('Delete "${book.title}" from the list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (confirmed == true) {
      setState(() {
        popularBooks.removeAt(index);
      });
      _showMessage('"${book.title}" was deleted');
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

  Widget _actionButtons(int index) {
    final compact = TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      visualDensity: VisualDensity.compact,
    );
    return Wrap(
      children: [
        TextButton.icon(
          style: compact,
          onPressed: () => _editBook(index),
          icon: const Icon(Icons.edit, size: 18),
          label: const Text('Edit'),
        ),
        TextButton.icon(
          style: compact,
          onPressed: () => _deleteBook(index),
          icon: const Icon(Icons.delete, size: 18),
          label: const Text('Delete'),
        ),
      ],
    );
  }

  Widget _buildFeatured(Book book, int index) {
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
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    _actionButtons(index),
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        onTap: () => _openDetail(book),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 28,
                child: Text(
                  '${index + 1}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              BookCover(book: book, width: 56, height: 80),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      book.category,
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    Text(formatRupiah(book.finalPrice)),
                    _actionButtons(index),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular books')),
      body: popularBooks.isEmpty
          ? const Center(child: Text('No books yet. Tap "Add book" to start.'))
          : ListView.builder(
              itemCount: popularBooks.length,
              itemBuilder: (context, index) {
                final book = popularBooks[index];
                if (index == 0) {
                  return _buildFeatured(book, index);
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