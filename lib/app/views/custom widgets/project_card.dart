import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simpler/app/data/model/project_model.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/modules/home/controllers/home_controller.dart';
import 'package:simpler/app/modules/project_management/controllers/project_management_controller.dart';
import 'package:simpler/app/routes/app_pages.dart';
import 'package:simpler/app/views/custom%20widgets/custom_bottomsheet.dart';
import 'package:simpler/app/views/custom%20widgets/custom_dialogue.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  final int index;
  ProjectCard({
    Key? key,
    required this.project,
    required this.index,
  }) : super(key: key);

  final homeController = Get.put<HomeController>(HomeController());
  final projectManagerController =
      Get.put<ProjectManagementController>(ProjectManagementController());

  @override
  Widget build(BuildContext context) {
    homeController.refreshTasks(project.id);
    final projectCreated = homeController.dateCreated(project.createdTime);
    final projectDeadline = homeController.dateCreated(project.deadline);
    final projectCompleted = homeController.dateCreated(project.completedTime);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 10),
            Text(
              projectCreated,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(fontStyle: FontStyle.italic),
            ),
            const Spacer(),
            Text(
              project.deadline.isBefore(project.createdTime)
                  ? project.isCompleted
                      ? 'Deadline crossed'
                      : ''
                  : '',
              style: Theme.of(context).textTheme.caption?.copyWith(
                  color: ColorRes.redErrorColor, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Text(
              project.isCompleted ? 'Pending' : 'Completed',
              style: Theme.of(context).textTheme.caption?.copyWith(
                  color: project.isCompleted
                      ? ColorRes.redErrorColor
                      : ColorRes.greenProgressColor,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Card(
            elevation: 4,
            shadowColor: ColorRes.purpleSecondaryBtnColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              isThreeLine: !project.isCompleted,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onLongPress: () => CustomBottomSheet(
                context: context,
                icon1: FontAwesomeIcons.edit,
                icon2: FontAwesomeIcons.trashAlt,
                icon3: null,
                icon4: null,
                title1: 'Edit project',
                titile2: 'Delete project',
                titile3: null,
                titile4: null,
                onTap1: () => {},
                onTap2: () => homeController.deleteProjects(project.id, index),
                onTap3: null,
                onTap4: null,
                need3rdTile: false,
                need4thTile: false,
              ).show(),
              // CustomDialogue(
              //         title: 'Delete this project',
              //         textConfirm: 'Delete',
              //         textCancel: 'Cancel',
              //         onpressedConfirm: () =>
              //             homeController.deleteProjects(project.id, index),
              //         onpressedCancel: () => Get.back(),
              //         contentWidget: const Text(
              //           'You are about to delete this project!\nThis cannot be undone',
              //           textAlign: TextAlign.center,
              //           style: TextStyle(
              //             color: ColorRes.textColor,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 15,
              //           ),
              //         ),
              //         isDismissible: true)
              //     .showDialogue(),
              onTap: () {
                if (!project.isCompleted) {
                  CustomDialogue(
                          title: 'Reopen object?',
                          textConfirm: 'Yes',
                          textCancel: 'No',
                          onpressedConfirm: () => Get.toNamed(
                              Routes.INCREASE_DEADLINE,
                              arguments: project),
                          onpressedCancel: () => Get.back(),
                          contentWidget: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: '${project.title} ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'has been completed already on ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                  TextSpan(
                                    text: '$projectCompleted! ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                  ),
                                  TextSpan(
                                      text:
                                          'Do you want to reopen this project?',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4),
                                ]),
                          ),
                          isDismissible: true)
                      .showDialogue();
                } else {
                  print(
                      'project - ${project.isCompleted}\n${project.title}\n${project.avatar}\n${projectDeadline}\n${project.id}\n${project.deadline}\n${project.createdTime}');
                  projectManagerController.refreshToDoTask(project.id!);
                  projectManagerController.refreshInProgressTask(project.id!);
                  projectManagerController.refreshDoneTask(project.id!);
                  Get.toNamed(Routes.PROJECT_MANAGEMENT, arguments: {
                    'title': project.title,
                    'asset': project.avatar,
                    'projectDeadline': projectDeadline,
                    'projectId': project.id,
                    'projectDeadLine': project.deadline,
                    'projectCreatedTime': project.createdTime
                  });
                }
              },
              enableFeedback: true,
              leading: Image.asset(
                project.avatar,
                fit: BoxFit.contain,
                height: 55,
                width: 35,
              ),
              title: Text(
                project.title,
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Deadline - $projectDeadline',
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(fontSize: 12),
                      ),
                      const SizedBox(width: 5),
                      const FaIcon(
                        FontAwesomeIcons.calendarAlt,
                        size: 15,
                        color: Colors.grey,
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  !project.isCompleted
                      ? Row(
                          children: [
                            Text(
                              'Completed - $projectCompleted',
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(fontSize: 12),
                            ),
                            const SizedBox(width: 5),
                            const FaIcon(
                              FontAwesomeIcons.checkSquare,
                              size: 15,
                              color: Colors.grey,
                            )
                          ],
                        )
                      : const SizedBox.shrink(),
                ],
              ),

              trailing: const FaIcon(
                FontAwesomeIcons.arrowRight,
                color: ColorRes.textColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
