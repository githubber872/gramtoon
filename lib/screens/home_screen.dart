import 'package:flutter/material.dart';

import 'book_of_the_day_screen.dart';
import 'new_releases_screen.dart';
import 'popular_books_screen.dart';

/// Home screen: every other screen is reachable from here.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Gramtoon')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Find your next favorite book', style: textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(
            'Pick a section to start browsing.',
            style: textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),
          _MenuCard(
            icon: Icons.local_fire_department,
            title: 'Popular books',
            subtitle: 'The top ranked books right now',
            onTap: () => _open(context, const PopularBooksScreen()),
          ),
          _MenuCard(
            icon: Icons.new_releases,
            title: 'New releases',
            subtitle: 'Fresh arrivals on the shelf',
            onTap: () => _open(context, const NewReleasesScreen()),
          ),
          _MenuCard(
            icon: Icons.star,
            title: 'Book of the day',
            subtitle: 'Today\'s pick at a special price',
            onTap: () => _open(context, const BookOfTheDayScreen()),
          ),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
