import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simpler/app/data/resources/assets_strings.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/data/resources/usable_strings.dart';
import 'package:simpler/app/modules/home/views/home_view.dart';
import 'package:simpler/app/views/custom%20widgets/Text_type_field.dart';
import 'package:simpler/app/views/custom%20widgets/custom_dialogue.dart';
import 'package:simpler/app/views/custom%20widgets/custom_shape.dart';
import 'package:simpler/app/views/custom%20widgets/floating_appbar.dart';
import 'package:simpler/app/views/custom%20widgets/separator.dart';
import 'package:simpler/app/views/custom%20widgets/task_card.dart';
import '../controllers/project_management_controller.dart';

class ProjectManagementView extends GetView<ProjectManagementController> {
  ProjectManagementView({Key? key}) : super(key: key);

  final project = Get.arguments;
  String get title => project['title'];
  String get asset => project['asset'];
  String get deadline => project['projectDeadline'];
  int get projectId => project['projectId'];

  @override
  Widget build(BuildContext context) {
    print('project id - $projectId');
    controller.refreshToDoTask(projectId);
    controller.refreshInProgressTask(projectId);
    controller.refreshDoneTask(projectId);
    return Obx(() {
      return Scaffold(
          floatingActionButton: controller.taskToDo.value.isEmpty &&
                  controller.taskInProgress.value.isEmpty
              ? _fabBTN(context)
              : const SizedBox.shrink(),
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
                          title: controller.showTitle.isTrue
                              ? title
                              : 'Deadline - $deadline',
                          needBackBtn: true,
                          asset: asset,
                          onActionTap: () {},
                          onLeadingTap: () => Get.back(),
                        );
                      })),
                ),
              ],
            ),
          ));
    });
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
          onPressed: () => Get.back(),
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

  Widget _mainBody(BuildContext context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            _myProjCompletedNPending(),
            const Separator(),
            _todo(context, 0),
            const Separator(),
            _todo(context, 1),
            const Separator(),
            _todo(context, 2),
          ],
        ),
      );

  Padding _todo(BuildContext context, int io) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Center(
        child: Container(
          height: 415,
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
          child: _insideToDo(context, io),
        ),
      ),
    );
  }

  Column _insideToDo(BuildContext context, int io) {
    return Column(
      children: [
        Container(
          height: 50,
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
          ),
        ),
        SizedBox(
          height: 340,
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
                final task = io == 0
                    ? controller.taskToDo[index]
                    : io == 1
                        ? controller.taskInProgress[index]
                        : controller.taskDone[index];
                return TaskCard(
                    onPressedConfirm: () =>
                        controller.removeTask(task.id, index),
                    onPressedCancel: () => Get.back(),
                    task: task.task,
                    onTap1: () => controller.onTap1(io, task.id, index,
                        task.projectId, task.projectTitle, task.task),
                    onTap2: () => controller.onTap2(io, task.id, index),
                    onTap3: () => controller.onTap3(io, task.id, index),
                    io: io);
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
            number: controller.taskToDo.value.length.toString(),
            iconAsset: AssetIcons.pendingProjects,
            color: ColorRes.brown,
          ),
          Numbers(
            title: 'In progress',
            number: controller.taskInProgress.value.length.toString(),
            iconAsset: AssetIcons.completedProjects,
            color: ColorRes.greenProgressColor,
          ),
          Numbers(
            title: 'Done',
            number: controller.taskDone.value.length.toString(),
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
  const ToDoHeading(
      {Key? key,
      required this.projectId,
      required this.projectTitle,
      required this.id})
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
            return Text(
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
        GestureDetector(
            onTap: () => CustomDialogue(
                    title: 'Create Task',
                    textConfirm: 'Confirm',
                    textCancel: 'Cancel',
                    onpressedConfirm: () =>
                        controller.addTask(projectId, projectTitle),
                    onpressedCancel: () => Get.back(),
                    contentWidget: const CreateTaskField(),
                    isDismissible: true)
                .showDialogue(),
            child: id == 0
                ? const FaIcon(FontAwesomeIcons.plus, size: 18)
                : const SizedBox.shrink()),
        const SizedBox(width: 15),
        // const FaIcon(FontAwesomeIcons.ellipsisH, size: 18),
        // const SizedBox(width: 15),
      ],
    );
  }
}

class CreateTaskField extends GetView<ProjectManagementController> {
  const CreateTaskField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: controller.newTaskFormKey,
        child: TextTypeField(
            controller: controller.newTaskController,
            maxlines: 3,
            validator: (val) {},
            textInputType: TextInputType.name),
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
