import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiitd_mentorship/app/bloc/auth/auth_bloc.dart';
import 'package:iiitd_mentorship/app/data/model/user_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            switch (state.runtimeType) {
              case AuthLoading:
                showDialog(
                  context: context,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
                break;
              case Authenticated:
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, "/driver", (route) => false);
                break;
              case UnAuthenticated:
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text((state as UnAuthenticated).message),
                  ),
                );
                break;
              default:
            }
          },
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthLogin(
                                user: UserAuthLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              ),
                            );
                      }
                    },
                    child: const Text('Login'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, "/signup", (route) => false),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
// added this
                    TextButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, "/chat", (route) => false),
                      child: const Text(
                        'Chat',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
