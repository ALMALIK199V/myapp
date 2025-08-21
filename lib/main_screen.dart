import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:techfix_app/models/user_model.dart';
import 'package:techfix_app/providers/theme_provider.dart';
import 'package:techfix_app/screens/auth/login_screen.dart';
import 'package:techfix_app/screens/customer/customer_home.dart';
import 'package:techfix_app/screens/technician/technician_home.dart';
import 'package:techfix_app/utils/animations.dart';
import 'package:techfix_app/utils/constants.dart';
import 'package:techfix_app/widgets/custom_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final user = Provider.of<UserModel?>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'TechFix',
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: user == null ? _buildGuestScreen() : _buildUserScreen(user),
    );
  }

  Widget _buildGuestScreen() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/repair.json',
              width: 250,
              height: 250,
              repeat: true,
            ),
            const SizedBox(height: 30),
            Text(
              'مرحباً بك في TechFix',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Text(
              'نقدم لكم خدمات صيانة متكاملة للأجهزة الإلكترونية مع متابعة حية لطلبك',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).hintColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(onPressed: () {
                  // الانتقال إلى شاشة التسجيل
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'إنشاء حساب جديد',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserScreen(UserModel user) {
    switch (user.role) {
      case UserRole.customer:
        return CustomerHomeScreen(user: user);
      case UserRole.technician:
        return TechnicianHomeScreen(user: user);
      case UserRole.admin:
        return AdminHomeScreen(user: user);
      default:
        return const Center(child: Text('دور المستخدم غير معروف'));
    }
  }
}

// شاشة خاصة بالمستخدمين (العملاء)
class CustomerHomeScreen extends StatelessWidget {
  final UserModel user;

  const CustomerHomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مرحباً ${user.name}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'كيف يمكننا مساعدتك اليوم؟',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).hintColor,
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildServiceCard(
                  context,
                  'طلب صيانة جديدة',
                  Icons.add_circle_outline,
                  Colors.blue,
                      () {
                    // الانتقال إلى شاشة إنشاء طلب صيانة
                  },
                ),
                _buildServiceCard(
                  context,
                  'متابعة الطلبات',
                  Icons.list_alt,
                  Colors.green,
                      () {
                    // الانتقال إلى شاشة متابعة الطلبات
                  },
                ),
                _buildServiceCard(
                  context,
                  'سجل الصيانة',
                  Icons.history,
                  Colors.orange,
                      () {
                    // الانتقال إلى شاشة سجل الصيانة
                  },
                ),
                _buildServiceCard(
                  context,
                  'الدعم الفني',
                  Icons.support_agent,
                  Colors.purple,
                      () {
                    // الانتقال إلى شاشة الدعم الفني
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// شاشة خاصة بفنيي الصيانة
class TechnicianHomeScreen extends StatelessWidget {
  final UserModel user;

  const TechnicianHomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('شاشة فني الصيانة - مرحباً ${user.name}'),
    );
  }
}

// شاشة خاصة بالمدراء
class AdminHomeScreen extends StatelessWidget {
  final UserModel user;

  const AdminHomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('شاشة المدير - مرحباً ${user.name}'),
    );
  }
}