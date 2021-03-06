import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:simpler/app/data/database/project_database.dart';
import 'package:simpler/app/data/database/task_database.dart';
import 'package:simpler/app/data/user_data/user_data.dart';
import 'package:simpler/app/modules/all_projects/controllers/all_projects_controller.dart';

class HomeController extends GetxController {
  final date = ''.obs;
  int timing = 0;
  late Timer _timer;
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();
  var project = [].obs;
  final deadlineProgress = 0.obs;
  var taskToDo = [].obs;
  var taskInProgress = [].obs;
  var taskDone = [].obs;
  var completedProjects = [].obs;
  final allProjectsController =
      Get.put<AllProjectsController>(AllProjectsController());

  @override
  void onInit() {
    super.onInit();
    refreshProjects();
    refreshCompletedProjects();
    currentDate();
    _timer = Timer.periodic(const Duration(seconds: 8), (Timer t) {
      timing = timing + 1;
      changeDateName();
      // print(timing);
      // print(date.value);
    });
  }

  void changeDateName() {
    if (timing.isEven) {
      date.value = UserDataDetails().readUserName();
    } else {
      currentDate();
    }
  }

  void currentDate() {
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

    var now = DateTime.now();
    var currentMon = now.month;
    date.value = '${months[currentMon - 1]} ${now.day}, ${now.year}';
    // print(months[currentMon - 1]);
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    print(' deadline - ${(to.difference(from).inHours / 24).round()}');
    return (to.difference(from).inHours / 24).round();
  }

  @override
  void onClose() {
    _timer.cancel();
  }

  Future refreshProjects() async {
    if (await ProjectDatabase.instance.projectDatabaseExists()) {
      await ProjectDatabase.instance
          .readAllProjects()
          .then((value) => project.assignAll(value));
    } else {
      return print('no database exists');
    }
  }

  Future refreshCompletedProjects() async {
    if (await ProjectDatabase.instance.projectDatabaseExists()) {
      final completed = await ProjectDatabase.instance.readCompletedProjects();
      completedProjects.value = completed;
    } else {
      return print('no database exists');
    }
  }

  void refreshTasks(projectId) async {
    await refreshTaskTODO(projectId);
    await refreshTaskINPROGRESS(projectId);
    await refreshTaskDONE(projectId);
  }

  Future refreshTaskTODO(int projectId) async {
    final status = 'Todo';
    final todo = await TaskDatabase.instance.readAllProjects(projectId, status);
    taskToDo.value = todo;
  }

  Future refreshTaskINPROGRESS(int projectId) async {
    final status = 'InProgress';
    final inProgress =
        await TaskDatabase.instance.readAllProjects(projectId, status);
    taskInProgress.value = inProgress;
  }

  Future refreshTaskDONE(int projectId) async {
    final status = 'Done';
    final done = await TaskDatabase.instance.readAllProjects(projectId, status);
    taskDone.value = done;
  }

  Future deleteProjects(id, index) async {
    await ProjectDatabase.instance.delete(id);
    project.removeAt(index);
    refreshProjects();
    refreshCompletedProjects();
    allProjectsController.getAllProjectsList();
    Get.back();
  }

  String dateCreated(DateTime createdTime) {
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
    var currentMon = createdTime.month;
    final projectDate =
        '${months[currentMon - 1]} ${createdTime.day}, ${createdTime.year}';
    return projectDate;
  }
}
