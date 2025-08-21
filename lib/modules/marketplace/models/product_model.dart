class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final List<String> images;
  final String category;
  final String brand;
  final List<String> compatibleDevices;
  final double rating;
  final int reviewCount;
  final int stock;
  final bool isAvailable;
  final bool isFeatured;
  final bool hasWarranty;
  final int warrantyMonths;
  final List<ProductSpecification> specifications;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    this.images = const [],
    required this.category,
    required this.brand,
    this.compatibleDevices = const [],
    this.rating = 0.0,
    this.reviewCount = 0,
    required this.stock,
    this.isAvailable = true,
    this.isFeatured = false,
    this.hasWarranty = false,
    this.warrantyMonths = 0,
    this.specifications = const [],
    required this.createdAt,
  });

  // السعر بعد الخصم إن وجد
  double get discountPercentage {
    if (originalPrice == null || originalPrice! <= price) return 0;
    return ((originalPrice! - price) / originalPrice!) * 100;
  }

  bool get hasDiscount => discountPercentage > 0;

  // التحويل من/إلى Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'imageUrl': imageUrl,
      'images': images,
      'category': category,
      'brand': brand,
      'compatibleDevices': compatibleDevices,
      'rating': rating,
      'reviewCount': reviewCount,
      'stock': stock,
      'isAvailable': isAvailable,
      'isFeatured': isFeatured,
      'hasWarranty': hasWarranty,
      'warrantyMonths': warrantyMonths,
      'specifications': specifications.map((s) => s.toMap()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price']?.toDouble() ?? 0.0,
      originalPrice: map['originalPrice']?.toDouble(),
      imageUrl: map['imageUrl'],
      images: List<String>.from(map['images'] ?? []),
      category: map['category'],
      brand: map['brand'],
      compatibleDevices: List<String>.from(map['compatibleDevices'] ?? []),
      rating: map['rating']?.toDouble() ?? 0.0,
      reviewCount: map['reviewCount'] ?? 0,
      stock: map['stock'] ?? 0,
      isAvailable: map['isAvailable'] ?? true,
      isFeatured: map['isFeatured'] ?? false,
      hasWarranty: map['hasWarranty'] ?? false,
      warrantyMonths: map['warrantyMonths'] ?? 0,
      specifications: (map['specifications'] as List<dynamic>?)
          ?.map((s) => ProductSpecification.fromMap(s))
          .toList() ??
          [],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}

class ProductSpecification {
  final String key;
  final String value;

  ProductSpecification({required this.key, required this.value});

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'value': value,
    };
  }

  factory ProductSpecification.fromMap(Map<String, dynamic> map) {
    return ProductSpecification(
      key: map['key'],
      value: map['value'],
    );
  }
}