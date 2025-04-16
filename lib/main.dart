import 'package:doanthuchanh/Page/cart/countCard.dart';
import 'package:doanthuchanh/Page/cart/productVMS.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doanthuchanh/Page/auth/login.dart';
import 'package:doanthuchanh/value/app_color.dart';
import 'package:doanthuchanh/layout/homePage.dart';
import 'package:doanthuchanh/model/history/history_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:doanthuchanh/Page/Trangchu/TrangChu2.dart'; // Import Trangchu2.dart

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProductsVM(),
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: AppColors.primaryColor),
      home: LoginScreen(), // Thiết lập trang chủ là LoginScreen
    );
  }
}
