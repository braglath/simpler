import 'package:get/get.dart';
import 'package:simpler/app/data/database/task_database.dart';
import 'package:simpler/app/modules/project_management/controllers/project_management_controller.dart';

class TodoActionBtnController extends GetxController {
  final projectManagementController =
      Get.put<ProjectManagementController>(ProjectManagementController());
  void actionOnTap1(int id, int projectId) async {
    if (id == 0) {
      print('clear todo');
      await TaskDatabase.instance.deleteAllTasks('Todo').whenComplete(() {
        projectManagementController.refreshToDoTask(projectId);
        Get.back();
      });
    } else if (id == 1) {
      print('clear in progress');
      await TaskDatabase.instance.deleteAllTasks('InProgress').whenComplete(() {
        projectManagementController.refreshInProgressTask(projectId);
        Get.back();
      });
    } else {
      print('clear done');
      await TaskDatabase.instance.deleteAllTasks('Done').whenComplete(() {
        projectManagementController.refreshDoneTask(projectId);
        Get.back();
      });
    }
  }

  void actionOnTap2(int id, int projectId) async {
    if (id == 0) {
      print('mark as in progress');
      await TaskDatabase.instance
          .updateTaskFull('Todo', 'InProgress')
          .whenComplete(() {
        projectManagementController.refreshToDoTask(projectId);
        projectManagementController.refreshInProgressTask(projectId);
        projectManagementController.refreshDoneTask(projectId);
        Get.back();
      });
    } else if (id == 1) {
      print('mark as done');
      await TaskDatabase.instance
          .updateTaskFull('InProgress', 'Done')
          .whenComplete(() {
        projectManagementController.refreshToDoTask(projectId);
        projectManagementController.refreshInProgressTask(projectId);
        projectManagementController.refreshDoneTask(projectId);
        Get.back();
      });
    } else {
      print('mark as to do');
      await TaskDatabase.instance
          .updateTaskFull('Done', 'Todo')
          .whenComplete(() {
        projectManagementController.refreshToDoTask(projectId);
        projectManagementController.refreshInProgressTask(projectId);
        projectManagementController.refreshDoneTask(projectId);
        Get.back();
      });
    }
  }

  void actionOnTap3(int id, int projectId) async {
    if (id == 0) {
      print('mark as done');
      await TaskDatabase.instance
          .updateTaskFull('Todo', 'Done')
          .whenComplete(() {
        projectManagementController.refreshToDoTask(projectId);
        projectManagementController.refreshInProgressTask(projectId);
        projectManagementController.refreshDoneTask(projectId);
        Get.back();
      });
    } else if (id == 1) {
      print('mark as to do');
      await TaskDatabase.instance
          .updateTaskFull('InProgress', 'Todo')
          .whenComplete(() {
        projectManagementController.refreshToDoTask(projectId);
        projectManagementController.refreshInProgressTask(projectId);
        projectManagementController.refreshDoneTask(projectId);
        Get.back();
      });
    } else {
      print('mark as in progress');
      await TaskDatabase.instance
          .updateTaskFull('Done', 'InProgress')
          .whenComplete(() {
        projectManagementController.refreshToDoTask(projectId);
        projectManagementController.refreshInProgressTask(projectId);
        projectManagementController.refreshDoneTask(projectId);
        Get.back();
      });
    }
  }
}
