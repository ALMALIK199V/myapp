import 'package:flutter/material.dart';
import 'package:techfix_pro/modules/marketplace/models/product_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Product _product;
  int _selectedImageIndex = 0;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    // محاكاة جلب بيانات المنتج
    _product = Product(
      id: widget.productId,
      name: 'شاشة iPhone 13 Pro Max',
      description: 'شاشة أصلية بدقة Super Retina XDR مع تقنية OLED. متوافقة مع iPhone 13 Pro Max. جودة عالية مع ضمان 6 أشهر.',
      price: 350.0,
      originalPrice: 420.0,
      imageUrl: 'assets/images/screen.jpg',
      images: [
        'assets/images/screen.jpg',
        'assets/images/screen_2.jpg',
        'assets/images/screen_3.jpg',
      ],
      category: 'شاشات الهواتف',
      brand: 'Apple',
      compatibleDevices: ['iPhone 13 Pro', 'iPhone 13 Pro Max'],
      rating: 4.7,
      reviewCount: 47,
      stock: 8,
      isAvailable: true,
      isFeatured: true,
      hasWarranty: true,
      warrantyMonths: 6,
      specifications: [
        ProductSpecification(key: 'النوع', value: 'شاشة OLED'),
        ProductSpecification(key: 'الحجم', value: '6.7 بوصة'),
        ProductSpecification(key: 'الدقة', value: '2778 × 1284 بكسل'),
        ProductSpecification(key: 'اللمس', value: 'Multi-Touch'),
        ProductSpecification(key: 'الضمان', value: '6 أشهر'),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    );
  }

  void _addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم إضافة $_quantity من ${_product.name} إلى السلة'),
        action: SnackBarAction(
          label: 'عرض السلة',
          onPressed: () {
            // الانتقال إلى سلة التسوق
          },
        ),
      ),
    );
  }

  void _buyNow() {
    // الانتقال مباشرة إلى checkout
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar مع الصور
          SliverAppBar(
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildImageGallery(),
            ),
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {},
              ),
            ],
          ),

          // محتوى المنتج
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // العنوان والسعر
                  _buildProductHeader(),
                  const SizedBox(height: 16),

                  // التقييمات
                  _buildRatingSection(),
                  const SizedBox(height: 16),

                  // الوصف
                  _buildDescriptionSection(),
                  const SizedBox(height: 16),

                  // المواصفات
                  _buildSpecificationsSection(),
                  const SizedBox(height: 16),

                  // الأجهزة المتوافقة
                  _buildCompatibilitySection(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Bar للشراء
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildImageGallery() {
    return PageView.builder(
      itemCount: _product.images.length,
      onPageChanged: (index) => setState(() => _selectedImageIndex = index),
      itemBuilder: (context, index) {
        return Image.asset(_product.images[index],
          fit: BoxFit.cover,
        );
      },
    );
  }

  Widget _buildProductHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _product.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              '${_product.price.toStringAsFixed(2)} درهم',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            if (_product.hasDiscount) ...[
              const SizedBox(width: 8),
              Text(
                '${_product.originalPrice?.toStringAsFixed(2)} درهم',
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${_product.discountPercentage.toStringAsFixed(0)}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'العلامة التجارية: ${_product.brand}',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Row(
      children: [
        // النجوم
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < _product.rating.floor() ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 20,
            );
          }),
        ),
        const SizedBox(width: 8),
        Text(
          _product.rating.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 4),
        Text(
          '(${_product.reviewCount} تقييم)',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'الوصف',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _product.description,
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildSpecificationsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'المواصفات',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ..._product.specifications.map((spec) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Text(
                '${spec.key}: ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(spec.value),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildCompatibilitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'متوافق مع',
          style: TextStyle(
            fontSize: 18,fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _product.compatibleDevices.map((device) => Chip(
            label: Text(device),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          // عداد الكمية
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                ),
                Text(
                  _quantity.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _quantity < _product.stock ? () => setState(() => _quantity++) : null,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          
          // زر الإضافة إلى السلة
          Expanded(
            child: OutlinedButton(
              onPressed: _addToCart,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('إضافة إلى السلة'),
            ),
          ),
          const SizedBox(width: 8),
          
          // زر الشراء الآن
          Expanded(
            child: ElevatedButton(
              onPressed: _buyNow,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('شراء الآن'),
            ),
          ),
        ],
      ),
    );
  }
}