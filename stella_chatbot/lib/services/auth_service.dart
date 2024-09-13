import 'package:stella_chatbot/models/user.dart';

class AuthService {
  Future<User?> signIn(String email, String password) async {
    // TODO: Implement actual authentication logic
    await Future.delayed(Duration(seconds: 1)); // Simulating network request
    return User(id: '1', name: 'John Doe', age: 35, children: ['Alice', 'Bob']);
  }
}