import 'package:flutter/material.dart';
import 'package:techfix_pro/modules/repair/models/repair_service.dart';

class RepairServiceScreen extends StatefulWidget {
  const RepairServiceScreen({super.key});

  @override
  State<RepairServiceScreen> createState() => _RepairServiceScreenState();
}

class _RepairServiceScreenState extends State<RepairServiceScreen> {
  final List<RepairService> _services = [
    RepairService(
      id: '1',
      title: 'صيانة شاشة الموبايل',
      description: 'استبدال شاشة مكسورة بجودة عالية',
      price: 150.0,
      duration: '2-4 ساعات',
      warranty: '6 أشهر',
      imageUrl: 'assets/images/services/screen_repair.jpg',
    ),
    RepairService(
      id: '2',
      title: 'تبديل بطارية',
      description: 'استبدال البطارية بأصلية',
      price: 80.0,
      duration: '1-2 ساعات',
      warranty: '12 شهر',
      imageUrl: 'assets/images/services/battery_replacement.jpg',
    ),
    // ... خدمات أخرى
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('خدمات الصيانة')),
      body: ListView.builder(
        itemCount: _services.length,
        itemBuilder: (context, index) {
          return ServiceCard(service: _services[index]);
        },
      ),
    );
  }
}