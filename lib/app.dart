import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiitd_mentorship/app/bloc/auth/auth_bloc.dart';
import 'package:iiitd_mentorship/app/views/screens/auth/login.dart';
import 'package:iiitd_mentorship/app/views/screens/auth/onboarding.dart';
import 'package:iiitd_mentorship/app/views/screens/auth/otp_screen.dart';
import 'package:iiitd_mentorship/app/views/screens/auth/phone_auth.dart';
import 'package:iiitd_mentorship/app/views/screens/auth/signup.dart';
import 'package:iiitd_mentorship/app/views/screens/auth/user_detail.dart';
import 'package:iiitd_mentorship/app/views/screens/chat/chat.dart';
import 'package:iiitd_mentorship/app/views/screens/driver.dart';
import 'package:iiitd_mentorship/app/views/screens/home/home.dart';
import 'package:iiitd_mentorship/app/views/screens/profile/profile.dart';
import 'package:iiitd_mentorship/app/views/screens/schedule/schedule.dart';
import 'package:iiitd_mentorship/theme.dart';

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
          theme: AppTheme.lightTheme(context),
          debugShowCheckedModeBanner: false,
          home: const OnBoardsScreen(),
          routes: <String, WidgetBuilder>{
            '/driver': (BuildContext context) => const DriverPage(),
            '/home': (BuildContext context) => const MyHomePage(),
            '/profile': (BuildContext context) => const ProfileScreen(),
            '/settings': (BuildContext context) => const MyHomePage(),
            '/notifications': (BuildContext context) => const MyHomePage(),
            'onboarding': (BuildContext context) => const OnBoardsScreen(),
            '/login': (BuildContext context) => const LoginScreen(),
            '/signup': (BuildContext context) => const SignUpScreen(),
            '/phoneauth': (BuildContext context) => const PhoneAuthScreen(),
            '/otpscreen': (BuildContext context) => const OTPScreen(),
            '/userdetails': (BuildContext context) => const UserDetailsScreen(),
            '/chat': (BuildContext context) =>
                const ChatScreen(title: "Welcome to Chat"),
            '/home/schedule': (BuildContext context) =>
                const MySchedulesScreen(title: 'Schedule'),
          },
        ));
  }
}
