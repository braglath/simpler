import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:simpler/app/data/resources/colour_resources.dart';

class CustomSnackbar {
  String title;
  String message;
  CustomSnackbar({required this.title, required this.message});
  void showWarning() {
    Get.closeAllSnackbars();
    Get.snackbar('', '',
        isDismissible: true,
        backgroundColor: ColorRes.scaffoldBG,
        icon: const CircleAvatar(
          backgroundColor: ColorRes.pureWhite,
          child: Icon(
            Icons.warning_sharp,
            color: ColorRes.redErrorColor,
            size: 25,
          ),
        ),
        messageText: Text(message,
            style: const TextStyle(
                color: ColorRes.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        shouldIconPulse: true,
        colorText: ColorRes.textColor,
        titleText: Text(title,
            style: const TextStyle(
                color: ColorRes.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 17)));
  }

  void showSuccess() {
    Get.closeAllSnackbars();
    Get.snackbar('', '',
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        backgroundColor: ColorRes.scaffoldBG,
        icon: const CircleAvatar(
          backgroundColor: ColorRes.pureWhite,
          child: Icon(
            Icons.done,
            color: ColorRes.greenProgressColor,
            size: 35,
          ),
        ),
        messageText: Text(message,
            style: const TextStyle(
                color: ColorRes.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        shouldIconPulse: true,
        colorText: ColorRes.textColor,
        titleText: Text(title,
            style: const TextStyle(
                color: ColorRes.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 17)));
  }
}
