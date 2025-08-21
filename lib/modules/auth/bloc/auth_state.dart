part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

// الحالة الأولية
class AuthInitial extends AuthState {
  const AuthInitial();
}

// حالة التحميل
class AuthLoading extends AuthState {
  final String? loadingMessage;

  const AuthLoading({this.loadingMessage});

  @override
  List<Object?> get props => [loadingMessage];
}

// حالة تسجيل الدخول الناجح
class LoginSuccess extends AuthState {
  final UserModel user;

  const LoginSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

// حالة التسجيل الناجح
class RegisterSuccess extends AuthState {
  final UserModel user;

  const RegisterSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

// حالة نسيان كلمة المرور الناجحة
class ForgotPasswordSuccess extends AuthState {
  final String message;

  const ForgotPasswordSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

// حالة إعادة تعيين كلمة المرور الناجحة
class ResetPasswordSuccess extends AuthState {
  final String message;

  const ResetPasswordSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

// حالة تحديث الملف الشخصي الناجح
class UpdateProfileSuccess extends AuthState {
  final UserModel user;

  const UpdateProfileSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

// حالة تغيير كلمة المرور الناجحة
class ChangePasswordSuccess extends AuthState {
  final String message;

  const ChangePasswordSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

// حالة المصادقة
class Authenticated extends AuthState {
  final UserModel user;

  const Authenticated({required this.user});

  @override
  List<Object> get props => [user];
}

// حالة عدم المصادقة
class Unauthenticated extends AuthState {
  const Unauthenticated();

  @override
  List<Object> get props => [];
}

// حالة الخطأ
class AuthError extends AuthState {
  final String message;
  final AuthErrorType? errorType;

  const AuthError({required this.message, this.errorType});

  @override
  List<Object?> get props => [message, errorType];
}

// أنواع الأخطاء
enum AuthErrorType {
  invalidCredentials,
  emailAlreadyExists,
  weakPassword,
  invalidEmail,
  networkError,
  serverError,
  unknownError,
  userNotFound,
  wrongPassword,
  tooManyRequests,
}

// حالة التحقق من البريد الإلكتروني
class EmailVerificationSent extends AuthState {
  final String email;

  const EmailVerificationSent({required this.email});

  @override
  List<Object> get props => [email];
}

// حالة البريد الإلكتروني غير مفعل
class EmailNotVerified extends AuthState {
  final String email;

  const EmailNotVerified({required this.email});

  @override
  List<Object> get props => [email];
}