import 'package:get/get.dart';

import '../controllers/choose_avatar_controller.dart';

class ChooseAvatarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseAvatarController>(
      () => ChooseAvatarController(),
    );
  }
}
