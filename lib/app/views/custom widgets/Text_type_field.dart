import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/modules/project_management/controllers/project_management_controller.dart';

class TextTypeField extends StatelessWidget {
  TextEditingController? controller;
  final int? maxlines;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final TextInputType? textInputType;
  final String? task;

  TextTypeField(
      {Key? key,
      required this.controller,
      required this.maxlines,
      required this.validator,
      required this.textInputType,
      required this.onSaved,
      required this.task})
      : super(key: key);

  // final projectManagementController =
  //     Get.put<ProjectManagementController>(ProjectManagementController());

  @override
  Widget build(BuildContext context) {
    controller!.text = task!;
    return TextFormField(
      autofocus: true,
      textCapitalization: TextCapitalization.sentences,
      controller: controller,
      maxLines: maxlines,
      style: Theme.of(context).textTheme.headline4,
      cursorColor: ColorRes.textColor,
      keyboardType: textInputType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
