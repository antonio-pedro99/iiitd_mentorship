import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiitd_mentorship/app/bloc/auth/auth_bloc.dart';
import 'package:iiitd_mentorship/app/data/model/user_auth.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_button.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';

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
      appBar: AppBar(),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    child: Image.asset(
                      "assets/on_3.png",
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextBox(
                  controller: emailController,
                  validationMessage: 'Please enter your email',
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextBox(
                  controller: passwordController,
                  obscureText: true,
                  validationMessage: 'Please enter your password',
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    rounded: true,
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
                const SizedBox(height: 10),
                const Center(child: Text("Or login with")),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () {},
                      color: Colors.white,
                      minWidth: 100,
                      textColor: Colors.black,
                      padding: const EdgeInsets.all(16),
                      shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: .2)),
                      child: Image.asset(
                        "assets/google.png",
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const SizedBox(width: 10),
                    MaterialButton(
                        onPressed: () {},
                        minWidth: 100,
                        color: Colors.white,
                        textColor: Colors.black,
                        padding: const EdgeInsets.all(16),
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: .2)),
                        child: const Icon(
                          Icons.phone,
                          size: 24,
                        )),
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
