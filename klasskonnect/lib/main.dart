import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/signin_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/forget_password_screen.dart';
import 'screens/main_home.dart';
import 'screens/home/post_screen.dart';

void main() {
  runApp(const KlassKonnectApp());
}

/// ----------------------
/// THEME PROVIDER
/// ----------------------
class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.light;
  ThemeMode get mode => _mode;

  bool get isDark => _mode == ThemeMode.dark;

  void toggle() {
    _mode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void setDark(bool dark) {
    _mode = dark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

/// ----------------------
/// MOCK AUTH SERVICE
/// ----------------------
class AuthService {
  // email -> {name, email, password, role}
  static final Map<String, Map<String, String>> _users = {};

  static bool register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) {
    final key = email.toLowerCase();
    if (_users.containsKey(key)) return false;

    _users[key] = {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    };
    return true;
  }

  static Map<String, String>? login({
    required String email,
    required String password,
  }) {
    final key = email.toLowerCase();
    final user = _users[key];
    if (user == null) return null;

    if (user['password'] == password) {
      return {
        'name': user['name'] ?? '',
        'email': user['email'] ?? '',
        'role': user['role'] ?? '',
      };
    }
    return null;
  }

  static Map<String, Map <String, String>> allUsers = {
    "user1" : {
      "name" : "Test User",
      "email" : "test@example.com",
      "role" : "Student",
    }
  };
}

/// ----------------------
/// ROOT APP
/// ----------------------
class KlassKonnectApp extends StatelessWidget {
  const KlassKonnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'KlassKonnect',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.mode,
            theme: ThemeData(
              brightness: Brightness.light,
              colorSchemeSeed: Colors.blue,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              colorSchemeSeed: Colors.blue,
              useMaterial3: true,
            ),
            // initial screen
            initialRoute: '/signin',

            routes: {
              '/signin': (_) => const SignInScreen(),
              '/signup': (_) => const SignUpScreen(),
              '/forgot': (_) => const ForgotPasswordScreen(),
              '/main_home': (_) => const MainHome(userName: 'User'),
              '/posts' : (_) => const  PostsScreen(),
            },
          );
        },
      ),
    );
  }
}
