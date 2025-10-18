import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/auth/signin_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/forget_password_screen.dart';

import 'screens/main_home.dart';

void main(){
  runApp(const KlassKonnectApp());
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;

  bool get isDark => _mode == ThemeMode.dark;

  void toogle(){
    _mode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void setDark(bool dark){
    _mode = dark ? ThemeMode.dark : ThemeMode.light ;
    notifyListeners();
  }
}

// Very small in-memory auth services for registration or login

class AuthServices{
  static final Map <String, Map <String, String>> _users = {};

  static bool register({
    required String name,
    required String email,
    required String password,
    required String role,
  }){
    final key = email.toLowerCase();
    if (_users.containsKey(key)) return false;
    _users[key] = {
      'name': name,
      'email' :email,
      'password' : password,
      'role' : role,
    };
    return true;
  }

  static Map<String, String >? login({
    required String email,
    required String password,
  }){
    final key = email.toLowerCase();
    final user = _users[key];
    if (user == null) return null;
    if(user['password']== password) {
      return{
        'name': user['name'] ?? '',
        'email': user['email'] ?? '',
        'role': user['role'] ?? '',
      };
    }
    return null;
  }
}

class KlassKonnectApp extends StatelessWidget {
  const KlassKonnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (_, themeProvider, _){
          return MaterialApp(
            title: 'KlassKonnect',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.mode,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.teal,
              useMaterial3: true,
            ),
            initialRoute: '/signin',
            routes: {
              '/signin': (ctx) => const SigninScreen(),
              '/signup': (ctx) =>const SignupScreen(),
              '/forget': (ctx) =>const ForgetPasswordScreen(),
              '/main_home': (ctx) =>const MainHome(userName :"User"),

            },
          );
        },
      ),
    );
  }
}
