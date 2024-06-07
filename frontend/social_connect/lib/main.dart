import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_connect/views/register_screen.dart';
import 'views/login_view.dart';
import 'views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter GetX Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginView()),
        GetPage(name: '/register', page: () => RegisterView()),
        GetPage(
            name: '/home',
            page: () => HomeView()), // Thêm HomeView vào getPages
      ],
    );
  }
}
