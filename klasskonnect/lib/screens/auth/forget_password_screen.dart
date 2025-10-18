import 'package:flutter/material.dart';
import 'package:klasskonnect/main.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _emailCtrl = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  void _send(){
    if (!_fromKey.currentState!.validate()) return ;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Recovary Link sent to ${_emailCtrl.text.trim()}'))
    );
  }


  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final isDark = themeProv.isDark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Recovary'),
        actions: [
          IconButton(
            tooltip: isDark ? "Switch to light mode" : "Swich to Dark mode",
             icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode_outlined),
            onPressed: () => themeProv.toogle(),
            )
        ],
      ),
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 32,),
              Form(
                key: _fromKey,
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

              const SizedBox(height: 30,),

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
