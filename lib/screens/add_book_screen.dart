import 'package:flutter/material.dart';

import '../models/book.dart';

/// Form screen used for two jobs:
///  - CREATE: opened with no book, the fields start empty.
///  - UPDATE: opened with an existing book, the fields are pre-filled.
/// Pops with the new or edited Book, or with nothing if the user goes back.
class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key, this.book});

  /// The book to edit. Null means we are adding a new one.
  final Book? book;

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _categoryController;
  late final TextEditingController _priceController;
  late final TextEditingController _descriptionController;

  bool get _isEditing => widget.book != null;

  @override
  void initState() {
    super.initState();
    final book = widget.book;
    _titleController = TextEditingController(text: book?.title ?? '');
    _categoryController = TextEditingController(text: book?.category ?? '');
    _priceController =
        TextEditingController(text: book == null ? '' : book.price.toString());
    _descriptionController =
        TextEditingController(text: book?.description ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _save() {
    final title = _titleController.text.trim();
    final category = _categoryController.text.trim();
    final priceText = _priceController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || category.isEmpty || priceText.isEmpty) {
      _showMessage('Please fill in title, category and price');
      return;
    }

    final price = int.tryParse(priceText);
    if (price == null || price <= 0) {
      _showMessage('Price must be a number greater than 0');
      return;
    }

    final oldBook = widget.book;
    final Book result;
    if (oldBook == null) {
      // CREATE: a brand new book.
      result = Book(
        title: title,
        category: category,
        price: price,
        description: description.isEmpty ? 'No description yet.' : description,
      );
    } else {
      // UPDATE: new text from the form, everything else kept from the old book.
      result = Book(
        title: title,
        category: category,
        price: price,
        description: description.isEmpty ? 'No description yet.' : description,
        discountPercent: oldBook.discountPercent,
        coverAsset: oldBook.coverAsset,
        isFavorite: oldBook.isFavorite,
      );
    }

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Edit book' : 'Add book')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _titleController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _categoryController,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Price (Rp)',
              hintText: 'e.g. 45000',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Description (optional)',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _save,
            child: Text(_isEditing ? 'Save changes' : 'Save'),
          ),
        ],
      ),
    );
  }
}
