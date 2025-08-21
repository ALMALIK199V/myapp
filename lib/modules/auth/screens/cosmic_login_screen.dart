import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:particles_flutter/particles_flutter.dart';

class CosmicLoginScreen extends StatefulWidget {
  const CosmicLoginScreen({super.key});

  @override
  State<CosmicLoginScreen> createState() => _CosmicLoginScreenState();
}

class _CosmicLoginScreenState extends State<CosmicLoginScreen> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // خلفية الجسيمات الكونية
          CircularParticle(
            key: UniqueKey(),
            awayRadius: 80,
            numberOfParticles: 200,
            speedOfParticles: 1,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            onTapAnimation: true,
            particleColor: CosmicTheme.cosmicPrimary.withOpacity(0.5),
            awayAnimationDuration: const Duration(milliseconds: 600),
            maxParticleSize: 6,
            isRandSize: true,
            isRandomColor: true,
            randColorList: [
              CosmicTheme.cosmicPrimary,
              CosmicTheme.cosmicSecondary,
              CosmicTheme.cosmicAccent,
            ],
            awayAnimationCurve: Curves.easeInOutBack,
            enableHover: true,
            hoverColor: Colors.white,
            hoverRadius: 90,
          ),

          // محتوى الشاشة
          LiquidSwipe(
            pages: [
              _buildLoginPage(),
              _buildWelcomePage(),
            ],
            fullTransitionValue: 300,
            enableSlideIcon: true,
            positionSlideIcon: 0.8,
            waveType: WaveType.liquid,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginPage() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            CosmicTheme.cosmicBackground.withOpacity(0.9),
            CosmicTheme.cosmicSurface.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: _buildLoginForm(),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black.withOpacity(0.3),
        border: Border.all(color: CosmicTheme.cosmicPrimary.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // أيقونة متحركة
          Icon(
            Icons.phone_iphone,
            size: 80,
            color: CosmicTheme.cosmicPrimary,
          )
          .animate(onPlay: (controller) => controller.repeat(reverse: true))
          .shimmer(duration: 2000.ms, delay: 1000.ms)
          .scale(begin: 0.8, end: 1.1, duration: 2000.ms),

          const SizedBox(height: 30),

          // حقل البريد الإلكتروني
          TextField(
            decoration: InputDecoration(
              labelText: 'البريد الإلكتروني',
              labelStyle: const TextStyle(color: Colors.white70),
              prefixIcon: Icon(Icons.email, color: CosmicTheme.cosmicPrimary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: CosmicTheme.cosmicPrimary),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color: CosmicTheme.cosmicPrimary.withOpacity(0.5)),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          )
          .animate()
          .fadeIn(duration: 600.ms)
          .slideX(begin: -0.2),

          const SizedBox(height: 20),

          // حقل كلمة المرور
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'كلمة المرور',
              labelStyle: const TextStyle(color: Colors.white70),
              prefixIcon: Icon(Icons.lock, color: CosmicTheme.cosmicPrimary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: CosmicTheme.cosmicPrimary),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          )
          .animate()
          .fadeIn(duration: 600.ms)
          .slideX(begin: 0.2)
          .delay(200.ms),

          const SizedBox(height: 30),

          // زر تسجيل الدخول
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: CosmicTheme.cosmicPrimary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text('تسجيل الدخول'),
          )
          .animate()
          .scale(duration: 600.ms)
          .shake(duration: 1000.ms, delay: 1000.ms),
        ],
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TechFix Pro',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            )
            .animate()
            .fadeIn(duration: 1000.ms)
            .scale(begin: 0.5, end: 1.0),

            const SizedBox(height: 20),

            Text(
              'تجربة صيانة استثنائية',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.8),
              ),
            )
            .animate()
            .fadeIn(duration: 1000.ms)
            .slideY(begin: 0.5),
          ],
        ),
      ),
    );
  }
}