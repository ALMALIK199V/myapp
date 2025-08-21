class ProductCategory {
  final String id;
  final String name;
  final String? description;
  final String icon;
  final int productCount;
  final List<SubCategory> subCategories;
  final bool isActive;

  ProductCategory({
    required this.id,
    required this.name,
    this.description,
    required this.icon,
    this.productCount = 0,
    this.subCategories = const [],
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'productCount': productCount,
      'subCategories': subCategories.map((s) => s.toMap()).toList(),
      'isActive': isActive,
    };
  }

  factory ProductCategory.fromMap(Map<String, dynamic> map) {
    return ProductCategory(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      icon: map['icon'],
      productCount: map['productCount'] ?? 0,
      subCategories: (map['subCategories'] as List<dynamic>?)
          ?.map((s) => SubCategory.fromMap(s))
          .toList() ??
          [],
      isActive: map['isActive'] ?? true,
    );
  }
}

class SubCategory {
  final String id;
  final String name;
  final int productCount;

  SubCategory({
    required this.id,
    required this.name,
    this.productCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'productCount': productCount,
    };
  }

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      id: map['id'],
      name: map['name'],
      productCount: map['productCount'] ?? 0,
    );
  }
}

// فئات المنتجات الرئيسية
final List<ProductCategory> mainCategories = [
  ProductCategory(
    id: '1',
    name: 'شاشات الهواتف',
    icon: '📱',
    productCount: 45,
    subCategories: [
      SubCategory(id: '1-1', name: 'آيفون', productCount: 20),
      SubCategory(id: '1-2', name: 'سامسونج', productCount: 15),
      SubCategory(id: '1-3', name: 'هواوي', productCount: 10),
    ],
  ),
  ProductCategory(
    id: '2',
    name: 'البطاريات',
    icon: '🔋',
    productCount: 32,
    subCategories: [
      SubCategory(id: '2-1', name: 'أصلي', productCount: 15),
      SubCategory(id: '2-2', name: 'ذو جودة عالية', productCount: 17),
    ],
  ),
  ProductCategory(
    id: '3',
    name: 'الكاميرات',
    icon: '📷',
    productCount: 28,
    subCategories: [
      SubCategory(id: '3-1', name: 'كاميرا أمامية', productCount: 12),
      SubCategory(id: '3-2', name: 'كاميرا خلفية', productCount: 16),
    ],
  ),
  ProductCategory(
    id: '4',
    name: 'لوحات الأم',
    icon: '💻',
    productCount: 18,
  ),
  ProductCategory(
    id: '5',
    name: 'أدوات الصيانة',
    icon: '🛠️',
    productCount: 67,
  ),
];