import 'package:articles_app/presentation/screen/articles_list_screen.dart';
import 'package:articles_app/repository/user_repository.dart';
import 'package:articles_app/repository/user_repository_implementation.dart';
import 'package:flutter/material.dart';
import 'presentation/screen/registration_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  UserRepository repo = UserRepositoryImplementation();
  var isLoggedIn = await repo.isLoggedIn();
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: !widget.isLoggedIn ? RegistrationScreen() : ArticlesListScreen(),
    );
  }
}
