import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iiitd_mentorship/app/bloc/auth/auth_bloc.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_button.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController _controllerOne = TextEditingController();
  final TextEditingController _controllerTwo = TextEditingController();
  final TextEditingController _controllerThree = TextEditingController();
  final TextEditingController _controllerFour = TextEditingController();

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
                  'Enter the OTP',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOTPField(_controllerOne),
                      const SizedBox(
                        width: 10,
                      ),
                      _buildOTPField(_controllerTwo),
                      const SizedBox(
                        width: 10,
                      ),
                      _buildOTPField(_controllerThree),
                      const SizedBox(
                        width: 10,
                      ),
                      _buildOTPField(_controllerFour),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    rounded: true,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {}
                    },
                    child: const Text('Verify OTP'),
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

  Widget _buildOTPField(TextEditingController controller) {
    return SizedBox(
      width: 50,
      height: 70,
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.center,
        canRequestFocus: true,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24),
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontWeight: FontWeight.w200,
          ),
          hintMaxLines: 1,
          counterText: "",
        ),
        maxLength: 1,
        showCursor: false,
      ),
    );
  }
}
