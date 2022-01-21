import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:simpler/app/data/database/task_database.dart';
import 'package:simpler/app/data/model/task_model.dart';

class ProjectManagementController extends GetxController {
  final showTitle = false.obs;
  int timing = 0;
  final TextEditingController newTaskController = TextEditingController();
  final GlobalKey<FormState> newTaskFormKey = GlobalKey<FormState>();
  var taskToDo = [].obs;
  var taskInProgress = [].obs;
  var taskDone = [].obs;

  @override
  void onInit() {
    super.onInit();
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

  Future refreshToDoTask(int projectId) async {
    await TaskDatabase.instance
        .readAllProjects(projectId, 'Todo')
        .then((value) => taskToDo.assignAll(value));
  }

  Future refreshInProgressTask(int projectId) async {
    await TaskDatabase.instance
        .readAllProjects(projectId, 'InProgress')
        .then((value) => taskInProgress.assignAll(value));
  }

  Future refreshDoneTask(int projectId) async {
    await TaskDatabase.instance
        .readAllProjects(projectId, 'Done')
        .then((value) => taskDone.assignAll(value));
  }

  Future addTask(int projectId, String projectTitle) async {
    final status = 'Todo';
    final Task tasks = Task(
        projectId: projectId,
        projectTitle: projectTitle,
        task: newTaskController.text,
        status: status);
    await TaskDatabase.instance
        .create(tasks)
        .then((value) => taskToDo.add(value));
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
        ? fromTODOtoINPROGRESS(
            taskId, index, taskId, projectId, projectTitle, task)
        : io == 1
            ? fromINPROGRESStoDONE(
                taskId, index, taskId, projectId, projectTitle, task)
            : fromDONEtoTODO(taskId, index);
  }

  void onTap2(int io, int taskId, int index) {
    io == 0
        ? fromTODOtoDONE(taskId, index)
        : io == 1
            ? fromINPROGRESStoTODO(taskId, index)
            : fromDONEtoINPROGRESS(taskId, index);
  }

  void onTap3(int io, int taskId, int index) {
    io == 0
        ? removeTaskfromTODO(taskId, index)
        : io == 1
            ? removeTaskfromINPROGRESS(taskId, index)
            : removeTaskfromDONE(taskId, index);
  }

  Future fromTODOtoINPROGRESS(int id, int index, int taskId, int projectId,
      String projectTitle, String projectTask) async {
    print('todo to inprogress');
    final status = 'InProgress';
    final Task tasks = Task(
        id: taskId,
        projectId: projectId,
        projectTitle: projectTitle,
        task: projectTask,
        status: status);
    print('$id , $projectId , $projectTitle, $projectTask, $status');
    await TaskDatabase.instance
        .update(tasks)
        .then((value) => taskInProgress.add(value))
        .then((value) => taskToDo.removeAt(index))
        .whenComplete(() => Get.back());
    // await TaskDatabase.instance
    //     .delete(id)
    //     .then((value) => taskInProgress.add(value))
    //     .then((value) => taskToDo.removeAt(index))
    //     .whenComplete(() => Get.back());
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
    await TaskDatabase.instance
        .update(tasks)
        .then((value) => taskDone.add(value))
        .then((value) => taskInProgress.removeAt(index))
        .whenComplete(() => Get.back());
  }

  Future fromDONEtoTODO(int id, int index) async {
    print('done to todo');
  }

  Future fromTODOtoDONE(int id, int index) async {
    print('todo to done');

    // await TaskDatabase.instance
    //     .delete(id)
    //     .then((value) => taskToDo.removeAt(index))
    //     .then((value) => taskDone.add(value))
    //     .whenComplete(() => Get.back());
  }

  Future fromINPROGRESStoTODO(int id, int index) async {
    print('inprogress to todo');
  }

  Future fromDONEtoINPROGRESS(int id, int index) async {
    print('done to inprogress');
  }

  Future removeTaskfromTODO(int id, int index) async {
    print('remove from todo');
  }

  Future removeTaskfromINPROGRESS(int id, int index) async {
    print('remove from inprogress');
  }

  Future removeTaskfromDONE(int id, int index) async {
    print('remove from done');
  }

  @override
  void onClose() {}
}
