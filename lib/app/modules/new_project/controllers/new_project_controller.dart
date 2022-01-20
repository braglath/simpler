import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NewProjectController extends GetxController {
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController firstTaskController = TextEditingController();
  final showBtn = false.obs;
  final showBtn2 = false.obs;
  final showBtn3 = false.obs;
  final DateTime date = DateTime.now();
  DateTime deadLineDate = DateTime.now();
  final deadLine = ''.obs;
  List months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];

  @override
  void onInit() {
    super.onInit();
    currentDate();
    projectNameController.addListener(() {
      if (projectNameController.text != '') {
        showBtn.value = true;
      }
    });
    firstTaskController.addListener(() {
      if (projectNameController.text != '') {
        showBtn2.value = true;
      }
    });
  }

  void currentDate() {
    var now = DateTime.now();
    var currentMon = now.month;
    deadLine.value = '${months[currentMon - 1]} ${now.day}, ${now.year}';
    print(months[currentMon - 1]);
  }

  void datePicker(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
        fieldLabelText: 'Project deadline',
        context: context,
        initialDate: date,
        firstDate: DateTime(2022),
        lastDate: DateTime(2050));

    if (newDate == null) {
      showBtn3.value = false;
    } else {
      deadLineDate = newDate;
      var currentMon = newDate.month;
      deadLine.value =
          '${months[currentMon - 1]} ${newDate.day}, ${newDate.year}';
      showBtn3.value = true;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    projectNameController.dispose();
    firstTaskController.dispose();
  }
}
