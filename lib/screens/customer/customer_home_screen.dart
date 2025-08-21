import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techfix_app/providers/order_provider.dart';
import 'package:techfix_app/utils/constants.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();

    // تحميل الطلبات عند فتح الشاشة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      orderProvider.fetchUserOrders('user123');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بطاقة الترحيب
            _buildWelcomeCard(context),
            
            const SizedBox(height: 20),
            
            // الخدمات السريعة
            _buildServicesSection(context),
            
            const SizedBox(height: 20),
            
            // الطلبات الأخيرة
            _buildRecentOrdersSection(context, orderProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorDark,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مرحباً بك، محمد!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'كيف يمكننا مساعدتك في صيانة أجهزتك اليوم؟',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 5),
                Text(
                  '4.8 تقييم',
                  style: TextStyle(color: Colors.white70),
                ),
                const Spacer(),
                Icon(Icons.verified, color: Colors.green[300], size: 20),
                const SizedBox(width: 5),
                Text(
                  'عميل موثوق',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الخدمات السريعة',
          style: TextStyle(fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 15),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: [
            _buildServiceCard(
              context,
              'طلب صيانة جديدة',
              Icons.add_circle_outline,
              Colors.blue,
              () {
                Navigator.of(context).pushNamed('/new-order');
              },
            ),
            _buildServiceCard(
              context,
              'متابعة الطلبات',
              Icons.track_changes,
              Colors.green,
              () {
                Navigator.of(context).pushNamed('/track-orders');
              },
            ),
            _buildServiceCard(
              context,
              'الصيانة عن بُعد',
              Icons.computer,
              Colors.orange,
              () {
                _showComingSoon(context);
              },
            ),
            _buildServiceCard(
              context,
              'الدعم الفني',
              Icons.support_agent,
              Colors.purple,
              () {
                _showComingSoon(context);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentOrdersSection(BuildContext context, OrderProvider orderProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'طلباتك الأخيرة',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/track-orders');
              },
              child: const Text('عرض الكل'),
            ),
          ],
        ),
        const SizedBox(height: 15),
        orderProvider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : orderProvider.orders.isEmpty
                ? _buildEmptyOrdersState()
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: orderProvider.orders.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return _buildOrderItem(context, orderProvider.orders[index]);
                    },
                  ),
      ],
    );
  }

  Widget _buildServiceCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 30, color: color),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                textAlign: TextAlign.center,
              ),],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, dynamic order) {
    // ... (الكود السابق)
    return Card(
      // ... (التصميم السابق)
    );
  }

  Widget _buildEmptyOrdersState() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(Icons.inbox, size: 60, color: Colors.grey[300]),
          const SizedBox(height: 10),
          const Text(
            'لا توجد طلبات حالية',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'قم بإنشاء طلبك الأول لتبدأ رحلة الصيانة',
            style: TextStyle(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('هذه الخدمة قريباً بإذن الله'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}