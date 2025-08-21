import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techfix_app/models/repair_order_model.dart';
import 'package:techfix_app/providers/order_provider.dart';

class TechnicianHomeScreen extends StatelessWidget {
  const TechnicianHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم الفني'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              orderProvider.fetchUserOrders('technician123');
            },
          ),
        ],
      ),
      body: orderProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : orderProvider.orders.isEmpty
              ? const Center(child: Text('لا توجد طلبات معينة'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: orderProvider.orders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderCard(context, orderProvider.orders[index]);
                  },
                ),
    );
  }

  Widget _buildOrderCard(BuildContext context, RepairOrder order) {
    Color statusColor;
    String statusText;
    
    switch (order.status) {
      case OrderStatus.pending:
        statusColor = Theme.of(context).colorScheme.primaryContainer;
        statusText = 'قيد المعالجة';
        break;
      case OrderStatus.inProgress:
        statusColor = Theme.of(context).colorScheme.secondaryContainer;
        statusText = 'جاري الإصلاح';
        break;
      case OrderStatus.readyForPickup:
        statusColor = Theme.of(context).colorScheme.tertiaryContainer ?? Colors.purple;
        statusText = 'جاهز للاستلام';
        break;
      case OrderStatus.completed:
        statusColor = Theme.of(context).colorScheme.tertiary ?? Colors.green;
        statusText = 'مكتمل';
        break;
      case OrderStatus.cancelled:
        statusColor = Theme.of(context).colorScheme.error;
        statusText = 'ملغي';
        break;
    }

    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'طلب #${order.id}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Chip(
                  label: Text(
                    statusText,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  backgroundColor: statusColor,
                ),
              ],
            ),
            
            const SizedBox(height: 10),
            
            // معلومات العميل
            const Text(
              'العميل: محمد أحمد',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 8),
            
            // معلومات الجهاز
            Row(
              children: [
                Icon(
                  Icons.phone_iphone,
                  color: Theme.of(context).colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text('${order.brand} ${order.model}'),
              ],
            ),
            
            const SizedBox(height: 8),
            
            // وصف المشكلة
            Text(
              order.problemDescription,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // أزرار الإجراءات
            if (order.status == OrderStatus.pending)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _updateOrderStatus(context, order.id, OrderStatus.inProgress);
                      },
                      child: const Text('بدء الإصلاح'),
                    ),
                  ),
                ],
              ),
            
            if (order.status == OrderStatus.inProgress)
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _showUpdateDialog(context, order.id);
                          },
                          child: const Text('تحديث الحالة'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _updateOrderStatus(context, order.id, OrderStatus.readyForPickup);
                          },
                          child: const Text('تم الإصلاح'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _updateOrderStatus(BuildContext context, String orderId, OrderStatus newStatus) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.updateOrderStatus(orderId, newStatus);
  }

  void _showUpdateDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تحديث حالة الطلب'),
          content: const Text('ما هو التحديث الذي تريد إضافته؟'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () {
                // إضافة تحديث ثم إغلاق النافذة
                Navigator.of(context).pop();
              },
              child: const Text('إضافة'),
            ),
          ],
        );
      },
    );
  }
}