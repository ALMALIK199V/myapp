import 'package:flutter/material.dart';
import 'package:techfix_app/models/repair_order_model.dart';

class NewOrderScreen extends StatefulWidget {
  const NewOrderScreen({super.key});

  @override
  State<NewOrderScreen> createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _deviceTypeController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _problemController = TextEditingController();
  
  String _selectedDeviceType = 'هاتف';
  String _selectedBrand = 'Apple';
  bool _warrantyRequired = false;
  bool _remoteSupportPossible = false;

  final List<String> _deviceTypes = ['هاتف', 'لابتوب', 'كمبيوتر', 'طابعة', 'تابلت', 'أخرى'];
  final List<String> _phoneBrands = ['Apple', 'Samsung', 'Huawei', 'Xiaomi', 'Oppo', 'Vivo', 'Google', 'أخرى'];
  final List<String> _laptopBrands = ['Apple', 'Dell', 'HP', 'Lenovo', 'Asus', 'Acer', 'Microsoft', 'أخرى'];

  @override
  void dispose() {
    _deviceTypeController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _problemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طلب صيانة جديد'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'معلومات الجهاز',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              
              const SizedBox(height: 20),
              
              // نوع الجهاز
              DropdownButtonFormField<String>(
                value: _selectedDeviceType,
                decoration: InputDecoration(
                  labelText: 'نوع الجهاز',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedDeviceType = newValue!;
                    _selectedBrand = 'Apple'; // Reset brand selection
                  });
                },
              ),
              
              const SizedBox(height: 20),
              
              // الشركة المصنعة
              DropdownButtonFormField<String>(
                value: _selectedBrand,
                decoration: InputDecoration(
                  labelText: 'الشركة المصنعة',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: (_selectedDeviceType == 'هاتف' ? _phoneBrands : _laptopBrands)
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedBrand = newValue!;
                  });
                },
              ),
              
              const SizedBox(height: 20),
              
              // الموديل
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(
                  labelText: 'موديل الجهاز',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى إدخال موديل الجهاز';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              
              // وصف المشكلة
              TextFormField(
                controller: _problemController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'وصف المشكلة',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'يرجى وصف المشكلة';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              
              const Text(
                'خيارات إضافية',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              
              const SizedBox(height: 15),
              
              // الضمان
              SwitchListTile(
                title: const Text('الضمان على الصيانة (30 يوم)'),
                subtitle: const Text('رسوم إضافية: 50 درهم'),
                value: _warrantyRequired,
                onChanged: (value) {
                  setState(() {
                    _warrantyRequired = value;
                  });
                },
              ),
              
              // الصيانة عن بعد
              SwitchListTile(
                title: const Text('محاولة الصيانة عن بُعد أولاً'),
                subtitle: const Text('سيحاول الفني إصلاح المشكلة عن بعد إن أمكن'),
                value: _remoteSupportPossible,
                onChanged: (value) {
                  setState(() {
                    _remoteSupportPossible = value;
                  });
                },
              ),
              
              const SizedBox(height: 30),
              
              // زر إنشاء الطلب
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // إنشاء طلب الصيانة
                      final newOrder = RepairOrder(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        customerId: 'current_user_id', // سيتم استبدالها بـ ID المستخدم الفعلي
                        deviceType: _selectedDeviceType,
                        brand: _selectedBrand,
                        model: _modelController.text,
                        problemDescription: _problemController.text,
                        status: OrderStatus.pending,
                        createdAt: DateTime.now(),
                        warrantyDays: _warrantyRequired ? 30 : null,
                      );
                      
                      // حفظ الطلب والانتقال إلى شاشة المتابعة
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'إنشاء طلب الصيانة',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}