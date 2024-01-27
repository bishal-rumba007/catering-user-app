




abstract class AuthRepository{
  Future<String> login({required String email, required String password});
  Future<String> register({required String name, required String email, required String phone, required String password});
  Future<String> logOut();
}