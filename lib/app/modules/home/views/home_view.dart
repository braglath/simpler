import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:simpler/app/data/database/project_database.dart';
import 'package:simpler/app/data/resources/assets_strings.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/data/resources/usable_strings.dart';
import 'package:simpler/app/data/user_data/user_data.dart';
import 'package:simpler/app/routes/app_pages.dart';
import 'package:simpler/app/views/custom%20widgets/custom_heading.dart';
import 'package:simpler/app/views/custom%20widgets/custom_shape.dart';
import 'package:simpler/app/views/custom%20widgets/custom_snackbar.dart';
import 'package:simpler/app/views/custom%20widgets/floating_appbar.dart';
import 'package:simpler/app/views/custom%20widgets/total_projects_card.dart';
import 'package:simpler/app/views/ui%20widgets/projects_list.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return _homeScaffold(context, height, width);
  }

  Scaffold _homeScaffold(BuildContext context, double height, double width) =>
      Scaffold(
        backgroundColor: ColorRes.scaffoldBG,
        floatingActionButton: fabBTN(context),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(content: Text('Tap back again to exit')),
          child: SafeArea(
            child: Stack(
              children: [
                _homeBody(context),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    height: 50,
                    child: Obx(() {
                      return FloatingAppBar(
                        title: controller.date.value,
                        needBackBtn: false,
                        needAvatar: true,
                        removeActionBtn: false,
                        asset: '',
                        onActionTap: () => Get.toNamed(Routes.PROFILE_PAGE),
                        onLeadingTap: () async => await ProjectDatabase.instance
                            .close()
                            .whenComplete(
                                () => UserDataDetails().deleteUserDetails()),
                        needSearchOption: false,
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Container fabBTN(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.5),
            borderRadius: BorderRadius.circular(30),
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
        child: FloatingActionButton.extended(
          heroTag: null,
          onPressed: () => Get.toNamed(Routes.NEW_PROJECT),
          label: Text(
            'New project',
            style: Theme.of(context).textTheme.caption?.copyWith(
                color: ColorRes.pureWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          icon: const FaIcon(
            FontAwesomeIcons.plus,
            color: ColorRes.pureWhite,
            size: 18,
          ),
          enableFeedback: true,
        ));
  }

  Widget _homeBody(BuildContext context) => SafeArea(
        child: SingleChildScrollView(
          controller: controller.scrollController,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 65.0),
              child: _myTask(context),
            ),
          ),
        ),
      );

  Widget _myTask(BuildContext context) {
    final List<Widget> myProjects = [
      const Heading(heading: CommonStrings.myProjects),
      const SizedBox(height: 15),
      Obx(() {
        return TotalProjects(
          title: CommonStrings.totalProjects,
          number: controller.project.length.toString(),
          iconAsset: AssetIcons.totalProjects,
          newChild: false,
          child: const SizedBox.shrink(),
        );
      }),
      const SizedBox(height: 15),
      _myProjCompletedNPending(),
    ];

    final List<Widget> recentProjects = [
      Row(
        children: [
          const Heading(heading: CommonStrings.recentProjects),
          const Spacer(),
          GestureDetector(
            onTap: () => controller.project.isEmpty
                ? CustomSnackbar(
                        title: 'Add projects',
                        message:
                            "Add a new project by clicking on 'New Project' button at the bottom of this page")
                    .showWarning()
                : Get.toNamed(Routes.ALL_PROJECTS),
            child: Text(
              'View all',
              style: Theme.of(context).textTheme.caption?.copyWith(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          )
        ],
      ),
      const SizedBox(height: 25),
      Obx(() {
        return RecentProjects(
          itemCount: controller.project.length,
          project: controller.project,
        );
      })
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ...myProjects,
        const SizedBox(height: 30),
        _blueDivider(context),
        // EditNameField(homeController: controller),
        const SizedBox(height: 20),
        ...recentProjects
      ],
    );
  }

  Row _blueDivider(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 3,
          backgroundColor: ColorRes.purpleSecondaryBtnColor,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 50,
          height: 1,
          color: ColorRes.purpleSecondaryBtnColor,
        ),
      ],
    );
  }

  Row _myProjCompletedNPending() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() {
          return CompletedNPending(
            title: CommonStrings.pendingProjects,
            number: (controller.project.length -
                    controller.completedProjects.length)
                .toString(),
            iconAsset: AssetIcons.pendingProjects,
            color: ColorRes.brown,
          );
        }),
        Obx(() {
          return CompletedNPending(
            title: CommonStrings.completedProjects,
            number: controller.completedProjects.length.toString(),
            iconAsset: AssetIcons.completedProjects,
            color: ColorRes.greenProgressColor,
          );
        }),
      ],
    );
  }
}

class EditName {}

class CompletedNPending extends StatelessWidget {
  final String title;
  final String number;
  final String iconAsset;
  final Color color;
  const CompletedNPending(
      {Key? key,
      required this.title,
      required this.number,
      required this.iconAsset,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShape(
        borderRadius: BorderRadius.circular(30),
        borderRadius2: BorderRadius.circular(30),
        boxShape: BoxShape.rectangle,
        shadowColor: color,
        onTap: () => print('pending and completed tapped'),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              iconAsset,
              width: 50,
              height: 50,
            ),
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(width: 5),
                Text(
                  number,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        gradientColor: color);
  }
}
