import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiitd_mentorship/app/bloc/auth/auth_bloc.dart';
import 'package:iiitd_mentorship/app/views/screens/auth/login.dart';
import 'package:iiitd_mentorship/app/views/screens/auth/onboarding.dart';
import 'package:iiitd_mentorship/app/views/screens/auth/signup.dart';
import 'package:iiitd_mentorship/app/views/screens/chat/chat.dart';
import 'package:iiitd_mentorship/app/views/screens/chat/my_chat.dart';
import 'package:iiitd_mentorship/app/views/screens/driver.dart';
import 'package:iiitd_mentorship/app/views/screens/home/home.dart';
import 'package:iiitd_mentorship/app/views/screens/profile/profile.dart';
import 'package:iiitd_mentorship/app/views/screens/schedule/schedule.dart';

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
            primaryColor: Colors.deepPurple,
            primarySwatch: Colors.deepPurple,
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
            ),
            appBarTheme: AppBarTheme.of(context).copyWith(
              backgroundColor: Colors.white,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarColor: Colors.white,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const OnBoardsScreen(),
          routes: <String, WidgetBuilder>{
            '/driver': (BuildContext context) => const DriverPage(),
            '/home': (BuildContext context) => const MyHomePage(title: 'Stamp'),
            '/profile': (BuildContext context) => const ProfileScreen(),
            '/settings': (BuildContext context) =>
                const MyHomePage(title: 'Settings'),
            '/notifications': (BuildContext context) =>
                const MyHomePage(title: 'Notifications'),
            'onboarding': (BuildContext context) => const OnBoardsScreen(),
            '/login': (BuildContext context) => const LoginScreen(),
            '/signup': (BuildContext context) => const SignUpScreen(),
            '/chat': (BuildContext context) =>
                const ChatScreen(title: "Welcome to Chat"),
            '/chat/mychat': (BuildContext context) =>
                const MyChats(title: "MyFriend"),
            '/home/schedule': (BuildContext context) =>
                const MySchedulesScreen(title: 'Schedule'),
          },
        ));
  }
}
