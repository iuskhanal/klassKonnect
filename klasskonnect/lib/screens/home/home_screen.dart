import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.brightness == Brightness.light ? Colors.grey[100] : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, ${widget.userName} 👋',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Find your classes, lectures, and updates below',
                  style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 16),

              TextField(
                controller: _searchCtrl,
                decoration: InputDecoration(
                  hintText: 'Search classes or lectures...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
                onChanged: (q) {
                  // TODO: implement search filter
                },
              ),
              const SizedBox(height: 20),

              _sectionTitle('Upcoming Lectures', theme),
              _lectureCard('Intro to Flutter', 'Oct 20, 2025 - 10:00 AM', 'Mr. Sharma'),
              _lectureCard('Advanced Dart', 'Oct 22, 2025 - 2:00 PM', 'Ms. Rai'),
              const SizedBox(height: 20),

              _sectionTitle('Recent Posts', theme),
              _postCard('Exam schedule released', 'Admin', '2 hours ago'),
              _postCard('New lecture materials added', 'Prof. Adhikari', 'Yesterday'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, ThemeData theme) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
      );

  Widget _lectureCard(String title, String date, String by) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: .08), blurRadius: 6)]),
        child: Row(
          children: [
            const Icon(Icons.class_, size: 40, color: Colors.blueAccent),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 6), Text(date), Text('By $by', style: const TextStyle(color: Colors.grey))])),
          ],
        ),
      );

  Widget _postCard(String title, String author, String time) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.grey.withValues(alpha: 0.08), blurRadius: 6)]),
        child: Row(
          children: [
            const Icon(Icons.article_outlined, size: 36, color: Colors.green),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w600)), const SizedBox(height: 6), Text('$author • $time', style: const TextStyle(color: Colors.grey))])),
          ],
        ),
      );
}
