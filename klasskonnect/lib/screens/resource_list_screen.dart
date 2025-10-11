import 'package:flutter/material.dart';
import 'resource_detail_screen.dart';

class ResourceListScreen extends StatefulWidget {
  const ResourceListScreen({super.key});

  @override
  State<ResourceListScreen> createState() => _ResourceListScreenState();
}

class _ResourceListScreenState extends State<ResourceListScreen> {
  String _filter = 'All';
  final List<Map<String, String>> _resources = [
    {'title': 'Math Notes', 'type': 'Document'},
    {'title': 'Physics Video', 'type': 'Video'},
    {'title': 'Chemistry Quiz', 'type': 'Quiz'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredResources = _filter == 'All'
        ? _resources
        : _resources.where((r) => r['type'] == _filter).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('KlassKonnect Resources')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: DropdownButtonFormField<String>(
              initialValue: _filter,
              decoration: const InputDecoration(labelText: 'Filter by Type'),
              items: ['All', 'Document', 'Video', 'Quiz']
                  .map((type) =>
                      DropdownMenuItem(value: type, child: Text(type)))
                  .toList(),
              onChanged: (val) => setState(() => _filter = val!),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredResources.length,
              itemBuilder: (context, index) {
                final resource = filteredResources[index];
                return ListTile(
                  title: Text(resource['title']!),
                  subtitle: Text(resource['type']!),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ResourceDetailScreen(resource: resource),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
