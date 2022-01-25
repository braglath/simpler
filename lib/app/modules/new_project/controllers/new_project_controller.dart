import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:simpler/app/data/database/project_database.dart';
import 'package:simpler/app/data/model/project_model.dart';
import 'package:simpler/app/modules/all_projects/controllers/all_projects_controller.dart';
import 'package:simpler/app/modules/home/controllers/home_controller.dart';
import 'package:simpler/app/routes/app_pages.dart';

class NewProjectController extends GetxController {
  final TextEditingController projectNameController = TextEditingController();
  final TextEditingController firstTaskController = TextEditingController();
  final showBtn = false.obs;
  final showBtn2 = false.obs;
  final showBtn3 = false.obs;
  final DateTime date = DateTime.now();
  DateTime deadLineDate = DateTime.now();
  final deadLine = ''.obs;
  final homeController = Get.put<HomeController>(HomeController());
  final allProjectsController =
      Get.put<AllProjectsController>(AllProjectsController());
  final isLoading = false.obs;
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

  Future changeProjectDeadline(
    int projectId,
    String projectAvatar,
    String projectTitle,
    DateTime projectDeadLine,
    DateTime projectCreatedTime,
    DateTime projectCompletedTime,
  ) async {
    isLoading.value = true;
    DateTime completedTime = DateTime.now();
    final Project project = Project(
        id: projectId,
        isCompleted: true,
        title: projectTitle,
        avatar: projectAvatar,
        deadline: projectDeadLine,
        createdTime: projectCreatedTime,
        completedTime: completedTime);
    await ProjectDatabase.instance.update(project).whenComplete(() {
      homeController.refreshProjects();
      homeController.refreshCompletedProjects();
      allProjectsController.getAllProjectsList();
      Future.delayed(const Duration(seconds: 2), () => isLoading.value = true)
          .then((value) => Get.offAllNamed(Routes.HOME));
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
