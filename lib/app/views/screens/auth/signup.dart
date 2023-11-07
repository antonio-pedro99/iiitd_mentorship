import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiitd_mentorship/app/bloc/auth/auth_bloc.dart';
import 'package:iiitd_mentorship/app/data/model/user_auth.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_button.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isMentor = false;
  bool readterms = false;
  bool readpolicy = false;

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Create account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextBox(
                  controller: nameController,
                  hintText: 'Name',
                  backgroundColor: Colors.grey[100],
                  validationMessage: 'Please enter your name',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextBox(
                  controller: mailController,
                  hintText: 'Email',
                  backgroundColor: Colors.grey[100],
                  validationMessage: 'Please enter your email',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextBox(
                  controller: passwordController,
                  obscureText: true,
                  hintText: 'Password',
                  backgroundColor: Colors.grey[100],
                  validationMessage: 'Please enter your password',
                ),
                const SizedBox(
                  height: 20,
                ),
                SwitchListTile(
                  title: Text(isMentor ? 'Mentor' : 'Student'),
                  value: isMentor,
                  onChanged: (bool value) {
                    setState(() {
                      isMentor = value;
                    });
                  },
                ),

                // two checkboxes for reading policy and terms
                const SizedBox(
                  height: 15,
                ),

                Row(
                  children: [
                    Checkbox(
                        value: readterms,
                        onChanged: (v) {
                          setState(() {
                            readterms = v!;
                          });
                        }),
                    const Expanded(
                      child: Text(
                        "By marking this, I agree to these terms of use including consent to use of my personal information to serve targeted ads.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),

                Row(
                  children: [
                    Checkbox(
                        value: readpolicy,
                        onChanged: (v) {
                          setState(() {
                            readpolicy = v!;
                          });
                        }),
                    const Expanded(
                      child: Text(
                        "By marking this, I agree to this privacy policy including the use of profiling to find perfect matches for me.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),
                CustomButton(
                    rounded: true,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(AuthSignUp(
                          user: UserAuthSignUp(
                            name: nameController.text,
                            isMentor: isMentor,
                            email: mailController.text,
                            password: passwordController.text,
                          ),
                        ));
                      }
                    },
                    child: const Text("Sign Up")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
