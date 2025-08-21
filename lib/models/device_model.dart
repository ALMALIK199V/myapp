class Device {
  final String id;
  final String type;
  final String brand;
  final String model;
  final String? serialNumber;
  final DateTime? purchaseDate;
  final Map<String, dynamic>? specifications;

  Device({
    required this.id,
    required this.type,
    required this.brand,
    required this.model,
    this.serialNumber,
    this.purchaseDate,
    this.specifications,
  });

  factory Device.fromMap(Map<String, dynamic> map) {
    return Device(
      id: map['id'],
      type: map['type'],
      brand: map['brand'],
      model: map['model'],
      serialNumber: map['serialNumber'],
      purchaseDate: map['purchaseDate'] != null ? DateTime.parse(map['purchaseDate']) : null,
      specifications: map['specifications'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'brand': brand,
      'model': model,
      'serialNumber': serialNumber,
      'purchaseDate': purchaseDate?.toIso8601String(),
      'specifications': specifications,
    };
  }
}

class DeviceType {
  final String id;
  final String name;
  final String icon;

  DeviceType({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory DeviceType.fromMap(Map<String, dynamic> map) {
    return DeviceType(
      id: map['id'],
      name: map['name'],
      icon: map['icon'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }
}

class DeviceBrand {
  final String id;
  final String name;
  final String logo;

  DeviceBrand({
    required this.id,
    required this.name,
    required this.logo,
  });

  factory DeviceBrand.fromMap(Map<String, dynamic> map) {
    return DeviceBrand(
      id: map['id'],
      name: map['name'],
      logo: map['logo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
    };
  }
}