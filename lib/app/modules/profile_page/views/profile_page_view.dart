import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/data/user_data/user_data.dart';
import 'package:simpler/app/modules/home/controllers/home_controller.dart';
import 'package:simpler/app/routes/app_pages.dart';
import 'package:simpler/app/views/custom%20widgets/custom_heading.dart';
import 'package:simpler/app/views/custom%20widgets/custom_profileImage.dart';
import 'package:simpler/app/views/custom%20widgets/floating_appbar.dart';

import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  ProfilePageView({Key? key}) : super(key: key);

  final homeController = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    return _scaffold(context);
  }

  Widget _scaffold(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              _body(context),
              _appbar(),
            ],
          ),
        ),
      );

  Padding _appbar() => Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: 50,
          child: Obx(() {
            return FloatingAppBar(
              title: homeController.date.value,
              needBackBtn: true,
              needAvatar: false,
              removeActionBtn: true,
              asset: '',
              onActionTap: () => Get.toNamed(Routes.PROFILE_PAGE),
              onLeadingTap: () => Get.back(),
            );
          }),
        ),
      );
}

Widget _body(BuildContext context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: _profile(),
          ),
          Expanded(flex: 2, child: _editCards(context)),
          const Expanded(flex: 1, child: SizedBox.shrink()),
        ],
      ),
    );

Widget _profile() => Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomProfileImage(
          asset: UserDataDetails().readUserAvatar(),
          needAvatar: true,
          onProfileTap: () {},
          circleRadius: 50,
          imageHeight: 75,
          imageWidth: 75,
        ),
        const SizedBox(height: 15),
        Heading(heading: UserDataDetails().readUserName()),
        const SizedBox(height: 25),
      ],
    );

Widget _editCards(BuildContext context) => Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _editProfile(
            context,
            'Edit profile',
            'Change your profile info like name and avatar',
            () => 'edit profile clicked'),
        _editProfile(context, 'Clear data',
            'Clear all data and logout of the app', () => 'clear data clicked'),
      ],
    );

Widget _editProfile(
    BuildContext context, String title, String caption, Function()? onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
              colors: [Colors.white, ColorRes.purpleSecondaryBtnColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                blurRadius: 10,
                color: ColorRes.purpleSecondaryBtnColor.withOpacity(0.8),
                spreadRadius: 0)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline3?.copyWith(
                  fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 10),
            Text(
              caption,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption?.copyWith(
                  fontWeight: FontWeight.bold, color: ColorRes.pureWhite),
            ),
          ],
        ),
      ),
    ),
  );
}
