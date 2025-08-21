class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final DateTime joinedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.joinedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      role: UserRole.values.firstWhere((e) => e.toString() == 'UserRole.${map['role']}'),
      joinedAt: DateTime.parse(map['joinedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.toString().split('.').last,
      'joinedAt': joinedAt.toIso8601String(),
    };
  }
}

enum UserRole {
  customer,
  technician,
  admin,
  delivery,
}