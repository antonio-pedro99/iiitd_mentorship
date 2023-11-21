import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiitd_mentorship/app/bloc/auth/auth_bloc.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_button.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_textbox.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();

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
                      height: MediaQuery.of(context).size.height * 0.2,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const Text(
                  'Phone verification',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                CustomTextBox(
                  controller: phoneController,
                  validationMessage: 'Please enter your email',
                  hintText: 'Phone(+91 XXXXXXXXXX)',
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
                        // BlocProvider.of<AuthBloc>(context).add(
                        //   AuthPhoneSignIn(
                        //       phoneNumber: "+91${phoneController.text}"),
                        // );
                        
                        Navigator.pushNamed(context, "/otpscreen");
                      }
                    },
                    child: const Text('Send OTP'),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
