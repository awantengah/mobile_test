import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile_prog_test_2/app/modules/home/bindings/home_binding.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      initialBinding: HomeBinding(),
    );
  }
}
