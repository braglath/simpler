import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/data/user_data/user_data.dart';
import 'package:simpler/app/routes/app_pages.dart';
import 'package:simpler/app/views/custom%20widgets/custom_heading.dart';
import 'package:simpler/app/views/custom%20widgets/floating_appbar.dart';
import 'package:simpler/app/views/ui%20widgets/projects_list.dart';
import '../controllers/all_projects_controller.dart';

class AllProjectsView extends GetView<AllProjectsController> {
  const AllProjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _allProjectScaffold(context);
  }

  Widget _allProjectScaffold(BuildContext context) => Obx(() {
        return Scaffold(
          floatingActionButton: _fab(),
          backgroundColor: ColorRes.scaffoldBG,
          body: SafeArea(
            child: Stack(
              children: [
                _mainBody(context),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 50,
                    child: Obx(() {
                      return FloatingAppBar(
                        title: controller.date.value,
                        needBackBtn: true,
                        needAvatar: false,
                        removeActionBtn: false,
                        asset: UserDataDetails().readUserAvatar(),
                        onActionTap: () => Get.toNamed(Routes.PROFILE_PAGE),
                        onLeadingTap: () => Get.back(),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      });

  Widget _fab() {
    return controller.allProjectsList.length > 5
        ? FloatingActionButton(
            mini: true,
            child: FaIcon(
              controller.scrollToBottom.isTrue
                  ? FontAwesomeIcons.chevronDown
                  : FontAwesomeIcons.chevronUp,
              color: ColorRes.pureWhite,
            ),
            onPressed: () => controller.scroll(),
          )
        : const SizedBox.shrink();
  }

  Widget _mainBody(BuildContext context) => SafeArea(
        child: SingleChildScrollView(
          controller: controller.allProjectScrollController,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 65.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Heading(heading: 'All Projects'),
                  const SizedBox(height: 25),
                  Obx(() {
                    return RecentProjects(
                      itemCount: controller.allProjectsList.length,
                      project: controller.allProjectsList,
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      );
}
