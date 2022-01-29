import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simpler/app/data/resources/assets_strings.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/modules/home/views/home_view.dart';

import '../controllers/main_splash_screen_controller.dart';

class MainSplashScreenView extends GetView<MainSplashScreenController> {
   MainSplashScreenView({Key? key}) : super(key: key);
  final mainSplashScreenController = Get.put<MainSplashScreenController>(MainSplashScreenController());

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: ColorRes.scaffoldBG,
      duration: 500,
      splash: Hero(
          tag: 'logo',
          child: SizedBox(
              height: 125,
              width: 125,
              child: Image.asset(AssetIcons.brandLogo))),
      splashIconSize: 200,
      nextScreen: const HomeView(),
      disableNavigation: true,
      pageTransitionType: PageTransitionType.scale,
    );
  }
}
