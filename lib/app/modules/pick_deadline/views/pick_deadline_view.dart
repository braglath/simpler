import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/modules/new_project/controllers/new_project_controller.dart';
import 'package:simpler/app/routes/app_pages.dart';
import 'package:simpler/app/views/animations/fade_animation.dart';
import 'package:simpler/app/views/custom%20widgets/back_appbar.dart';
import 'package:simpler/app/views/custom%20widgets/custom_heading.dart';
import 'package:simpler/app/views/custom%20widgets/custom_shape.dart';
import 'package:simpler/app/views/custom%20widgets/form_field_heading.dart';

import '../controllers/pick_deadline_controller.dart';

class PickDeadlineView extends GetView<PickDeadlineController> {
  final projectController =
      Get.put<NewProjectController>(NewProjectController());

  PickDeadlineView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BackAppBar(title: '', actions: null),
        body: _mainBody(context));
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
              projectController.projectNameController.text.isNotEmpty
                  ? RichText(
                      text: TextSpan(
                        text: 'Your project ',
                        style: Theme.of(context).textTheme.caption,
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  '${projectController.projectNameController.text}, ',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                          TextSpan(
                            text: 'needs a deadline',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    )
                  : const FormFieldHeading(
                      title: 'Pick a project name first',
                    ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Heading(
                    heading: projectController.deadLine.value,
                  ),
                  CustomShape(
                      borderRadius: BorderRadius.circular(30),
                      borderRadius2: BorderRadius.circular(30),
                      boxShape: BoxShape.rectangle,
                      shadowColor: ColorRes.purpleSecondaryBtnColor,
                      onTap: () => projectController.datePicker(context),
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
              projectController.showBtn3.isTrue
                  ? FadeAnimation(
                      duration: const Duration(milliseconds: 500),
                      child: Center(
                        child: CustomShape(
                            borderRadius: BorderRadius.circular(30),
                            borderRadius2: BorderRadius.circular(30),
                            boxShape: BoxShape.rectangle,
                            shadowColor: ColorRes.purpleSecondaryBtnColor,
                            onTap: () => Get.toNamed(Routes.FIRST_TASK),
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
