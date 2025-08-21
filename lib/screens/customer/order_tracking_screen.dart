import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techfix_app/providers/order_provider.dart';
import 'package:techfix_app/models/repair_order_model.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      orderProvider.fetchUserOrders('user123');
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('متابعة الطلبات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              orderProvider.fetchUserOrders('user123');
            },
          ),
        ],
      ),
      body: orderProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : orderProvider.orders.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: () async {
                    await orderProvider.fetchUserOrders('user123');
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: orderProvider.orders.length,
                    itemBuilder: (context, index) {
                      return _buildOrderCard(orderProvider.orders[index]);
                    },
                  ),
                ),
    );
  }

  Widget _buildOrderCard(RepairOrder order) {
    // ... (الكود السابق مع تحسينات)
    return Card(
      // ... (التصميم المحسن)
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text(
            'لا توجد طلبات لعرضها',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'قم بإنشاء طلب صيانة جديد لتبدأ',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/new-order');
            },
            child: const Text('إنشاء طلب جديد'),
          ),
        ],
      ),
    );
  }
}