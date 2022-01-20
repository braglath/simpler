import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:simpler/app/data/database/project_database.dart';

import 'package:simpler/app/data/resources/assets_strings.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/data/user_data/user_data.dart';
import 'package:simpler/app/modules/home/controllers/home_controller.dart';
import 'package:simpler/app/views/animations/fade_animation.dart';
import 'package:simpler/app/views/custom%20widgets/custom_shape.dart';

class FloatingAppBar extends StatelessWidget {
  final String date;
  FloatingAppBar({Key? key, required this.date}) : super(key: key);

  final homeController = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    return CustomShape(
        borderRadius: BorderRadius.circular(10),
        borderRadius2: BorderRadius.circular(10),
        boxShape: BoxShape.rectangle,
        shadowColor: ColorRes.purpleSecondaryBtnColor,
        onTap: () => print('total projects'),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            CustomLeadingWidget(onLeadingTap: () async {
              await ProjectDatabase.instance
                  .close()
                  .whenComplete(() => UserDataDetails().deleteUserDetails());
            }),
            const SizedBox(width: 10),
            FadeAnimation(
              duration: const Duration(milliseconds: 500),
              child: AutoSizeText(
                date,
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            const Spacer(),
            CustomProfileImage(onProfileTap: () {
              homeController.animatedContainer();
            })
          ],
        ),
        gradientColor: ColorRes.scaffoldBG);
  }
}

class CustomProfileImage extends StatelessWidget {
  final Function()? onProfileTap;
  const CustomProfileImage({Key? key, required this.onProfileTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onProfileTap,
      child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 15,
          child: Image.asset(
            UserDataDetails().readUserAvatar(),
            fit: BoxFit.contain,
            height: 25,
            width: 25,
          )),
    );
  }
}

class CustomLeadingWidget extends StatelessWidget {
  final Function()? onLeadingTap;
  const CustomLeadingWidget({Key? key, required this.onLeadingTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLeadingTap,
      child: Center(
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: ColorRes.pureWhite,
              radius: 15,
              child: CircleAvatar(
                radius: 13.0,
                backgroundColor: ColorRes.pureWhite,
                child: Center(
                  child: Image.asset(
                    AssetIcons.drawer,
                    color: ColorRes.textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
