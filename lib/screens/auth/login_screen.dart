import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techfix_app/providers/auth_provider.dart';
import 'package:techfix_app/screens/auth/register_screen.dart'; // تأكد من المسار الصحيح
import 'package:techfix_app/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _rememberMe = false;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        final success = await authProvider.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        setState(() {
          _isLoading = false;
        });

        if (success) {
          // استخدام pushReplacementNamed بدلاً من pushReplacement
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          // عرض خطأ
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(authProvider.error ?? 'حدث خطأ أثناء تسجيل الدخول'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ غير متوقع: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // زر العودة وأيقونة
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.phone_iphone,
                      size: 40,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // عنوان الشاشة
                Text(
                  AppConstants.loginTitle,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                
                const SizedBox(height: 10),
                
                // وصف الشاشة
                Text(
                  'سجل دخولك لمتابعة طلبات الصيانة وإدارة أجهزتك',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // حقل البريد الإلكتروني
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'البريد الإلكتروني',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال البريد الإلكتروني';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'يرجى إدخال بريد إلكتروني صحيح';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // حقل كلمة المرور
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'كلمة المرور',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال كلمة المرور';
                    }
                    if (value.length < 6) {
                      return 'كلمة المرور يجب أن تكون至少 6 أحرف';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // تذكرني ونسيت كلمة المرور
                Row(
                  children: [
                    // تذكرني
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                    ),
                    const Text('تذكرني'),
                    
                    const Spacer(),
                    
                    // نسيت كلمة المرور
                    TextButton(
                      onPressed: () {
                        // الانتقال إلى شاشة استعادة كلمة المرور
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('هذه الميزة غير متاحة حالياً'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: const Text('نسيت كلمة المرور؟'),
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // زر تسجيل الدخول
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : const Text(
                            'تسجيل الدخول',
                            style: TextStyle(fontSize: 18),),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // أو تسجيل الدخول بـ
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'أو تسجيل الدخول بـ',
                        style: TextStyle(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                
                const SizedBox(height: 20),
                
                // أزرار التسجيل بالوسائل الاجتماعية
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تسجيل الدخول بجوجل غير متاح حالياً'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.g_mobiledata),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                    
                    const SizedBox(width: 15),
                    
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تسجيل الدخول بآبل غير متاح حالياً'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.apple),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                    
                    const SizedBox(width: 15),
                    
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('تسجيل الدخول بفيسبوك غير متاح حالياً'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.facebook),
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).cardColor,
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                // رابط إنشاء حساب جديد
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ليس لديك حساب؟',
                      style: TextStyle(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      child: const Text('إنشاء حساب'),
                    ),
                  ],
                ),],
            ),
          ),
        ),
      ),
    );
  }
}