abstract class UserRepository{
  Future<bool> authenticate(String username, String password);
  Future<void> logout();
  Future<bool> isLoggedIn();
}