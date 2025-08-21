import 'package:flutter/foundation.dart';
import 'package:techfix_app/models/repair_order_model.dart';

class OrderProvider with ChangeNotifier {
  final List<RepairOrder> _orders = [];
  bool _isLoading = false;
  String? _error;

  List<RepairOrder> get orders => _orders;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // جلب جميع طلبات المستخدم
  Future<void> fetchUserOrders(String userId) async {
    _setLoading(true);
    _error = null;

    try {
      // محاكاة جلب البيانات (سيتم استبدالها بـ Firestore)
      await Future.delayed(const Duration(seconds: 2));
      
      _orders.clear();
      _orders.addAll([
        RepairOrder(
          id: '12345',
          customerId: userId,
          deviceType: 'هاتف',
          brand: 'Apple',
          model: 'iPhone 13 Pro',
          problemDescription: 'شاشة مكسورة',
          status: OrderStatus.inProgress,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 5)),
          trackingNumber: 'TRK-789456',
        ),
        RepairOrder(
          id: '12346',
          customerId: userId,
          deviceType: 'لابتوب',
          brand: 'Dell',
          model: 'XPS 13',
          problemDescription: 'بطارية لا تعمل',
          status: OrderStatus.readyForPickup,
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
          updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
          trackingNumber: 'TRK-789457',
          warrantyDays: 30,
        ),
      ]);
      
      _setLoading(false);
    } catch (e) {
      _error = 'حدث خطأ أثناء جلب الطلبات';
      _setLoading(false);
    }
  }

  // إضافة طلب جديد
  Future<bool> addOrder(RepairOrder newOrder) async {
    _setLoading(true);
    _error = null;

    try {
      // محاكاة إضافة الطلب (سيتم استبدالها بـ Firestore)
      await Future.delayed(const Duration(seconds: 1));
      
      _orders.add(newOrder);
      _setLoading(false);
      return true;
    } catch (e) {
      _error = 'حدث خطأ أثناء إضافة الطلب';
      _setLoading(false);
      return false;
    }
  }

  // تحديث حالة الطلب
  Future<bool> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    _setLoading(true);
    _error = null;

    try {
      // محاكاة تحديث الطلب (سيتم استبدالها بـ Firestore)
      await Future.delayed(const Duration(milliseconds: 500));
      
      final index = _orders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        _orders[index] = RepairOrder(
          id: _orders[index].id,
          customerId: _orders[index].customerId,
          deviceType: _orders[index].deviceType,
          brand: _orders[index].brand,
          model: _orders[index].model,
          problemDescription: _orders[index].problemDescription,
          status: newStatus,
          createdAt: _orders[index].createdAt,
          updatedAt: DateTime.now(),
          trackingNumber: _orders[index].trackingNumber,
          warrantyDays: _orders[index].warrantyDays,
        );
        
        _setLoading(false);
        return true;
      }
      
      _error = 'لم يتم العثور على الطلب';
      _setLoading(false);
      return false;
    } catch (e) {
      _error = 'حدث خطأ أثناء تحديث الطلب';
      _setLoading(false);
      return false;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}