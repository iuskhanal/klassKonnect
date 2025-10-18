import 'package:flutter/material.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});

  @override
  State<PostCreationScreen> createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  final _titleCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();

  void _publish() {
    if (_titleCtrl.text.trim().isEmpty || _contentCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fill title and content')));
      return;
    }
    // mock publish
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post published')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _titleCtrl, decoration: const InputDecoration(labelText: 'Post Title', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            Expanded(child: TextField(controller: _contentCtrl, maxLines: null, expands: true, decoration: const InputDecoration(labelText: 'Content', border: OutlineInputBorder()))),
            const SizedBox(height: 12),
            ElevatedButton.icon(onPressed: _publish, icon: const Icon(Icons.send), label: const Text('Publish'), style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48))),
          ],
        ),
      ),
    );
  }
}
