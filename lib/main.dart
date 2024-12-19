import 'package:flutter/material.dart';
import 'package:komdigi_logbooks_admins/core/constants/constants.dart';
import 'package:komdigi_logbooks_admins/presentation/auth/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        dividerTheme:
            DividerThemeData(color: AppColors.primary.withOpacity(0.5)),
        dialogTheme: const DialogTheme(elevation: 0),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.white),
          centerTitle: true,
          color: AppColors.primary,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: AppColors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
