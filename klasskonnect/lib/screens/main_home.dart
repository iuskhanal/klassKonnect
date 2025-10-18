import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/auth/signin_screen.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}