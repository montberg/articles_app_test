import 'package:flutter/material.dart';

import '../../repository/user_repository.dart';
import '../../repository/user_repository_implementation.dart';
import '../screen/articles_list_screen.dart';

class LoginWidget extends StatefulWidget {

  final TextEditingController usernameController;
  final TextEditingController passwordController;

  const LoginWidget({super.key, required this.usernameController, required this.passwordController});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final UserRepository userRepository = UserRepositoryImplementation();

  bool _obscurePassword = true;
  late bool _isActive;

  @override
  void initState() {
    _isActive = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Вход", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40),),
              const SizedBox(height: 50),
              TextFormField(
                controller: widget.usernameController,
                decoration:
                    const InputDecoration(labelText: 'Имя пользователя'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: widget.passwordController,
                decoration: InputDecoration(
                    labelText: 'Пароль',
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    )),
                obscureText: _obscurePassword,
              ),
              const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _isActive ? ()=>_login(context, widget.usernameController, widget.passwordController) : null,
                      child: const Text('Войти'),
                    )
            ],
          ),
        ),
      ),
    );
  }

  void _login(
      BuildContext context,
      TextEditingController usernameController,
      TextEditingController passwordController) {
    String username = usernameController.text;
    String password = passwordController.text;
    setState(() {
      _isActive = !_isActive;
    });
    userRepository.authenticate(username, password).then((isAuthenticated) {
      if (isAuthenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ArticlesListScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Неверное имя пользователя или пароль'),
        ));
      }
      setState(() {
        _isActive = !_isActive;
      });
    });
  }
}
