import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uas_ambw_c14210265/pin_code_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    _myBox = Hive.box('mybox');
  }

  var _myBox;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Notes App'.text.size(35).fontWeight(FontWeight.w600).make(),
            10.heightBox,
            const Divider(),
            10.heightBox,
            'Security'.text.size(18).make(),
            TextButton(
                onPressed: () {
                  _myBox.delete('pin');
                  Get.offAll(() => const PinCodeWidget());
                },
                style: TextButton.styleFrom(foregroundColor: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'Change Password'.text.size(18).make(),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
