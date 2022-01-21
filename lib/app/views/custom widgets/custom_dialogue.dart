import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:simpler/app/data/resources/colour_resources.dart';

class CustomDialogue {
  String title;
  String textConfirm;
  String textCancel;
  Function()? onpressedConfirm;
  Function()? onpressedCancel;
  Widget? contentWidget;
  bool isDismissible;
  CustomDialogue(
      {required this.title,
      required this.textConfirm,
      required this.textCancel,
      required this.onpressedConfirm,
      required this.onpressedCancel,
      required this.contentWidget,
      required this.isDismissible});

  void showDialogue() {
    Get.defaultDialog(
        barrierDismissible: isDismissible,
        title: title,
        backgroundColor: ColorRes.scaffoldBG,
        titleStyle: const TextStyle(
          color: ColorRes.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        buttonColor: ColorRes.purpleSecondaryBtnColor,
        confirm: ElevatedButton(
            onPressed: onpressedConfirm, child: Text(textConfirm)),
        cancel:
            ElevatedButton(onPressed: onpressedCancel, child: Text(textCancel)),
        radius: 12,
        content:
            contentWidget == null ? const SizedBox.shrink() : contentWidget);
  }
}
