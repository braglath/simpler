import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ChooseAvatarController extends GetxController {
  final TextEditingController userAvatarController = TextEditingController();
  final showBtn = false.obs;
  final userAvatar = ''.obs;
  final onTap = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void saveUserAvatar(String asset) {
    userAvatar.value = asset;
    onTap.value = true;
    showBtn.value = true;
  }
}
