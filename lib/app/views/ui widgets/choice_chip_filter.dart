import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/modules/all_projects/controllers/all_projects_controller.dart';

class ChoiceChipFilter extends GetView<AllProjectsController> {
  const ChoiceChipFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // runSpacing: 5,
      spacing: 8,
      children: List<Widget>.generate(
        3,
        (int index) {
          return Obx(() {
            return ChoiceChip(
              selectedColor: ColorRes.purpleSecondaryBtnColor,
              disabledColor: const Color(0xFFC7B9FD),
              elevation: 1,
              label: Text(index == 0
                  ? 'All'
                  : index == 2
                      ? 'Pending'
                      : 'Completed'),
              labelStyle: Theme.of(context).textTheme.subtitle1,
              selected: controller.choiceChipValue.value == index,
              onSelected: (bool selected) {
                controller.choiceChipValue.value = (selected ? index : null)!;
                controller.choiceChipIndex.value = index;
                if (controller.choiceChipValue.value == 0) {
                  //? show all projects
                  controller.getAllProjectsList();
                } else if (controller.choiceChipValue.value == 1) {
                  //? show completed projects
                  controller.getCompletedProjectsList();
                } else {
                  //? show pending projects
                  controller.getPendingProjectsList();
                }
              },
            );
          });
        },
      ).toList(),
    );
  }
}
