import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/views/screens/auth/onboarding.dart';
import 'package:iiitd_mentorship/app/views/screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stamp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Stamp'),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const MyHomePage(title: 'Stamp'),
        '/profile': (BuildContext context) =>
            const MyHomePage(title: 'My Profile'),
        '/settings': (BuildContext context) =>
            const MyHomePage(title: 'Settings'),
        '/notifications': (BuildContext context) =>
            const MyHomePage(title: 'Notifications'),
        'onboarding': (BuildContext context) =>
            const OnBoardsScreen(),
      },
    );
  }
} 
