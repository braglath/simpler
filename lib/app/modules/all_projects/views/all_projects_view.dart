import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/data/user_data/user_data.dart';
import 'package:simpler/app/routes/app_pages.dart';
import 'package:simpler/app/views/custom%20widgets/custom_heading.dart';
import 'package:simpler/app/views/custom%20widgets/floating_appbar.dart';
import 'package:simpler/app/views/custom%20widgets/separator.dart';
import 'package:simpler/app/views/ui%20widgets/choice_chip_filter.dart';
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
                AllProjectsAppBar(controller: controller),
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
          physics: const BouncingScrollPhysics(),
          controller: controller.allProjectScrollController,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 65.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _searchRow(context),
                  const Separator(),
                  // const SizedBox(height: 15),
                  FilterCard(controller: controller),
                  Obx(() {
                    return SizedBox(
                        height: controller.filterTapped.isFalse ? 0 : 15);
                  }),
                  _headings(),
                  const SizedBox(height: 25),
                  _projects()
                ],
              ),
            ),
          ),
        ),
      );

  Obx _projects() {
    return Obx(() {
      return controller.allProjectsList.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(50.0),
              child: Center(child: Heading(heading: 'Nothing to show here')),
            )
          : RecentProjects(
              itemCount: controller.allProjectsList.length,
              project: controller.allProjectsList,
            );
    });
  }

  Obx _headings() {
    return Obx(() {
      return Heading(
          heading: controller.choiceChipValue.value == 0
              ? 'All Projects'
              : controller.choiceChipValue.value == 1
                  ? 'Completed Projects'
                  : 'Pending Projects');
    });
  }

  Row _searchRow(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            child: const ChoiceChipFilter()),
        const Spacer(),
        Container(
          height: 30,
          width: 2,
          color: ColorRes.textColor,
        ),
        const Spacer(),
        const SizedBox(width: 5),
        Obx(() {
          return CircleAvatar(
            backgroundColor: controller.filterTapped.isFalse
                ? ColorRes.pureWhite
                : ColorRes.purpleSecondaryBtnColor,
            radius: 15,
            child: IconButton(
                onPressed: () => {
                      controller.showPicker = !controller.showPicker,
                      controller.filterTapped.value =
                          !controller.filterTapped.value,
                      if (controller.showPicker)
                        {controller.animationController.forward()}
                      else
                        {controller.animationController.reverse()}
                    }, //? for search view
                splashRadius: 15,
                icon: FaIcon(
                  FontAwesomeIcons.sortAmountDown,
                  color: controller.filterTapped.isFalse
                      ? ColorRes.textColor
                      : ColorRes.pureWhite,
                  size: 15,
                )),
          );
        }),
        // const SizedBox(width: 5),
        // IconButton(
        //     onPressed: () {}, //? for calender view
        //     splashRadius: 15,
        //     icon: const FaIcon(
        //       FontAwesomeIcons.calendarAlt,
        //       color: ColorRes.textColor,
        //       size: 25,
        //     )),
      ],
    );
  }
}

class AllProjectsAppBar extends StatelessWidget {
  const AllProjectsAppBar({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AllProjectsController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              onActionTap: () => print('search icon tapped'),
              onLeadingTap: () => Get.back(),
              needSearchOption: true);
        }),
      ),
    );
  }
}

class FilterCard extends StatelessWidget {
  const FilterCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final AllProjectsController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorRes.purpleSecondaryBtnColor,
      elevation: 4,
      shadowColor: ColorRes.purpleSecondaryBtnColor,
      child: SizeTransition(
        sizeFactor: controller.animationController,
        child: Obx(() => Theme(
              data: Theme.of(context)
                  .copyWith(unselectedWidgetColor: ColorRes.textColor),
              child: CheckboxListTile(
                enableFeedback: true,
                value: controller.showOrderby.value,
                onChanged: (val) =>
                    controller.getPendingProjectsinDESCorder(val!),
                activeColor: ColorRes.pureWhite,
                checkColor: ColorRes.textColor,
                title: Text(
                  controller.choiceChipIndex.value == 0 ||
                          controller.choiceChipIndex.value == 1
                      ? 'Order by ascending..'
                      : 'Order by descending..',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ),
    );
  }
}
