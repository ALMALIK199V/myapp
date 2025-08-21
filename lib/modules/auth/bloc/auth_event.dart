part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {
  const AuthEvent();
}

// حدث تسجيل الدخول
class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;

  const LoginEvent({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  @override
  List<Object> get props => [email, password, rememberMe];
}

// حدث تسجيل مستخدم جديد
class RegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;

  const RegisterEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [name, email, phone, password, confirmPassword];
}

// حدث تسجيل الخروج
class LogoutEvent extends AuthEvent {
  const LogoutEvent();

  @override
  List<Object> get props => [];
}

// حدث نسيان كلمة المرور
class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

// حدث إعادة تعيين كلمة المرور
class ResetPasswordEvent extends AuthEvent {
  final String token;
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordEvent({
    required this.token,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [token, newPassword, confirmPassword];
}

// حدث التحقق من حالة المصادقة
class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();

  @override
  List<Object> get props => [];
}

// حدث تحديث بيانات المستخدم
class UpdateUserProfileEvent extends AuthEvent {
  final String name;
  final String phone;
  final String? profileImage;

  const UpdateUserProfileEvent({
    required this.name,
    required this.phone,
    this.profileImage,
  });

  @override
  List<Object> get props => [name, phone];
}

// حدث تغيير كلمة المرور
class ChangePasswordEvent extends AuthEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [currentPassword, newPassword, confirmPassword];
}

// حدث تسجيل الدخول الاجتماعي
class SocialLoginEvent extends AuthEvent {
  final SocialLoginType type;
  final Map<String, dynamic>? socialData;

  const SocialLoginEvent({
    required this.type,
    this.socialData,
  });

  @override
  List<Object> get props => [type];
}

// أنواع التسجيل الاجتماعي
enum SocialLoginType {
  google,
  apple,
  facebook,
}