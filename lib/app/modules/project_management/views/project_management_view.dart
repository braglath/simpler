import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:simpler/app/data/resources/assets_strings.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/views/custom%20widgets/Text_type_field.dart';
import 'package:simpler/app/views/custom%20widgets/custom_dialogue.dart';
import 'package:simpler/app/views/custom%20widgets/custom_shape.dart';
import 'package:simpler/app/views/custom%20widgets/floating_appbar.dart';
import 'package:simpler/app/views/custom%20widgets/task_card.dart';
import 'package:simpler/app/views/custom%20widgets/separator.dart';
import '../controllers/project_management_controller.dart';

class ProjectManagementView extends GetView<ProjectManagementController> {
  ProjectManagementView({Key? key}) : super(key: key);

  final project = Get.arguments;
  String get title => project['title'];
  String get asset => project['asset'];
  String get deadline => project['projectDeadline'];
  int get projectId => project['projectId'];
  DateTime get projectDeadLine => project['projectDeadLine'];
  DateTime get projectCreatedTime => project['projectCreatedTime'];

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Obx(() {
        return Scaffold(
            floatingActionButton: orientation == Orientation.landscape
                ? FloatingActionButton(
                    onPressed: () => controller.changeToPortrait(),
                    child: const FaIcon(
                      FontAwesomeIcons.expandAlt,
                      color: ColorRes.pureWhite,
                    ),
                  )
                : controller.taskToDo.isEmpty &&
                        controller.taskInProgress.isEmpty
                    ? _fabBTN(context)
                    : const SizedBox.shrink(),
            extendBody: true,
            bottomNavigationBar: controller.showBottomSheet.isTrue
                ? _bottomNavigationBar(context)
                : const SizedBox.shrink(),
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: controller.projectManagementScrollController,
                      child: Obx(() {
                        return Stack(
                          children: [
                            _mainBody(context, orientation),
                            controller.showGrafitiLottie.value == true
                                ? Positioned.fill(
                                    child: Lottie.asset(AssetIcons.grafiti,
                                        fit: BoxFit.cover))
                                : const SizedBox.shrink()
                          ],
                        );
                      })),
                  orientation == Orientation.portrait
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                              height: 50,
                              child: Obx(() {
                                return FloatingAppBar(
                                  removeActionBtn: false,
                                  title: controller.showTitle.isTrue
                                      ? title
                                      : 'Deadline - $deadline',
                                  needBackBtn: true,
                                  needAvatar: false,
                                  asset: asset,
                                  onActionTap: () =>
                                      controller.refreshToDoTask(projectId),
                                  onLeadingTap: () => Get.back(),
                                );
                              })),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ));
      });
    });
  }

  Container _bottomNavigationBar(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.grey.shade200.withOpacity(0.5),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          gradient: const LinearGradient(
              colors: [Colors.white, ColorRes.purpleSecondaryBtnColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Center(
          child: RichText(
              text: TextSpan(
                  text: 'To do - ',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                TextSpan(
                  text: '${controller.taskToDo.length.toString()}  ',
                  style: Theme.of(context).textTheme.headline3?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                TextSpan(
                  text: 'In progress - ',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: '${controller.taskInProgress.length.toString()}  ',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Done - ',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: controller.taskDone.length.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(fontWeight: FontWeight.bold),
                )
              ])),
        ));
  }

  Container _fabBTN(BuildContext context) {
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
          onPressed: () => controller.completedProject(
              projectId, title, asset, projectDeadLine, projectCreatedTime),
          label: Text(
            'Project Completed',
            style: Theme.of(context).textTheme.caption?.copyWith(
                color: ColorRes.pureWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          enableFeedback: true,
        ));
  }

  Widget _mainBody(BuildContext context, Orientation orientation) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: orientation == Orientation.portrait
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 80),
                  _myProjCompletedNPending(),
                  const Separator(),
                  _todo(context, 0, orientation),
                  const Separator(),
                  _todo(context, 1, orientation),
                  const Separator(),
                  _todo(context, 2, orientation),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  Expanded(child: _todo(context, 0, orientation)),
                  const SizedBox(width: 20),
                  Expanded(child: _todo(context, 1, orientation)),
                  const SizedBox(width: 20),
                  Expanded(child: _todo(context, 2, orientation)),
                  const SizedBox(width: 10),
                ],
              ),
      );

  Padding _todo(BuildContext context, int io, Orientation orientation) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Center(
        child: Container(
          height: orientation == Orientation.portrait
              ? 415
              : MediaQuery.of(context).size.height - 10,
          width: MediaQuery.of(context).size.width - 50,
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
          child: _insideToDo(context, io, orientation),
        ),
      ),
    );
  }

  Column _insideToDo(BuildContext context, int io, Orientation orientation) {
    return Column(
      children: [
        Container(
          height: orientation == Orientation.portrait ? 40 : 35,
          decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            gradient: const LinearGradient(
                colors: [ColorRes.pureWhite, ColorRes.pureWhite],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: ToDoHeading(
            projectId: projectId,
            projectTitle: title,
            id: io,
            orientation: orientation,
          ),
        ),
        SizedBox(
          height: orientation == Orientation.portrait ? 350 : 290,
          child: Obx(() {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: io == 0
                  ? controller.taskToDo.value.length
                  : io == 1
                      ? controller.taskInProgress.value.length
                      : controller.taskDone.value.length,
              itemBuilder: (context, index) {
                var task = io == 0
                    ? controller.taskToDo[index]
                    : io == 1
                        ? controller.taskInProgress[index]
                        : controller.taskDone[index];
                return GestureDetector(
                  onTap: () => Get.defaultDialog(
                    barrierDismissible: true,
                    title: task.task,
                    backgroundColor: ColorRes.scaffoldBG,
                    titleStyle: const TextStyle(
                      color: ColorRes.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    buttonColor: ColorRes.purpleSecondaryBtnColor,
                    cancel: ElevatedButton(
                        onPressed: () => Get.back(),
                        child: const Text('Cancel')),
                    radius: 12,
                    content: Column(
                      children: [
                        Text(
                          'Project - ${task.projectTitle}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          'Deadline - $deadline',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  child: TaskCard(
                      taskTitle: task.task,
                      onPressedConfirm: () =>
                          controller.removeTask(task.id!, index),
                      onPressedCancel: () => Get.back(),
                      onTap1: () => controller.onTap1(io, task.id!, index,
                          task.projectId, task.projectTitle, task.task),
                      onTap2: () => controller.onTap2(io, task.id!, index,
                          projectId, task.projectTitle, task.task),
                      onTap3: () =>
                          controller.onTap3(io, task.id!, index, projectId),
                      onTap4: () {
                        Get.back();
                        CustomDialogue(
                                title: 'Edit Task',
                                textConfirm: 'Confirm',
                                textCancel: 'Cancel',
                                onpressedConfirm: () => controller.editTask(
                                      task.id,
                                      projectId,
                                      task.projectTitle,
                                      controller.newTaskController.text,
                                      io == 0
                                          ? 'Todo'
                                          : io == 1
                                              ? 'InProgress'
                                              : 'Done',
                                    ),
                                onpressedCancel: () => Get.back(),
                                contentWidget: TextTypeField(
                                  controller: controller.newTaskController,
                                  maxlines: 5,
                                  validator: (val) => null,
                                  onSaved: (val) => controller.task = val!,
                                  textInputType: TextInputType.multiline,
                                  task: task.task,
                                ),
                                isDismissible: true)
                            .showDialogue();
                      },
                      io: io),
                );
              },
            );
          }),
        ),
        const Spacer(),
        Container(
          height: 25,
          decoration: BoxDecoration(
            color: Colors.grey.shade200.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            gradient: const LinearGradient(
                colors: [ColorRes.pureWhite, ColorRes.pureWhite],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ],
    );
  }

  Widget _myProjCompletedNPending() {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Numbers(
            title: 'To do',
            number: controller.taskToDo.length.toString(),
            iconAsset: AssetIcons.pendingProjects,
            color: ColorRes.redErrorColor,
          ),
          Numbers(
            title: 'In progress',
            number: controller.taskInProgress.length.toString(),
            iconAsset: AssetIcons.inprogress,
            color: ColorRes.brown,
          ),
          Numbers(
            title: 'Done',
            number: controller.taskDone.length.toString(),
            iconAsset: AssetIcons.completedProjects,
            color: ColorRes.greenProgressColor,
          ),
        ],
      );
    });
  }
}

class ToDoHeading extends GetView<ProjectManagementController> {
  final int projectId;
  final String projectTitle;
  final int id;
  final Orientation orientation;
  const ToDoHeading(
      {Key? key,
      required this.projectId,
      required this.projectTitle,
      required this.id,
      required this.orientation})
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
          onTap: () => controller.changeOrientation(),

          // CustomDialogue(
          //         title: orientation == Orientation.portrait
          //             ? 'Landscape'
          //             : 'Portrait',
          //         textConfirm: 'Confirm',
          //         textCancel: 'Cancel',
          //         onpressedConfirm: () => controller.changeOrientation(),
          //         onpressedCancel: () => Get.back(),
          //         contentWidget: Text(
          //           orientation == Orientation.portrait
          //               ? 'Switch to landscape for more screen real estate'
          //               : 'Switch back to portrait',
          //           textAlign: TextAlign.center,
          //           style: Theme.of(context).textTheme.headline3?.copyWith(
          //               fontWeight: FontWeight.bold,
          //               fontStyle: FontStyle.italic),
          //         ),
          //         isDismissible: true)
          //     .showDialogue(),

          child: const FaIcon(
            FontAwesomeIcons.expandAlt,
            size: 18,
          ),
        ),
        const SizedBox(width: 15),
        // const FaIcon(FontAwesomeIcons.ellipsisH, size: 18),
        // const SizedBox(width: 15),
      ],
    );
  }
}

class CreateTaskField extends GetView<ProjectManagementController> {
  final int projectId;
  final String projectTitle;
  final Orientation orientation;
  const CreateTaskField(
      {Key? key,
      required this.projectId,
      required this.projectTitle,
      required this.orientation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: controller.newTaskFormKey,
        child: TextTypeField(
            task: '',
            controller: controller.newTaskController,
            maxlines: orientation == Orientation.portrait ? 5 : 2,
            validator: (val) => controller.taskValidator(val),
            onSaved: (val) => controller.task = val!,
            textInputType: TextInputType.multiline),
      ),
    );
  }
}

class Numbers extends StatelessWidget {
  final String title;
  final String number;
  final String iconAsset;
  final Color color;
  const Numbers(
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
              width: 25,
              height: 25,
            ),
            Row(
              children: [
                AutoSizeText(
                  title,
                  style: Theme.of(context).textTheme.caption,
                ),
                const SizedBox(width: 5),
                AutoSizeText(
                  number,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        gradientColor: color);
  }
}
