import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import '../core/database/app_database.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String? _currentUser;

  bool get isLoggedIn => _isLoggedIn;
  String? get currentUser => _currentUser;

  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Intenta autenticar. Retorna true si éxito.
  bool login(String username, String password) {
    final box = AppDatabase.authBox;
    final stored = box.get(username);
    if (stored == null) return false;

    final storedHash = stored['passwordHash'] as String;
    final inputHash = hashPassword(password);

    if (storedHash == inputHash) {
      _isLoggedIn = true;
      _currentUser = username;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _isLoggedIn = false;
    _currentUser = null;
    notifyListeners();
  }

  /// Cambia la contraseña del admin
  bool changePassword(String username, String currentPass, String newPass) {
    final box = AppDatabase.authBox;
    final stored = box.get(username);
    if (stored == null) return false;
    final storedHash = stored['passwordHash'] as String;
    if (storedHash != hashPassword(currentPass)) return false;
    box.put(username, {
      ...Map<String, dynamic>.from(stored as Map),
      'passwordHash': hashPassword(newPass),
    });
    return true;
  }
}
