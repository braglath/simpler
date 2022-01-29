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
import 'package:table_calendar/table_calendar.dart';
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
                  _searchRow(),
                  const Separator(),
                  // const SizedBox(height: 15),
                  Card(
                    color: ColorRes.pureWhite,
                    elevation: 4,
                    shadowColor: ColorRes.purpleSecondaryBtnColor,
                    child: SizeTransition(
                      sizeFactor: controller.animationController,
                      child: TableCalendar(
                        firstDay: DateTime.utc(2010, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        focusedDay: DateTime.now(),
                        calendarFormat: CalendarFormat.week,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(() {
                    return Heading(
                        heading: controller.choiceChipValue.value == 0
                            ? 'All Projects'
                            : controller.choiceChipValue.value == 1
                                ? 'Completed Projects'
                                : 'Pending Projects');
                  }),
                  const SizedBox(height: 25),
                  Obx(() {
                    return controller.allProjectsList.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(50.0),
                            child: Center(
                                child:
                                    Heading(heading: 'Nothing to show here')),
                          )
                        : RecentProjects(
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

  Row _searchRow() {
    return Row(
      children: [
        // const Spacer(),
        const ChoiceChipFilter(),
        const Spacer(),
        Container(
          height: 30,
          width: 2,
          color: ColorRes.textColor,
        ),
        const SizedBox(width: 5),
        IconButton(
            onPressed: () => {
                  controller.showPicker = !controller.showPicker,
                  if (controller.showPicker)
                    {controller.animationController.forward()}
                  else
                    {controller.animationController.reverse()}
                }, //? for search view
            splashRadius: 15,
            icon: const FaIcon(
              FontAwesomeIcons.calendarAlt,
              color: ColorRes.textColor,
              size: 25,
            )),
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
