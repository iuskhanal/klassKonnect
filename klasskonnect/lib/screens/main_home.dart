import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/auth/signin_screen.dart'; // for logout redirect
import 'home/home_screen.dart';
import 'home/lectures_screen.dart';
import 'home/post_creation_screen.dart';
import 'home/post_screen.dart';
import 'home/profile_screen.dart';
import '../main.dart';

class MainHome extends StatefulWidget {
  final String userName;
  const MainHome({super.key, required this.userName});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int _selectedIndex = 0;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(userName: widget.userName),
      const LecturesScreen(),
      const PostScreen(),
      ProfileScreen(userName: widget.userName),
    ];
  }

  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }

  void _openCreatePost() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const PostCreationScreen()));
  }

  void _logout() {
    // For local mock, simply return to sign in screen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SigninScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final isDark = themeProv.isDark;

    bool showFab = _selectedIndex == 0 || _selectedIndex == 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('KlassKonnect - ${widget.userName}'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode_outlined),
            onPressed: () => themeProv.toogle(),
            tooltip: isDark ? 'Switch to light' : 'Switch to dark',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab
          ? FloatingActionButton(
              onPressed: _openCreatePost,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTap,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Lectures'),
            BottomNavigationBarItem(icon: Icon(Icons.article), label: 'Posts'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
