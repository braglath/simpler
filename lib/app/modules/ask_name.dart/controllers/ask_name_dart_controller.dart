import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

class AskNameDartController extends GetxController {
  final TextEditingController userNameController = TextEditingController();
  final GlobalKey<FormState> nameFormState = GlobalKey<FormState>();
  final showBtn = false.obs;
  @override
  void onInit() {
    super.onInit();
    userNameController.addListener(() {
      if (userNameController.text != '') {
        showBtn.value = true;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
