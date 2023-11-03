import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiitd_mentorship/app/bloc/auth/auth_bloc.dart';
import 'package:iiitd_mentorship/app/views/screens/auth/login.dart';
import 'package:iiitd_mentorship/app/views/screens/auth/onboarding.dart';
import 'package:iiitd_mentorship/app/views/screens/auth/signup.dart';
import 'package:iiitd_mentorship/app/views/screens/home.dart';
import 'package:iiitd_mentorship/app/views/screens/profile/profile.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {        
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          )
        ],
        child: MaterialApp(
          title: 'Stamp',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const OnBoardsScreen(),
          routes: <String, WidgetBuilder>{
            '/home': (BuildContext context) => const MyHomePage(title: 'Stamp'),
            '/profile': (BuildContext context) =>
                const ProfileScreen(),
            '/settings': (BuildContext context) =>
                const MyHomePage(title: 'Settings'),
            '/notifications': (BuildContext context) =>
                const MyHomePage(title: 'Notifications'),
            'onboarding': (BuildContext context) => const OnBoardsScreen(),
            '/login': (BuildContext context) => const LoginScreen(),
            '/signup': (BuildContext context) => const SignUpScreen(),
          },
        ));
  }
}
