import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:simpler/app/data/resources/assets_strings.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/data/user_data/user_data.dart';
import 'package:simpler/app/modules/ask_name.dart/controllers/ask_name_dart_controller.dart';
import 'package:simpler/app/routes/app_pages.dart';
import 'package:simpler/app/views/animations/fade_animation.dart';
import 'package:simpler/app/views/custom%20widgets/avatar_choices.dart';
import 'package:simpler/app/views/custom%20widgets/back_appbar.dart';
import 'package:simpler/app/views/custom%20widgets/custom_heading.dart';
import 'package:simpler/app/views/custom%20widgets/custom_shape.dart';

import '../controllers/choose_avatar_controller.dart';

class ChooseAvatarView extends GetView<ChooseAvatarController> {
  ChooseAvatarView({Key? key}) : super(key: key);

  final nameController =
      Get.put<AskNameDartController>(AskNameDartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BackAppBar(title: '', actions: null),
        body: _mainBody(context));
  }

  Widget _mainBody(BuildContext context) {
    final List<Widget> _maleAvatar = [
      AvatarChoices(
          assetString: AssetIcons.male1,
          onTap: () => controller.saveUserAvatar(AssetIcons.male1)),
      AvatarChoices(
          assetString: AssetIcons.male2,
          onTap: () => controller.saveUserAvatar(AssetIcons.male2)),
      AvatarChoices(
          assetString: AssetIcons.male3,
          onTap: () => controller.saveUserAvatar(AssetIcons.male3)),
      AvatarChoices(
          assetString: AssetIcons.male4,
          onTap: () => controller.saveUserAvatar(AssetIcons.male4)),
      AvatarChoices(
          assetString: AssetIcons.male5,
          onTap: () => controller.saveUserAvatar(AssetIcons.male5)),
    ];
    final List<Widget> _femaleAvatar = [
      AvatarChoices(
          assetString: AssetIcons.female1,
          onTap: () => controller.saveUserAvatar(AssetIcons.female1)),
      AvatarChoices(
          assetString: AssetIcons.female2,
          onTap: () => controller.saveUserAvatar(AssetIcons.female2)),
      AvatarChoices(
          assetString: AssetIcons.female3,
          onTap: () => controller.saveUserAvatar(AssetIcons.female3)),
      AvatarChoices(
          assetString: AssetIcons.female4,
          onTap: () => controller.saveUserAvatar(AssetIcons.female4)),
      AvatarChoices(
          assetString: AssetIcons.female5,
          onTap: () => controller.saveUserAvatar(AssetIcons.female5)),
    ];
    return SafeArea(
      child: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Heading(heading: 'Pick Avatar'),
                const SizedBox(height: 20),
                PickedAvatar(
                    nameController: nameController, controller: controller),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [..._maleAvatar, ..._femaleAvatar],
                ),
                const SizedBox(height: 30),
                controller.showBtn.isTrue
                    ? FadeAnimation(
                        duration: const Duration(milliseconds: 500),
                        child: Center(
                          child: CustomShape(
                              borderRadius: BorderRadius.circular(30),
                              borderRadius2: BorderRadius.circular(30),
                              boxShape: BoxShape.rectangle,
                              shadowColor: ColorRes.purpleSecondaryBtnColor,
                              onTap: () {
                                UserDataDetails().loginUser(
                                    nameController.userNameController.text,
                                    controller.userAvatar.value,
                                    true);
                                Get.toNamed(Routes.HOME);
                              },
                              padding: const EdgeInsets.all(15),
                              child: Text(
                                'Continue',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              gradientColor: ColorRes.purpleSecondaryBtnColor),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            );
          }),
        ),
      ),
    );
  }
}

class PickedAvatar extends StatelessWidget {
  const PickedAvatar({
    Key? key,
    required this.nameController,
    required this.controller,
  }) : super(key: key);

  final AskNameDartController nameController;
  final ChooseAvatarController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: 'Hey ',
            style: Theme.of(context).textTheme.caption,
            children: <TextSpan>[
              TextSpan(
                  text: nameController.userNameController.text,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
              TextSpan(
                text: ', Pick an avatar for you',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
        const Spacer(),
        CircleAvatar(
          radius: 25.0,
          backgroundColor: ColorRes.purpleSecondaryBtnColor,
          child: Center(
            child: Image.asset(
              controller.onTap.isTrue
                  ? controller.userAvatar.value
                  : AssetIcons.male1,
              fit: BoxFit.contain,
              height: 35,
              width: 35,
            ),
          ),
        ),
      ],
    );
  }
}

class BackBar extends StatelessWidget {
  const BackBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: CircleAvatar(
            radius: 13.0,
            backgroundColor: ColorRes.pureWhite,
            child: FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: ColorRes.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
