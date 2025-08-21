import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techfix_pro/modules/payment/bloc/payment_bloc.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('الدفع')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildPaymentMethod('بطاقة ائتمان', Icons.credit_card),
            _buildPaymentMethod('الدفع عند الاستلام', Icons.money),
            _buildPaymentMethod('محفظة إلكترونية', Icons.wallet),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {},
    );
  }
}