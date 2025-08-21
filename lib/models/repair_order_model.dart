class RepairOrder {
  final String id;
  final String customerId;
  final String deviceType;
  final String brand;
  final String model;
  final String problemDescription;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? assignedTechnician;
  final String? trackingNumber;
  final int? warrantyDays;

  RepairOrder({
    required this.id,
    required this.customerId,
    required this.deviceType,
    required this.brand,
    required this.model,
    required this.problemDescription,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.assignedTechnician,
    this.trackingNumber,
    this.warrantyDays,
  });

  factory RepairOrder.fromMap(Map<String, dynamic> map) {
    return RepairOrder(
      id: map['id'],
      customerId: map['customerId'],
      deviceType: map['deviceType'],
      brand: map['brand'],
      model: map['model'],
      problemDescription: map['problemDescription'],
      status: OrderStatus.values.firstWhere((e) => e.toString() == 'OrderStatus.${map['status']}'),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
      assignedTechnician: map['assignedTechnician'],
      trackingNumber: map['trackingNumber'],
      warrantyDays: map['warrantyDays'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'deviceType': deviceType,
      'brand': brand,
      'model': model,
      'problemDescription': problemDescription,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'assignedTechnician': assignedTechnician,
      'trackingNumber': trackingNumber,
      'warrantyDays': warrantyDays,
    };
  }
}

enum OrderStatus {
  pending,
  inProgress,
  readyForPickup,
  completed,
  cancelled,
}