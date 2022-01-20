import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:simpler/app/data/model/project_model.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/modules/home/controllers/home_controller.dart';
import 'package:simpler/app/routes/app_pages.dart';
import 'package:simpler/app/views/custom%20widgets/custom_dialogue.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final int index;
  ProjectCard({Key? key, required this.project, required this.index})
      : super(key: key);

  final homeController = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    final projectCreated = homeController.dateCreated(project.createdTime);
    final projectDeadline = homeController.dateCreated(project.deadline);
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
            Container(
                height: 20,
                width: 75,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                      colors: [Colors.white, ColorRes.redErrorColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                ),
                child: Center(
                  child: Text(
                    'Pending',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        color: ColorRes.redErrorColor,
                        fontWeight: FontWeight.bold),
                  ),
                )),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onLongPress: () => CustomDialogue(
                      title: 'Delete this project',
                      textConfirm: 'Delete',
                      textCancel: 'Cancel',
                      onpressedConfirm: () =>
                          homeController.deleteProjects(project.id, index),
                      onpressedCancel: () => Get.back(),
                      contentWidget: const Text(
                        'You are about to delete this project!\nThis cannot be undone',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorRes.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      isDismissible: true)
                  .showDialogue(),
              onTap: () => Get.toNamed(Routes.PROJECT_MANAGEMENT,
                  arguments: {'title': project.title, 'asset': project.avatar}),
              enableFeedback: true,
              leading: Image.asset(
                project.avatar,
                fit: BoxFit.contain,
                height: 35,
                width: 35,
              ),
              // SizedBox(
              //   height: 50,
              //   width: 35,
              //   child: LiquidLinearProgressIndicator(
              //     borderRadius: 8,
              //     borderColor: ColorRes.textColor,
              //     borderWidth: 2,
              //     value: deadlineProgress.toDouble(), // Defaults to 0.5.
              //     valueColor: const AlwaysStoppedAnimation(Colors
              //         .pink), // Defaults to the current Theme's accentColor.
              //     backgroundColor: Colors
              //         .white, // Defaults to the current Theme's backgroundColor.
              //     direction: Axis
              //         .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). // A Path object used to draw the shape of the progress indicator. The size of the progress indicator is created from the bounds of this path.
              //   ),
              // ),
              title: AutoSizeText(
                project.title,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Deadline - $projectDeadline',
                style:
                    Theme.of(context).textTheme.caption?.copyWith(fontSize: 12),
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
