import 'package:flutter/material.dart';

class ResourceDetailScreen extends StatelessWidget {
  final Map<String, String> resource;
  const ResourceDetailScreen({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(resource['title']!)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              resource['title']!,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Type: ${resource['type']}'),
            const SizedBox(height: 20),
            Container(
              height: 150,
              color: Colors.blue[50],
              alignment: Alignment.center,
              child: const Text('Preview Placeholder',
                  style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 45)),
              icon: const Icon(Icons.open_in_new),
              label: const Text('View Resource'),
            ),
          ],
        ),
      ),
    );
  }
}
