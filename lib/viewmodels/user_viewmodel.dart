
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/services/user_service.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService = UserService();
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> loadUser() async {
    _isLoading = true;
    notifyListeners();

    final currentUser = auth.FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _user = await _userService.getUser(currentUser.uid);
      if (_user == null) {
        _user = User(uid: currentUser.uid, email: currentUser.email);
        await _userService.createUser(_user!);
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    await _userService.updateUser(user);
    _user = user;
    notifyListeners();
  }
}
