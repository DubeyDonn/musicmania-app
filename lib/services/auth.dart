import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class Auth {
  Future<bool> isLoggedIn() async {
    String? jwtToken = await storage.read(key: 'jwt');
    return jwtToken != null;
  }

  Future<void> logout() async {
    await storage.delete(key: 'jwt');
  }

  Future<void> setToken(String token) async {
    await storage.write(key: 'jwt', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'jwt');
  }
}
