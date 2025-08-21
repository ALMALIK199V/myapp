import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techfix_pro/config/app_router.dart';
import 'package:techfix_pro/config/theme.dart';
import 'package:techfix_pro/modules/auth/bloc/auth_bloc.dart';
import 'package:techfix_pro/modules/marketplace/bloc/cart_bloc.dart';
import 'package:techfix_pro/modules/repair/bloc/repair_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => RepairBloc()),
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: MaterialApp.router(
        title: 'TechFix Pro',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale('ar')],
      ),
    );
  }
}