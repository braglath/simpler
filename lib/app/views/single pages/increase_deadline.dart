import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simpler/app/data/model/project_model.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/modules/home/controllers/home_controller.dart';
import 'package:simpler/app/modules/new_project/controllers/new_project_controller.dart';
import 'package:simpler/app/views/animations/fade_animation.dart';
import 'package:simpler/app/views/custom%20widgets/back_appbar.dart';
import 'package:simpler/app/views/custom%20widgets/custom_heading.dart';
import 'package:simpler/app/views/custom%20widgets/custom_shape.dart';

class IncreaseDeadline extends StatelessWidget {
  IncreaseDeadline({Key? key}) : super(key: key);

  final homeController = Get.put<HomeController>(HomeController());
  final newprojectController =
      Get.put<NewProjectController>(NewProjectController());

  final Project project = Get.arguments;

  // String get projectId => 'projectId';
  // String get projectAvatar => 'projectAvatar';
  // String get projectIsCompleted => 'projectIsCompleted';
  // String get projectTitle => 'projectTitle';
  // String get projectDeadline => 'projectDeadline';
  // String get projectCreatedTime => 'projectCreatedTime';
  // String get projectCompletedTime => 'projectCompletedTime';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BackAppBar(title: '', actions: null),
        body: Obx(() {
          return Stack(
            children: [
              _mainBody(context),
              newprojectController.isLoading.isTrue
                  ? const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: ColorRes.brown,
                        color: ColorRes.purpleSecondaryBtnColor,
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          );
        }));
  }

  Widget _mainBody(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Heading(heading: 'Add a Deadline'),
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  text: 'Your project ',
                  style: Theme.of(context).textTheme.caption,
                  children: <TextSpan>[
                    TextSpan(
                        text: '${project.title}, ',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    TextSpan(
                      text: 'needs a deadline',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Heading(
                    heading: newprojectController.deadLine.value,
                  ),
                  CustomShape(
                      borderRadius: BorderRadius.circular(30),
                      borderRadius2: BorderRadius.circular(30),
                      boxShape: BoxShape.rectangle,
                      shadowColor: ColorRes.purpleSecondaryBtnColor,
                      onTap: () => newprojectController.datePicker(context),
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        'Select Date',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ColorRes.textColor,
                            fontSize: 12),
                      ),
                      gradientColor: ColorRes.purpleSecondaryBtnColor),
                ],
              ),
              const SizedBox(height: 30),
              newprojectController.showBtn3.isTrue
                  ? FadeAnimation(
                      duration: const Duration(milliseconds: 500),
                      child: Center(
                        child: CustomShape(
                            borderRadius: BorderRadius.circular(30),
                            borderRadius2: BorderRadius.circular(30),
                            boxShape: BoxShape.rectangle,
                            shadowColor: ColorRes.purpleSecondaryBtnColor,
                            onTap: () =>
                                newprojectController.changeProjectDeadline(
                                    project.id!,
                                    project.avatar,
                                    project.title,
                                    newprojectController.deadLineDate,
                                    project.createdTime,
                                    project.completedTime),
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
