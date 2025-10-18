import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  void _send() {
    if (!_formKey.currentState!.validate()) return;
    // Mock behaviour
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Recovery link sent to ${_emailCtrl.text.trim()}')),
    );
    // Optionally go back
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final isDark = themeProv.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Recovery'),
        actions: [
          IconButton(
            tooltip: isDark ? 'Switch to light' : 'Switch to dark',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode_outlined),
            onPressed: () => themeProv.toggle(),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Text(
                "Enter the Email address associated with your KlassKonnect account\nWe’ll send you a link to reset your password",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Enter email';
                    if (!_emailRegex.hasMatch(v.trim())) return 'Enter valid email';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _send,
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                child: const Text('Send Recovery Link'),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  // open support - mock
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contacting support...')));
                },
                child: const Text('Need more help? Contact Support'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
