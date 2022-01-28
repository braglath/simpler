import 'package:flutter/material.dart';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import 'package:simpler/app/data/resources/assets_strings.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/modules/home/views/home_view.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  SplashScreenView({Key? key}) : super(key: key);

  final splashController =
      Get.put<SplashScreenController>(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 125,
        width: 125,
        child: Image.asset(AssetIcons.brandLogo),
      ),
    );
  }
}
