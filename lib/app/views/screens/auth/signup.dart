import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiitd_mentorship/app/bloc/auth/auth_bloc.dart';
import 'package:iiitd_mentorship/app/data/model/user_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                SnackBar(
                  content: Text((state as Authenticated).response.message!),
                );
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
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Sign Up to your account',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: mailController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Confirm Password',
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
                        BlocProvider.of<AuthBloc>(context).add(AuthSignUp(
                          user: UserAuthSignUp(
                            name: "Antonio Pedro",
                            email: mailController.text,
                            password: passwordController.text,
                          ),
                        ));
                      }
                    },
                    child: const Text('Sign Up'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context, "/login", (route) => false),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
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
