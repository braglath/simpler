import 'package:get/get.dart';
import 'package:simpler/app/data/user_data/user_data.dart';
import 'package:simpler/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final isLoaded = false.obs;
  @override
  void onInit() {
    super.onInit();
    // Future.delayed(const Duration(seconds: 2), () {
    //   // Get.offAllNamed(Routes.WELCOME_SCREEN);

    //     UserDataDetails().readUserLoggedIn() == false
    //         ? Get.offNamed(Routes.ASK_NAME_DART)
    //         : Get.offNamed(Routes.HOME);
    // }).then((value) => isLoaded.value = true);
  }

  void switchScreen() {
    Future.delayed(const Duration(milliseconds: 200), () {
      UserDataDetails().readUserLoggedIn() == false
          ? Get.offNamed(Routes.ASK_NAME_DART)
          : Get.offNamed(Routes.HOME);
    }).then((value) => isLoaded.value = true);
  }
}
