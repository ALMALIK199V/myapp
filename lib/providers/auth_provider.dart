import 'package:flutter/foundation.dart';
import 'package:techfix_app/models/user_model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // تسجيل الدخول
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _error = null;

    try {
      await Future.delayed(const Duration(seconds: 2));
      
      if (email == "test@test.com" && password == "123456") {
        _user = UserModel(
          id: 'user123',
          name: 'محمد أحمد',
          email: email,
          phone: '+971501234567',
          role: UserRole.customer,
          joinedAt: DateTime.now(),
        );
        _setLoading(false);
        return true;
      } else {
        _error = 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _error = 'حدث خطأ أثناء تسجيل الدخول';
      _setLoading(false);
      return false;
    }
  }

  // تسجيل مستخدم جديد
  Future<bool> register(UserModel newUser, String password) async {
    _setLoading(true);
    _error = null;

    try {
      await Future.delayed(const Duration(seconds: 2));
      
      // محاكاة عملية التسجيل
      if (password.length < 6) {
        _error = 'كلمة المرور يجب أن تكون至少 6 أحرف';
        _setLoading(false);
        return false;
      }
      
      _user = newUser;
      _setLoading(false);
      return true;
    } catch (e) {
      _error = 'حدث خطأ أثناء إنشاء الحساب';
      _setLoading(false);
      return false;
    }
  }

  // تسجيل الخروج
  Future<void> logout() async {
    _user = null;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}