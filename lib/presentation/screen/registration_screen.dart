import 'package:articles_app/presentation/widget/login_widget.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 800) {
        return Scaffold(
          body: Row(
            children: [
              Flexible(
                  flex: 1,
                  child: Center(
                    child: SizedBox(
                      height: 500,
                      width: 300,
                      child: Card(
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LoginWidget(usernameController: usernameController, passwordController: passwordController),
                        ),
                      ),
                    ),
                  )),
              Flexible(
                  flex: 1,
                  child: Container(
                    height: double.infinity,
                    color: Colors.blue,
                  ))
            ],
          ),
        );
      }
      return Scaffold(
        body: LoginWidget(usernameController: usernameController, passwordController: passwordController),
      );
    });
  }
}
