import 'package:get/get.dart';

import '../controllers/main_splash_screen_controller.dart';

class MainSplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainSplashScreenController>(
      () => MainSplashScreenController(),
    );
  }
}
