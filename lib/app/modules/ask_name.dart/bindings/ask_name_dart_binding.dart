import 'package:get/get.dart';

import '../controllers/ask_name_dart_controller.dart';

class AskNameDartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AskNameDartController>(
      () => AskNameDartController(),
    );
  }
}
