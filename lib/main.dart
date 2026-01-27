import 'package:clg_event_management_new/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'College Event App',
      theme: ThemeData(
        primaryColor: const Color(0xFF1E7F78),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: AppRoutes.login,
      getPages: AppPages.pages,
    );
  }
}




