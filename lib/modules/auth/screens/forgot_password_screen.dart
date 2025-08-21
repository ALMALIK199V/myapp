import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techfix_pro/modules/auth/bloc/auth_bloc.dart';
import 'package:techfix_pro/config/advanced_theme.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        ForgotPasswordEvent(email: _emailController.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CosmicTheme.cosmicBackground,
      body: Stack(
        children: [
          // خلفية متحركة
          _buildAnimatedBackground(),
          
          // محتوى الشاشة
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 80),
                
                // العنوان مع الأنيميشن
                _buildAnimatedTitle(),
                
                const SizedBox(height: 40),
                
                // نموذج إدخال البريد
                _buildEmailForm(),
                
                const SizedBox(height: 30),
                
                // زر الإرسال
                _buildSubmitButton(),
                
                const SizedBox(height: 20),
                
                // رابط العودة لتسجيل الدخول
                _buildBackToLoginLink(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.5,
            colors: [
              CosmicTheme.cosmicPrimary.withOpacity(0.1),
              CosmicTheme.cosmicBackground,
            ],
          ),
        ),
        child: Animate(
          effects: [
            ShimmerEffect(
              duration: 3000.ms,
              angle: 0.5,
              size: 0.8,
              color: CosmicTheme.cosmicPrimary.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedTitle() {
    return Column(
      children: [
        // أيقونة متحركة
        Icon(
          Icons.lock_reset,
          size: 80,
          color: CosmicTheme.cosmicPrimary,
        )
        .animate(controller: _controller)
        .shimmer(duration: 2000.ms)
        .scale(begin: 0.9, end: 1.1)
        .then(delay: 500.ms)
        .shake(),

        const SizedBox(height: 20),

        // العنوان
        Text(
          'نسيت كلمة المرور',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -1,
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms)
        .slideY(begin: -0.5),

        const SizedBox(height: 10),

        // الوصف
        Text(
          'أدخل بريدك الإلكتروني وسنرسل لك رابطاً لإعادة تعيين كلمة المرور',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.5,
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms)
        .slideY(begin: 0.5).delay(200.ms),
      ],
    );
  }

  Widget _buildEmailForm() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: CosmicTheme.cosmicSurface.withOpacity(0.8),
        border: Border.all(
          color: CosmicTheme.cosmicPrimary.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: CosmicTheme.cosmicPrimary.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // حقل البريد الإلكتروني
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
                labelStyle: TextStyle(color: Colors.white70),
                prefixIcon: Icon(Icons.email, color: CosmicTheme.cosmicPrimary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: CosmicTheme.cosmicPrimary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: CosmicTheme.cosmicPrimary.withOpacity(0.5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: CosmicTheme.cosmicPrimary),
                ),
                filled: true,
                fillColor: Colors.black.withOpacity(0.3),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال البريد الإلكتروني';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'يرجى إدخال بريد إلكتروني صحيح';
                }
                return null;
              },
            )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideX(begin: -0.2),

            const SizedBox(height: 20),

            // نص مساعد
            Text(
              'سيصلك رابط التعيين خلال دقائق قليلة',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 14,
              ),
            )
            .animate()
            .fadeIn(duration: 600.ms)
            .slideX(begin: 0.2)
            .delay(200.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          // عرض رسالة النجاح
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 4),
            ),
          );
          
          // العودة للخلف بعد النجاح
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
          });
        } else if (state is AuthError) {
          // عرض رسالة الخطأ
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isLoading ? 60 : double.infinity,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isLoading ? 30 : 15),gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                CosmicTheme.cosmicPrimary,
                CosmicTheme.cosmicSecondary,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: CosmicTheme.cosmicPrimary.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    strokeWidth: 3,
                  ),
                )
              : ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'إرسال رابط التعيين',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.send, size: 20, color: Colors.white),
                    ],
                  ),
                ),
        )
        .animate()
        .scale(duration: 600.ms)
        .then(delay: 300.ms)
        .shake(duration: 1000.ms);
      },
    );
  }

  Widget _buildBackToLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'تذكرت كلمة المرور؟',
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'تسجيل الدخول',
            style: TextStyle(
              color: CosmicTheme.cosmicAccent,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    )
    .animate()
    .fadeIn(duration: 800.ms)
    .slideY(begin: 0.5);
  }
}

// تأثير Shimmer مخصص
class ShimmerEffect extends Effect<double> {
  final Duration duration;
  final double angle;
  final double size;
  final Color color;

  ShimmerEffect({
    required this.duration,
    this.angle = 0.5,
    this.size = 0.8,
    this.color = const Color(0x80FFFFFF),
  }) : super(duration: duration);

  @override
  Widget build(
    BuildContext context,
    Widget child,
    Animation<double> animation,
    EffectEntry entry,
  ) {
    final value = animation.value;
    final isAnimating = value > 0 && value < 1;

    return Stack(
      children: [
        child,
        if (isAnimating)
          Positioned.fill(
            child: IgnorePointer(
              child: ClipPath(
                clipper: _ShimmerClipper(value, angle, size),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        color.withOpacity(0),
                        color,
                        color.withOpacity(0),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _ShimmerClipper extends CustomClipper<Path> {
  final double value;
  final double angle;
  final double size;

  _ShimmerClipper(this.value, this.angle, this.size);

  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    final centerX = width * 0.5;
    final centerY = height * 0.5;

    final shimmerWidth = width * this.size;
    final shimmerHeight = height * this.size;
    final shimmerX = centerX - shimmerWidth / 2;
    final shimmerY = centerY - shimmerHeight / 2;

    final progress = value * 2 - 0.5;

    path.addRect(Rect.fromLTWH(
      shimmerX + progress * width,
      shimmerY,
      shimmerWidth,
      shimmerHeight,
    ));

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}