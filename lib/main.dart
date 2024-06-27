import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:uas_ambw_c14210265/pin_code_widget.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox('mybox');
  await Hive.openBox('notes');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey[200]),
      home: const Scaffold(
        body: Center(
          child: PinCodeWidget(),
        ),
      ),
    );
  }
}
