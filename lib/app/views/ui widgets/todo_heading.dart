import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/modules/project_management/controllers/project_management_controller.dart';
import 'package:simpler/app/modules/project_management/controllers/todoActionBtn_controller.dart';
import 'package:simpler/app/modules/project_management/views/project_management_view.dart';
import 'package:simpler/app/views/custom%20widgets/custom_bottomsheet.dart';
import 'package:simpler/app/views/custom%20widgets/custom_dialogue.dart';

class ToDoHeading extends GetView<ProjectManagementController> {
  final int projectId;
  final String projectTitle;
  final int id;
  final Orientation orientation;
  final TodoActionBtnController todoActionBtnController;
  const ToDoHeading(
      {Key? key,
      required this.projectId,
      required this.projectTitle,
      required this.id,
      required this.orientation,
      required this.todoActionBtnController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15),
        Text(
          id == 0
              ? 'To do'
              : id == 1
                  ? 'In progress'
                  : 'Done',
          style: Theme.of(context).textTheme.headline3?.copyWith(
              fontSize: 22,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        CircleAvatar(
          radius: 10.0,
          backgroundColor: ColorRes.brown,
          child: Center(child: Obx(() {
            return AutoSizeText(
              id == 0
                  ? controller.taskToDo.length.toString()
                  : id == 1
                      ? controller.taskInProgress.length.toString()
                      : controller.taskDone.length.toString(),
              style: Theme.of(context).textTheme.caption?.copyWith(
                  fontWeight: FontWeight.bold, color: ColorRes.textColor),
            );
          })),
        ),
        const Spacer(),
        id == 0
            ? GestureDetector(
                onTap: () => CustomDialogue(
                        title: 'Create Task',
                        textConfirm: 'Confirm',
                        textCancel: 'Cancel',
                        onpressedConfirm: () =>
                            controller.addTask(projectId, projectTitle),
                        onpressedCancel: () => Get.back(),
                        contentWidget: CreateTaskField(
                          projectId: projectId,
                          projectTitle: projectTitle,
                          orientation: orientation,
                        ),
                        isDismissible: true)
                    .showDialogue(),
                child: const FaIcon(FontAwesomeIcons.plus, size: 18))
            : const SizedBox.shrink(),
        const SizedBox(width: 15),
        GestureDetector(
          onTap: () => CustomBottomSheet(
            context: context,
            icon1: FontAwesomeIcons.trashAlt,
            icon2: id == 0
                ? FontAwesomeIcons.tasks
                : id == 1
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.listAlt,
            icon3: null,
            icon4: id == 0
                ? FontAwesomeIcons.check
                : id == 1
                    ? FontAwesomeIcons.listAlt
                    : FontAwesomeIcons.tasks,
            title1: 'Clear all task',
            titile2: id == 0
                ? 'Mark all as "In progress"'
                : id == 1
                    ? 'Mark all as "Done"'
                    : 'Mark all as "To do"',
            titile3: null,
            titile4: id == 0
                ? 'Mark all as "Done"'
                : id == 1
                    ? 'Mark all as "To do"'
                    : 'Mark all as "In progress"',
            onTap1: () => todoActionBtnController.actionOnTap1(id, projectId),
            onTap2: () => todoActionBtnController.actionOnTap2(id, projectId),
            onTap3: null,
            onTap4: () => todoActionBtnController.actionOnTap3(id, projectId),
            need3rdTile: true,
            need4thTile: false,
          ).show(),
          child: const FaIcon(
            FontAwesomeIcons.ellipsisH,
            size: 18,
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
