import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simpler/app/data/resources/assets_strings.dart';

import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/routes/app_pages.dart';
import 'package:simpler/app/views/animations/fade_animation.dart';
import 'package:simpler/app/views/custom%20widgets/Text_type_field.dart';
import 'package:simpler/app/views/custom%20widgets/custom_heading.dart';
import 'package:simpler/app/views/custom%20widgets/custom_shape.dart';
import 'package:simpler/app/views/custom%20widgets/form_field_heading.dart';

import '../controllers/ask_name_dart_controller.dart';

class AskNameDartView extends GetView<AskNameDartController> {
  const AskNameDartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _mainBody(context));
  }

  Widget _mainBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Row(
                  children: [
                    const Heading(heading: 'Enter Name'),
                    const Spacer(),
                    Hero(
                        tag: 'logo',
                        child: SizedBox(
                            height: 50,
                            width: 50,
                            child: Image.asset(AssetIcons.brandLogo))),
                  ],
                ),
                const SizedBox(height: 30),
                const FormFieldHeading(
                  title: 'How can we call you? ______',
                ),
                Form(
                  key: controller.nameFormState,
                  child: TextTypeField(
                      task: '',
                      controller: controller.userNameController,
                      maxlines: 1,
                      validator: (val) {},
                      onSaved: (val) {},
                      textInputType: TextInputType.name),
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
                              onTap: () => Get.toNamed(Routes.CHOOSE_AVATAR),
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
                    : const SizedBox.shrink(),
              ],
            );
          }),
        ),
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
