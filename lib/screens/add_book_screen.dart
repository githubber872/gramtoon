import 'package:flutter/material.dart';

import '../models/book.dart';

/// Form screen: three TextFields, each with its own TextEditingController.
/// Pops with the new Book, or with nothing if the user goes back.
class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
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

    if (title.isEmpty || category.isEmpty || priceText.isEmpty) {
      _showMessage('Please fill in every field');
      return;
    }

    final price = int.tryParse(priceText);
    if (price == null || price <= 0) {
      _showMessage('Price must be a number greater than 0');
      return;
    }

    Navigator.pop(
      context,
      Book(title: title, category: category, price: price),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add book')),
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
          const SizedBox(height: 24),
          FilledButton(onPressed: _save, child: const Text('Save')),
        ],
      ),
    );
  }
}
