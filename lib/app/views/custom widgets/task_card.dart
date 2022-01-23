import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/views/custom%20widgets/custom_bottomsheet.dart';
import 'package:simpler/app/views/custom%20widgets/custom_dialogue.dart';

class TaskCard extends StatelessWidget {
  final String taskTitle;
  final Function()? onPressedConfirm;
  final Function()? onPressedCancel;
  final Function()? onTap1;
  final Function()? onTap2;
  final Function()? onTap3;
  final Function()? onTap4;
  final int io;
  const TaskCard(
      {Key? key,
      required this.taskTitle,
      required this.onPressedConfirm,
      required this.onPressedCancel,
      required this.onTap1,
      required this.onTap2,
      required this.onTap3,
      required this.onTap4,
      required this.io})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
          onLongPress: () => CustomDialogue(
                  title: 'Delete Task',
                  textConfirm: 'Confirm',
                  textCancel: 'Cancel',
                  onpressedConfirm: onPressedConfirm,
                  onpressedCancel: onPressedCancel,
                  contentWidget: null,
                  isDismissible: true)
              .showDialogue(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: ColorRes.pureWhite,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      taskTitle,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => CustomBottomSheet(
            context: context,
            icon1: FontAwesomeIcons.tasks,
            icon2: FontAwesomeIcons.checkSquare,
            icon3: FontAwesomeIcons.trashAlt,
            icon4: FontAwesomeIcons.edit,
            title1: io == 0
                ? "Move to 'In progress' section"
                : io == 1
                    ? "Move to 'Done' section"
                    : "Move to 'To do' section",
            titile2: io == 0
                ? "Move to 'Done' section"
                : io == 1
                    ? "Move to 'To do' section"
                    : "Move to 'In progress' section",
            titile3: 'Delete task',
            titile4: 'Edit task',
            onTap1: onTap1,
            onTap2: onTap2,
            onTap3: onTap3,
            onTap4: onTap4,
          ).show(),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: FaIcon(
              FontAwesomeIcons.ellipsisH,
              size: 15,
            ),
          ),
        )
      ],
    );
  }
}
