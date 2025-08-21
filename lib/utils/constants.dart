import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'TechFix Pro';
  static const String appVersion = '1.0.0';
  
  // مسارات الصور
  static const String logoPath = 'assets/images/logo.png';
  static const String splashAnimation = 'assets/animations/splash.json';
  
  // ألوان التطبيق
  static const Color primaryColor = Color(0xFF4361EE);
  static const Color secondaryColor = Color(0xFF3A0CA3);
  static const Color successColor = Color(0xFF4CC9F0);
  static const Color warningColor = Color(0xFFF72585);
  
  // نصوص ثابتة
  static const String loginTitle = 'تسجيل الدخول';
  static const String registerTitle = 'إنشاء حساب جديد';
  static const String welcomeMessage = 'مرحباً بك في TechFix Pro';
  
  // رسائل التنبيه
  static const String loginSuccess = 'تم تسجيل الدخول بنجاح';
  static const String loginError = 'خطأ في البريد الإلكتروني أو كلمة المرور';
}