import 'package:flutter/material.dart';
import 'package:klasskonnect/main.dart';
import 'package:klasskonnect/screens/main_home.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _fromKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String? _role;
  bool _obscure = true;

  // Email & password regexas
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final _passRegex = RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*]).{6,15}$');
  // 6-15 chars, at least 1 uppercase, 1 special char and  1 digit

  void _trySignIn() {
    if (!_fromKey.currentState!.validate()) return;

    final email = _emailCtrl.text.trim();
    final password = _passCtrl.text.trim();
    final user = AuthServices.login(email: email, password: password);

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid credentials or user not found")),
      );
      return;
    }

    final displayName = (user['name'] ?? '').isNotEmpty
        ? user['name']!
        : email.split("@").first;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MainHome(userName: displayName)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final isDark = themeProv.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
        actions: [
          IconButton(
            tooltip: isDark ? 'Switch to light' : 'Switch to dark',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode_outlined),
            onPressed: () => themeProv.toogle(),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),

          child: Column(
            children: [
              const SizedBox(height: 8),
              Text(
                'KlassKonnect',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                'Connect, Learn, Grow',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20),

              Form(
                key: _fromKey,
                child: Column(
                  children: [
                    // Email
                    TextFormField(
                      controller: _emailCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Please enter email';
                        }
                        if (!_emailRegex.hasMatch(v.trim())) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // PassWord
                    TextFormField(
                      controller: _passCtrl,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () => setState(() {
                            _obscure = !_obscure;
                          }),
                        ),
                      ),
                      validator: (v){
                        if (v == null || v.isEmpty) return 'Please Enter password';
                        if(!_passRegex.hasMatch(v)){
                          return 'Password should have : 6-15 chars, 1 upercase, 1 digits, 1 special characters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
