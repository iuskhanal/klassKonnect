// ...existing code...
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/signin_screen.dart';//here is the error
import '../../main.dart' show ThemeProvider, AuthService;

class ProfileScreen extends StatefulWidget {
  final String userName;
  const ProfileScreen({super.key, required this.userName});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map<String, String> userData;

  @override
  void initState() {
    super.initState();
    userData = _getUserData();
  }

  Map<String, String> _getUserData() {
    // Try to find the user in mock database
    try {
      return AuthService.allUsers.values.firstWhere(
        (u) => u['name'] == widget.userName,
      );
    } catch (_) {
      return {
        'name': widget.userName,
        'email': 'unknown@example.com',
        'role': 'N/A',
      };
    }
  }

  void _openEditDialog() async {
    final updated = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => _EditProfileDialog(initialData: userData),
    );

    if (updated != null) {
      setState(() {
        userData = updated;
      });

      // Update mock AuthService if email key exists
      try {
        final key = AuthService.allUsers.keys.firstWhere(
          (k) => AuthService.allUsers[k]?['email'] == userData['email'],
          orElse: () => '',
        );
        if (key.isNotEmpty) {
          AuthService.allUsers[key] = userData;
        }
      } catch (_) {
        // ignore if AuthService structure differs in this project
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final isDark = themeProv.isDark;

    final avatarChar = (userData['name'] != null && userData['name']!.isNotEmpty)
        ? userData['name']![0].toUpperCase()
        : '?';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode_outlined),
            tooltip: isDark ? 'Switch to light' : 'Switch to dark',
            onPressed: themeProv.toggle,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                avatarChar,
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              userData['name'] ?? 'Unknown User',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              userData['email'] ?? 'No email',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(
                userData['role'] ?? 'Role not set',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              backgroundColor:
                  Theme.of(context).colorScheme.primaryContainer.withOpacity(0.2),
            ),

            const SizedBox(height: 30),
            const Divider(),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Account Details",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 12),

            _buildDetailTile(Icons.person, "Full Name", userData['name']),
            _buildDetailTile(Icons.email, "Email Address", userData['email']),
            _buildDetailTile(Icons.badge, "Role", userData['role']),
            _buildDetailTile(Icons.calendar_today, "Member Since", "Oct 2025"),

            const SizedBox(height: 40),
            ElevatedButton.icon(
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
              onPressed: _openEditDialog,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(IconData icon, String title, String? value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(value ?? 'Not available'),
      ),
    );
  }
}

/// ---------------------------
/// Edit Profile Dialog Widget
/// ---------------------------
class _EditProfileDialog extends StatefulWidget {
  final Map<String, String> initialData;
  const _EditProfileDialog({Key? key, required this.initialData}) : super(key: key);

  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  late TextEditingController nameCtrl;
  late TextEditingController emailCtrl;
  late TextEditingController roleCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: widget.initialData['name']);
    emailCtrl = TextEditingController(text: widget.initialData['email']);
    roleCtrl = TextEditingController(text: widget.initialData['role']);
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    roleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit Profile"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: "Full Name"),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: roleCtrl,
              decoration: const InputDecoration(labelText: "Role"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop({
              'name': nameCtrl.text.trim(),
              'email': emailCtrl.text.trim(),
              'role': roleCtrl.text.trim(),
            });
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
