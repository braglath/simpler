import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import 'package:simpler/app/data/database/task_database.dart';
import 'package:simpler/app/data/model/task_model.dart';

class ProjectManagementController extends GetxController {
  final showTitle = false.obs;
  int timing = 0;
  var task = '';
  final ScrollController projectManagementScrollController = ScrollController();
  final TextEditingController newTaskController = TextEditingController();
  final GlobalKey<FormState> newTaskFormKey = GlobalKey<FormState>();
  var taskToDo = [].obs;
  var taskInProgress = [].obs;
  var taskDone = [].obs;

  final showBottomSheet = false.obs;

  @override
  void onInit() {
    super.onInit();
    projectManagementScrollController.addListener(() {
      final scrollListener =
          projectManagementScrollController.position.userScrollDirection ==
                  ScrollDirection.reverse &&
              projectManagementScrollController.position.pixels > 200;

      if (scrollListener) {
        showBottomSheet.value = true;
        print('show bottom sheet - ${showBottomSheet.value}');
      } else {
        showBottomSheet.value = false;
        print('show bottom sheet - ${showBottomSheet.value}');
      }
    });

    Timer.periodic(const Duration(seconds: 8), (Timer t) {
      timing = timing + 1;
      // print('timing - $timing');
      if (timing.isEven) {
        showTitle.value = true;
      } else {
        showTitle.value = false;
      }
    });
  }

  String? taskValidator(String? val) {
    if (val!.isEmpty) {
      return 'Cannot leave this empty';
    }
    return null;
  }

  void refreshToDoTask(int projectId) async {
    print('project id refresh- $projectId');
    final status = 'Todo';
    final newTask =
        await TaskDatabase.instance.readAllProjects(projectId, status);
    taskToDo.value = newTask;
  }

  Future refreshInProgressTask(int projectId) async {
    final status = 'InProgress';
    final inProgressTask =
        await TaskDatabase.instance.readAllProjects(projectId, status);
    taskInProgress.value = inProgressTask;
  }

  Future refreshDoneTask(int projectId) async {
    final status = 'Done';
    final doneTask =
        await TaskDatabase.instance.readAllProjects(projectId, status);
    taskDone.value = doneTask;
  }

  Future addTask(int projectId, String projectTitle) async {
    if (newTaskFormKey.currentState!.validate()) {
      newTaskFormKey.currentState?.save();
      final status = 'Todo';
      Task tasks = Task(
          projectId: projectId,
          projectTitle: projectTitle,
          task: task,
          status: status);
      await TaskDatabase.instance
          .create(tasks)
          .then((value) => taskToDo.add(value))
          .whenComplete(() {
        refreshToDoTask(projectId);
        print('$projectId , $projectTitle, $task, $status');
        Get.back();
      });
    }
  }

  Future removeTask(int id, int index) async {
    await TaskDatabase.instance
        .delete(id)
        .then((value) => taskToDo.removeAt(index))
        .whenComplete(() => Get.back());
  }

  void onTap1(int io, int taskId, int index, int projectId, String projectTitle,
      String task) {
    io == 0
        ? fromTODOtoINPROGRESS(index, taskId, projectId, projectTitle, task)
        : io == 1
            ? fromINPROGRESStoDONE(
                taskId, index, taskId, projectId, projectTitle, task)
            : fromDONEtoTODO(
                taskId, index, taskId, projectId, projectTitle, task);
  }

  void onTap2(
    int io,
    int taskId,
    int index,
    int projectId,
    String projectTitle,
    String projectTask,
  ) {
    io == 0
        ? fromTODOtoDONE(index, taskId, projectId, projectTitle, projectTask)
        : io == 1
            ? fromINPROGRESStoTODO(
                taskId, index, taskId, projectId, projectTitle, projectTask)
            : fromDONEtoINPROGRESS(
                taskId, index, taskId, projectId, projectTitle, projectTask);
  }

  void onTap3(int io, int taskId, int index, int projectId) {
    io == 0
        ? removeTaskfromTODO(taskId, index, projectId)
        : io == 1
            ? removeTaskfromINPROGRESS(taskId, index, projectId)
            : removeTaskfromDONE(taskId, index, projectId);
  }

  Future fromTODOtoINPROGRESS(int index, int taskId, int projectId,
      String projectTitle, String projectTask) async {
    print('todo to inprogress');
    final status = 'InProgress';
    final Task tasks = Task(
        id: taskId,
        projectId: projectId,
        projectTitle: projectTitle,
        task: projectTask,
        status: status);
    await TaskDatabase.instance.update(tasks).then((value) {
      taskToDo.removeAt(index);
      refreshInProgressTask(projectId);
    }).whenComplete(() {
      refreshToDoTask(projectId);
      Get.back();
    });
  }

  Future fromINPROGRESStoDONE(int id, int index, int taskId, int projectId,
      String projectTitle, String projectTask) async {
    print('inprogress to done');
    final status = 'Done';
    final Task tasks = Task(
        id: taskId,
        projectId: projectId,
        projectTitle: projectTitle,
        task: projectTask,
        status: status);
    print('$id , $projectId , $projectTitle, $projectTask, $status');
    await TaskDatabase.instance.update(tasks).then((value) {
      taskInProgress.removeAt(index);
      refreshDoneTask(projectId);
    }).whenComplete(() {
      refreshInProgressTask(projectId);
      Get.back();
    });
  }

  Future fromDONEtoTODO(int id, int index, int taskId, int projectId,
      String projectTitle, String projectTask) async {
    print('done to todo');
    final status = 'Todo';
    final Task tasks = Task(
        id: taskId,
        projectId: projectId,
        projectTitle: projectTitle,
        task: projectTask,
        status: status);
    await TaskDatabase.instance.update(tasks).then((value) {
      taskDone.removeAt(index);
      refreshToDoTask(projectId);
    }).whenComplete(() {
      refreshDoneTask(projectId);
      Get.back();
    });
  }

  Future fromTODOtoDONE(int index, int taskId, int projectId,
      String projectTitle, String projectTask) async {
    print('todo to done');
    final status = 'Done';
    final Task tasks = Task(
        id: taskId,
        projectId: projectId,
        projectTitle: projectTitle,
        task: projectTask,
        status: status);
    await TaskDatabase.instance.update(tasks).then((value) {
      taskToDo.removeAt(index);
      refreshDoneTask(projectId);
    }).whenComplete(() {
      refreshToDoTask(projectId);
      Get.back();
    });
  }

  Future fromINPROGRESStoTODO(
      int id, int index, taskId, projectId, projectTitle, projectTask) async {
    print('inprogress to todo');
    final status = 'Todo';
    final Task tasks = Task(
        id: taskId,
        projectId: projectId,
        projectTitle: projectTitle,
        task: projectTask,
        status: status);
    await TaskDatabase.instance.update(tasks).then((value) {
      taskInProgress.removeAt(index);
      refreshToDoTask(projectId);
    }).whenComplete(() {
      refreshInProgressTask(projectId);
      Get.back();
    });
  }

  Future fromDONEtoINPROGRESS(int id, int index, int taskId, int projectId,
      String projectTitle, String projectTask) async {
    print('done to inprogress');
    final status = 'InProgress';
    final Task tasks = Task(
        id: taskId,
        projectId: projectId,
        projectTitle: projectTitle,
        task: projectTask,
        status: status);
    await TaskDatabase.instance.update(tasks).then((value) {
      taskDone.removeAt(index);
      refreshInProgressTask(projectId);
    }).whenComplete(() {
      refreshDoneTask(projectId);
      Get.back();
    });
  }

  Future removeTaskfromTODO(int id, int index, int projectId) async {
    print('remove from todo');
    await TaskDatabase.instance
        .delete(id)
        .then((value) => taskToDo.removeAt(index))
        .whenComplete(() {
      refreshToDoTask(projectId);
      Get.back();
    });
  }

  Future removeTaskfromINPROGRESS(int id, int index, projectId) async {
    print('remove from inprogress');
    await TaskDatabase.instance
        .delete(id)
        .then((value) => taskToDo.removeAt(index))
        .whenComplete(() {
      refreshInProgressTask(projectId);
      Get.back();
    });
  }

  Future removeTaskfromDONE(int id, int index, int projectId) async {
    print('remove from done');
    print('remove from todo');
    await TaskDatabase.instance
        .delete(id)
        .then((value) => taskToDo.removeAt(index))
        .whenComplete(() {
      refreshDoneTask(projectId);
      Get.back();
    });
  }

  @override
  void onClose() => {projectManagementScrollController.dispose()};
}
