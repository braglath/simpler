import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/data/user_data/user_data.dart';
import 'package:simpler/app/modules/home/controllers/home_controller.dart';
import 'package:simpler/app/modules/home/views/home_view.dart';
import 'package:simpler/app/modules/splash_screen/controllers/splash_screen_controller.dart';
import 'package:simpler/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:simpler/app/routes/app_pages.dart';

import '../controllers/welcome_screen_controller.dart';

class WelcomeScreenView extends GetView<WelcomeScreenController> {
  WelcomeScreenView({Key? key}) : super(key: key);

  final splashScreenController =
      Get.put<SplashScreenController>(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final pages = [
      Container(
        height: height,
        width: width,
        color: ColorRes.purpleSecondaryBtnColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              'assets/1.png',
              fit: BoxFit.cover,
            ),
            Padding(padding: const EdgeInsets.all(20.0)),
            Column(
              children: <Widget>[
                Text('Create Projects',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                Text('with',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                Text('Deadline',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
              ],
            )
          ],
        ),
      ),
      Container(
        height: height,
        width: width,
        color: ColorRes.redErrorColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              'assets/1.png',
              fit: BoxFit.cover,
            ),
            Padding(padding: const EdgeInsets.all(20.0)),
            Column(
              children: <Widget>[
                Text('We',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                Text('Notify You When',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                Text('Closer To Deadline',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
              ],
            )
          ],
        ),
      ),
      Container(
        height: height,
        width: width,
        color: ColorRes.greenProgressColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              'assets/1.png',
              fit: BoxFit.cover,
            ),
            Padding(padding: const EdgeInsets.all(20.0)),
            Column(
              children: <Widget>[
                Text('Create Tasks',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                Text('Under',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                Text('Each Project',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
              ],
            )
          ],
        ),
      ),
      Container(
        height: height,
        width: width,
        color: ColorRes.brown,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(
              'assets/1.png',
              fit: BoxFit.cover,
            ),
            Padding(padding: const EdgeInsets.all(20.0)),
            Column(
              children: <Widget>[
                Text('Manage Projects',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                Text('with',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
                Text('Ease',
                    style: Theme.of(context).textTheme.headline2?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic)),
              ],
            )
          ],
        ),
      ),
      Container(
          height: height,
          width: width,
          color: ColorRes.scaffoldBG,
          child: SplashScreenView())
    ];
    return MaterialApp(
        home: Scaffold(
            body: LiquidSwipe(
      liquidController: controller.liquidController,
      enableLoop: false,
      pages: pages,
      fullTransitionValue: 500,
      enableSideReveal: true,
      onPageChangeCallback: (activePageIndex) {
        if (activePageIndex == 4) {
          controller.liquidController!.shouldDisableGestures(disable: true);
          splashScreenController.switchScreen();
        }
      },
    )));
  }
}
