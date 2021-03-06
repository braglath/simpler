import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simpler/app/data/resources/assets_strings.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/modules/all_projects/controllers/all_projects_controller.dart';
import 'package:simpler/app/modules/home/controllers/home_controller.dart';
import 'package:simpler/app/views/animations/fade_animation.dart';
import 'package:simpler/app/views/custom%20widgets/Text_type_field.dart';
import 'package:simpler/app/views/custom%20widgets/custom_profileImage.dart';
import 'package:simpler/app/views/custom%20widgets/custom_shape.dart';

class FloatingAppBar extends StatelessWidget {
  final String title;
  final bool needBackBtn;
  final bool needAvatar;
  final bool removeActionBtn;
  final Function()? onLeadingTap;
  final Function()? onActionTap;
  final bool needSearchOption;

  final String asset;
  FloatingAppBar(
      {Key? key,
      required this.title,
      required this.needBackBtn,
      required this.needAvatar,
      required this.onLeadingTap,
      required this.onActionTap,
      required this.asset,
      required this.removeActionBtn,
      required this.needSearchOption})
      : super(key: key);

  final homeController = Get.put<HomeController>(HomeController());
  final allProjectsController =
      Get.put<AllProjectsController>(AllProjectsController());

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
            CustomLeadingWidget(
              onLeadingTap: onLeadingTap,
              needBackBtn: needBackBtn,
            ),
            const SizedBox(width: 10),
            needSearchOption
                ? SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 130,
                    child: TextTypeField(
                      controller: allProjectsController.projectNameController,
                      maxlines: 1,
                      onSaved: (String? val) {},
                      task: '',
                      textInputType: TextInputType.name,
                      validator: (String? val) {},
                    ),
                  )
                : FadeAnimation(
                    duration: const Duration(milliseconds: 500),
                    child: AutoSizeText(
                      title,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
            const Spacer(),
            !removeActionBtn
                ? CustomProfileImage(
                    needAvatar: needAvatar,
                    onProfileTap: onActionTap,
                    asset: asset,
                    circleRadius: 15,
                    imageHeight: 25,
                    imageWidth: 25,
                    needSearchIcon: needSearchOption,
                  )
                : const SizedBox.shrink()
          ],
        ),
        gradientColor: ColorRes.scaffoldBG);
  }
}

class CustomLeadingWidget extends StatelessWidget {
  final Function()? onLeadingTap;
  final bool needBackBtn;
  const CustomLeadingWidget(
      {Key? key, required this.onLeadingTap, required this.needBackBtn})
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
                  child: needBackBtn
                      ? const FaIcon(
                          FontAwesomeIcons.chevronLeft,
                          color: ColorRes.textColor,
                        )
                      : Image.asset(
                          AssetIcons.brandLogo,
                          // color: ColorRes.textColor,
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
