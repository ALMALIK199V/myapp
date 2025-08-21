import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:techfix_pro/modules/auth/models/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvent>(_onRegisterEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<ForgotPasswordEvent>(_onForgotPasswordEvent);
    on<ResetPasswordEvent>(_onResetPasswordEvent);
    on<CheckAuthStatusEvent>(_onCheckAuthStatusEvent);
    on<UpdateUserProfileEvent>(_onUpdateUserProfileEvent);
    on<ChangePasswordEvent>(_onChangePasswordEvent);
    on<SocialLoginEvent>(_onSocialLoginEvent);
  }

  // معالج حدث تسجيل الدخول
  Future<void> _onLoginEvent(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(loadingMessage: 'جاري تسجيل الدخول...'));

    try {
      // محاكاة عملية تسجيل الدخول
      await Future.delayed(const Duration(seconds: 2));

      // التحقق من بيانات الاختبار
      if (event.email == "test@test.com" && event.password == "123456") {
        final user = UserModel(
          id: 'user_123',
          name: 'محمد أحمد',
          email: event.email,
          phone: '+966500000000',
          role: UserRole.customer,
          joinedAt: DateTime.now(),
          profileImage: null,
          isEmailVerified: true,
          addresses: [],
        );

        emit(LoginSuccess(user: user));
        emit(Authenticated(user: user));
      } else {
        emit(const AuthError(
          message: 'البريد الإلكتروني أو كلمة المرور غير صحيحة',
          errorType: AuthErrorType.invalidCredentials,
        ));
      }
    } catch (e) {
      emit(const AuthError(
        message: 'حدث خطأ أثناء تسجيل الدخول',
        errorType: AuthErrorType.unknownError,
      ));
    }
  }

  // معالج حدث التسجيل
  Future<void> _onRegisterEvent(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(loadingMessage: 'جاري إنشاء الحساب...'));

    try {
      // التحقق من تطابق كلمات المرور
      if (event.password != event.confirmPassword) {
        emit(const AuthError(
          message: 'كلمات المرور غير متطابقة',
          errorType: AuthErrorType.wrongPassword,
        ));
        return;
      }

      // التحقق من قوة كلمة المرور
      if (event.password.length < 6) {
        emit(const AuthError(
          message: 'كلمة المرور يجب أن تكون至少 6 أحرف',
          errorType: AuthErrorType.weakPassword,
        ));
        return;
      }

      // محاكاة عملية التسجيل
      await Future.delayed(const Duration(seconds: 2));

      final user = UserModel(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        name: event.name,
        email: event.email,
        phone: event.phone,
        role: UserRole.customer,
        joinedAt: DateTime.now(),
        profileImage: null,
        isEmailVerified: false,
        addresses: [],
      );

      emit(RegisterSuccess(user: user));
      emit(EmailVerificationSent(email: event.email));
    } catch (e) {
      emit(const AuthError(
        message: 'حدث خطأ أثناء إنشاء الحساب',
        errorType: AuthErrorType.unknownError,
      ));
    }
  }

  // معالج حدث تسجيل الخروج
  Future<void> _onLogoutEvent(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(loadingMessage: 'جاري تسجيل الخروج...'));

    try {
      // محاكاة عملية تسجيل الخروج
      await Future.delayed(const Duration(seconds: 1));
      
      emit(const Unauthenticated());
    } catch (e) {
      emit(const AuthError(
        message: 'حدث خطأ أثناء تسجيل الخروج',
        errorType: AuthErrorType.unknownError,
      ));
    }
  }

  // معالج حدث نسيان كلمة المرور
  Future<void> _onForgotPasswordEvent(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(loadingMessage: 'جاري إرسال رابط التعيين...'));

    try {
      // محاكاة عملية إرسال البريد
      await Future.delayed(const Duration(seconds: 2));
emit(ForgotPasswordSuccess(
        message: 'تم إرسال رابط تعيين كلمة المرور إلى بريدك الإلكتروني',
      ));
    } catch (e) {
      emit(const AuthError(
        message: 'حدث خطأ أثناء إرسال رابط التعيين',
        errorType: AuthErrorType.unknownError,
      ));
    }
  }

  // معالج حدث إعادة تعيين كلمة المرور
  Future<void> _onResetPasswordEvent(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(loadingMessage: 'جاري تعيين كلمة المرور الجديدة...'));

    try {
      if (event.newPassword != event.confirmPassword) {
        emit(const AuthError(
          message: 'كلمات المرور غير متطابقة',
          errorType: AuthErrorType.wrongPassword,
        ));
        return;
      }

      if (event.newPassword.length < 6) {
        emit(const AuthError(
          message: 'كلمة المرور يجب أن تكون至少 6 أحرف',
          errorType: AuthErrorType.weakPassword,
        ));
        return;
      }

      await Future.delayed(const Duration(seconds: 2));

      emit(const ResetPasswordSuccess(
        message: 'تم تعيين كلمة المرور الجديدة بنجاح',
      ));
    } catch (e) {
      emit(const AuthError(
        message: 'حدث خطأ أثناء تعيين كلمة المرور',
        errorType: AuthErrorType.unknownError,
      ));
    }
  }

  // معالج حدث التحقق من حالة المصادقة
  Future<void> _onCheckAuthStatusEvent(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // محاكاة التحقق من حالة المصادقة
      await Future.delayed(const Duration(milliseconds: 500));

      // هنا يمكنك التحقق من وجود token أو بيانات مستخدم محفوظة
      final isAuthenticated = false; // سيتم استبدالها بالمنطق الفعلي

      if (isAuthenticated) {
        // إرجاع بيانات المستخدم من storage
        emit(const Authenticated(user: UserModel(
          id: 'user_123',
          name: 'محمد أحمد',
          email: 'test@test.com',
          phone: '+966500000000',
          role: UserRole.customer,
          joinedAt: DateTime.now(),
          profileImage: null,
          isEmailVerified: true,
          addresses: [],
        )));
      } else {
        emit(const Unauthenticated());
      }
    } catch (e) {
      emit(const Unauthenticated());
    }
  }

  // معالج حدث تحديث الملف الشخصي
  Future<void> _onUpdateUserProfileEvent(
    UpdateUserProfileEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(loadingMessage: 'جاري تحديث البيانات...'));

    try {
      await Future.delayed(const Duration(seconds: 1));

      // هنا سيتم تحديث بيانات المستخدم في API
      final updatedUser = UserModel(
        id: 'user_123',
        name: event.name,
        email: 'test@test.com', // البريد لا يتغير
        phone: event.phone,
        role: UserRole.customer,
        joinedAt: DateTime.now(),
        profileImage: event.profileImage,
        isEmailVerified: true,
        addresses: [],
      );

      emit(UpdateProfileSuccess(user: updatedUser));
      
      // تحديث حالة المصادقة أيضاً
      if (state is Authenticated) {
        emit(Authenticated(user: updatedUser));
      }
    } catch (e) {
      emit(const AuthError(
        message: 'حدث خطأ أثناء تحديث البيانات',
        errorType: AuthErrorType.unknownError,
      ));
    }
  }

  // معالج حدث تغيير كلمة المرور
  Future<void> _onChangePasswordEvent(
    ChangePasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(loadingMessage: 'جاري تغيير كلمة المرور...'));

    try {
      if (event.newPassword != event.confirmPassword) {
        emit(const AuthError(
          message: 'كلمات المرور غير متطابقة',
          errorType: AuthErrorType.wrongPassword,
        ));
        return;
      }

      if (event.newPassword.length < 6) {
        emit(const AuthError(
          message: 'كلمة المرور يجب أن تكون至少 6 أحرف',
          errorType: AuthErrorType.weakPassword,
        ));
        return;
      }

      await Future.delayed(const Duration(seconds: 2));

      emit(const ChangePasswordSuccess(
        message: 'تم تغيير كلمة المرور بنجاح',
      ));
    } catch (e) {
emit(const AuthError(
        message: 'حدث خطأ أثناء تغيير كلمة المرور',
        errorType: AuthErrorType.unknownError,
      ));
    }
  }

  // معالج حدث التسجيل الاجتماعي
  Future<void> _onSocialLoginEvent(
    SocialLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(loadingMessage: 'جاري التسجيل باستخدام الحساب الاجتماعي...'));

    try {
      await Future.delayed(const Duration(seconds: 2));

      final user = UserModel(
        id: 'social_user_${DateTime.now().millisecondsSinceEpoch}',
        name: 'مستخدم ${event.type.name}',
        email: 'social@example.com',
        phone: '+966500000000',
        role: UserRole.customer,
        joinedAt: DateTime.now(),
        profileImage: null,
        isEmailVerified: true,
        addresses: [],
      );

      emit(LoginSuccess(user: user));
      emit(Authenticated(user: user));
    } catch (e) {
      emit(const AuthError(
        message: 'حدث خطأ أثناء التسجيل باستخدام الحساب الاجتماعي',
        errorType: AuthErrorType.unknownError,
      ));
    }
  }

  // دالة مساعدة للتحقق من صحة البريد الإلكتروني
  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // دالة مساعدة للتحقق من قوة كلمة المرور
  bool _isStrongPassword(String password) {
    return password.length >= 6;
  }
}