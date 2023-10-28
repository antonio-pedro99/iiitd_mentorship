import 'package:flutter/material.dart';

class OnBoardsScreen extends StatelessWidget {
  const OnBoardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, elevation: 0, actions: [
          TextButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, "/login", (route) => false),
            child: const Text(
              'Login',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ]),
        body: Padding(
            padding: const EdgeInsets.all(18),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: PageView.builder(
                  itemCount: _OnBoardMessage.messages().length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            _OnBoardMessage.messages()[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          _OnBoardMessage.messages()[index].title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          _OnBoardMessage.messages()[index].message,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 30,
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
                      'SignUp',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ])));
  }
}

class _OnBoardMessage {
  final String title;
  final String message;
  final String image;

  const _OnBoardMessage(
      {required this.title, required this.message, required this.image});

  static List<_OnBoardMessage> messages() {
    return const [
      _OnBoardMessage(
          title: 'Welcome to the app',
          message: 'This is a message',
          image: 'assets/on_1.png'),
      _OnBoardMessage(
          title: 'Welcome to the app',
          message: 'This is a message',
          image: 'assets/on_2.png'),
      _OnBoardMessage(
          title: 'Welcome to the app',
          message: 'This is a message',
          image: 'assets/on_3.png'),
    ];
  }
}
