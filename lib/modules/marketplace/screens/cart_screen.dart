
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techfix_pro/modules/marketplace/models/product_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<CartItem> _cartItems = [
    CartItem(
      product: Product(
        id: '1',
        name: 'شاشة iPhone 13 Pro',
        description: 'شاشة أصلية بدقة عالية',
        price: 299.0,
        originalPrice: 350.0,
        imageUrl: 'assets/images/screen.jpg',
        category: 'شاشات الهواتف',
        brand: 'Apple',
        compatibleDevices: ['iPhone 13 Pro', 'iPhone 13 Pro Max'],
        rating: 4.5,
        reviewCount: 23,
        stock: 15,
        hasWarranty: true,
        warrantyMonths: 6,
        createdAt: DateTime.now(),
      ),
      quantity: 1,
    ),
    CartItem(
      product: Product(
        id: '2',
        name: 'بطارية Samsung S22',
        description: 'بطارية أصلية بسعة 4500mAh',
        price: 89.0,
        imageUrl: 'assets/images/battery.jpg',
        category: 'البطاريات',
        brand: 'Samsung',
        compatibleDevices: ['Samsung S22', 'Samsung S22+'],
        rating: 4.2,
        reviewCount: 15,
        stock: 8,
        hasWarranty: true,
        warrantyMonths: 12,
        createdAt: DateTime.now(),
      ),
      quantity: 2,
    ),
  ];

  double get _totalPrice {
    return _cartItems.fold(0, (total, item) => total + (item.product.price * item.quantity));
  }

  double get _totalDiscount {
    return _cartItems.fold(0, (total, item) {
      final original = item.product.originalPrice ?? item.product.price;
      return total + ((original - item.product.price) * item.quantity);
    });
  }

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index] = _cartItems[index].copyWith(quantity: newQuantity);
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إزالة المنتج من السلة')),
    );
  }

  void _checkout() {
    if (_cartItems.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إتمام الطلب'),
        content: const Text('هل تريد متابعة عملية الشراء؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // الانتقال لشاشة الدفع
            },
            child: const Text('متابعة'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سلة التسوق'),
        actions: [
          if (_cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setState(() => _cartItems.clear());
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم تفريغ السلة')),
                );
              },
            ),
        ],
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      return _buildCartItem(_cartItems[index], index);
                    },
                  ),
                ),
                _buildCheckoutSection(),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text(
            'سلة التسوق فارغة',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'أضف بعض المنتجات لتبدأ التسوق',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('تصفح المنتجات'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // صورة المنتج
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(item.product.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // معلومات المنتج
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.product.brand,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  
                  // السعر والكمية
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.product.price.toStringAsFixed(2)} درهم',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      _buildQuantityControls(item, index),
                    ],
                  ),
                  
                  // الخصم إن وجد
                  if (item.product.hasDiscount)
                    Text(
                      'وفرت ${item.product.discountPercentage.toStringAsFixed(0)}%',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            
            // زر الحذف
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _removeItem(index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityControls(CartItem item, int index) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () => _updateQuantity(index, item.quantity - 1),
        ),
        Text(
          item.quantity.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _updateQuantity(index, item.quantity + 1),
        ),
      ],
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        children: [
          // المجموع
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('المجموع'),
              Text('${_totalPrice.toStringAsFixed(2)} درهم'),
            ],
          ),
          
          // الخصم
          if (_totalDiscount > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('الخصم'),
                  Text(
                    '-${_totalDiscount.toStringAsFixed(2)} درهم',
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          
          // الإجمالي
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('الإجمالي', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${_totalPrice.toStringAsFixed(2)} درهم',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          
          // زر الشراء
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _checkout,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'إتمام الشراء',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });

  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}