import 'package:flutter/material.dart';
import 'package:iiitd_mentorship/app/views/widgets/custom_button.dart';

class OnBoardsScreen extends StatelessWidget {
  const OnBoardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                SizedBox(
                  child: Image.asset(
                    "assets/on_1.png",
                    height: MediaQuery.of(context).size.height * 0.3,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  'Welcome to the app',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Stuck with a problem? Need a mentor? We got you covered. Find a mentor from IIITD to help you out.',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w200),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    rounded: true,
                    onPressed: () => Navigator.pushNamed(context, "/signup"),
                    child: const Text("Create account")),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    rounded: true,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: const Text("Login")),
                const SizedBox(height: 10),
                const Center(child: Text("Or connect with")),
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
                const SizedBox(height: 10),
                const Text(
                    'By continuing you agree to our Terms of Service and Privacy Policy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ))
              ],
            )));
  }
}
