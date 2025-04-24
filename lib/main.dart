import 'package:flutter/material.dart';
import 'package:gardmei_backend_demo/presentation/device_listing_page.dart';
import 'package:gardmei_backend_demo/presentation/devices_page.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DeviceListScreen(),
    );
  }
}
