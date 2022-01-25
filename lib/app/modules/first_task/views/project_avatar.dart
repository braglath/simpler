import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simpler/app/data/resources/assets_strings.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/modules/new_project/controllers/new_project_controller.dart';
import 'package:simpler/app/modules/project_management/controllers/project_management_controller.dart';
import 'package:simpler/app/views/animations/fade_animation.dart';
import 'package:simpler/app/views/custom%20widgets/avatar_choices.dart';
import 'package:simpler/app/views/custom%20widgets/back_appbar.dart';
import 'package:simpler/app/views/custom%20widgets/custom_heading.dart';
import 'package:simpler/app/views/custom%20widgets/custom_shape.dart';
import '../controllers/project_avatar_controller.dart';

class ProjectAvatarView extends GetView<ProjectAvatarController> {
  ProjectAvatarView({Key? key}) : super(key: key);

  final projectController =
      Get.put<NewProjectController>(NewProjectController());
  final projectManagementController =
      Get.put<ProjectManagementController>(ProjectManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BackAppBar(title: '', actions: null),
        body: _mainBody(context));
  }

  Widget _mainBody(BuildContext context) {
    final List<Widget> _projectAvatar = [
      AvatarChoices(
          assetString: AssetIcons.project1,
          onTap: () => controller.saveProjectAvatar(AssetIcons.project1)),
      AvatarChoices(
          assetString: AssetIcons.project2,
          onTap: () => controller.saveProjectAvatar(AssetIcons.project2)),
      AvatarChoices(
          assetString: AssetIcons.project3,
          onTap: () => controller.saveProjectAvatar(AssetIcons.project3)),
      AvatarChoices(
          assetString: AssetIcons.project4,
          onTap: () => controller.saveProjectAvatar(AssetIcons.project4)),
      AvatarChoices(
          assetString: AssetIcons.project5,
          onTap: () => controller.saveProjectAvatar(AssetIcons.project5)),
      AvatarChoices(
          assetString: AssetIcons.project6,
          onTap: () => controller.saveProjectAvatar(AssetIcons.project6)),
      AvatarChoices(
          assetString: AssetIcons.project7,
          onTap: () => controller.saveProjectAvatar(AssetIcons.project7)),
      AvatarChoices(
          assetString: AssetIcons.project8,
          onTap: () => controller.saveProjectAvatar(AssetIcons.project8)),
      AvatarChoices(
          assetString: AssetIcons.project9,
          onTap: () => controller.saveProjectAvatar(AssetIcons.project9)),
      AvatarChoices(
          assetString: AssetIcons.project10,
          onTap: () => controller.saveProjectAvatar(AssetIcons.project10)),
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
                const Heading(heading: 'Pick Avatar'),
                const SizedBox(height: 30),
                PickedAvatar(projectController: projectController),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [..._projectAvatar],
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: TextSpan(
                      text: 'Project dealine\n',
                      style: Theme.of(context).textTheme.caption,
                      children: <TextSpan>[
                        TextSpan(
                            text: projectController.deadLine.value,
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
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
                                print(
                                    'project saved\nproject name - ${projectController.projectNameController.text}\nproject deadline - ${projectController.deadLine.value}\nproject first task - ${projectController.firstTaskController.text}');
                                controller.addProject(
                                    projectController
                                        .projectNameController.text,
                                    projectController.deadLineDate,
                                    DateTime.now(),
                                    controller.userAvatar.value);
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

class PickedAvatar extends GetView<ProjectAvatarController> {
  final NewProjectController projectController;
  const PickedAvatar({
    Key? key,
    required this.projectController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: 'Pick an avatar for your project\n',
            style: Theme.of(context).textTheme.caption,
            children: <TextSpan>[
              TextSpan(
                  text: projectController.projectNameController.text,
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          ),
        ),
        const Spacer(),
        Obx(() {
          return CircleAvatar(
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
          );
        }),
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
