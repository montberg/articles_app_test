import 'package:articles_app/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImplementation implements UserRepository{

  Map<String, String> users = {
    'admin': 'pass',
  };


  @override
  Future<bool> authenticate(String username, String password) async  {
    return Future.delayed(const Duration(seconds: 1), () async {
      if (users.containsKey(username) && users[username] == password)  {
       final SharedPreferences prefs = await SharedPreferences.getInstance();
       prefs.setBool('logged_in', true);
        return true;
      }
      return false;
    });
  }
  
  @override
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('logged_in', false);
  }
  
  @override
  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('logged_in') ?? false;
    return isLoggedIn;
  }
}
