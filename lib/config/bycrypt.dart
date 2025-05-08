import 'package:bcrypt/bcrypt.dart';

String hashPassword(String password) {
  return BCrypt.hashpw(password, BCrypt.gensalt());
}

bool verifyPassword(String input, String hashed) {
  return BCrypt.checkpw(input, hashed);
}