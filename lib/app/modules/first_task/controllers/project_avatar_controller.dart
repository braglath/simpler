import 'package:get/get.dart';

import 'package:simpler/app/data/database/project_database.dart';
import 'package:simpler/app/data/database/task_database.dart';
import 'package:simpler/app/data/model/project_model.dart';
import 'package:simpler/app/data/model/task_model.dart';
import 'package:simpler/app/modules/project_management/controllers/project_management_controller.dart';
import 'package:simpler/app/routes/app_pages.dart';

class ProjectAvatarController extends GetxController {
  final showBtn = false.obs;
  final userAvatar = ''.obs;
  final onTap = false.obs;

  final projectManagementController =
      Get.put<ProjectManagementController>(ProjectManagementController());

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void saveProjectAvatar(String asset) {
    userAvatar.value = asset;
    onTap.value = true;
    showBtn.value = true;
    print('onTap ${onTap.value} - showBtn ${showBtn.value}');
  }

  Future addProject(String title, DateTime deadline, DateTime createdTime,
      String assetImage) async {
    DateTime completedTime = DateTime.now();
    print('deadline - $createdTime');
    final Project project = Project(
        isCompleted: true,
        title: title,
        avatar: assetImage,
        deadline: deadline,
        createdTime: createdTime,
        completedTime: completedTime);
    final newProject = await ProjectDatabase.instance.create(project);
    addTask(newProject.id!, newProject.title,
        'This is your place to add tasks for your project\n\nKeep your tasks short and clear\n\nMove the task to In progress or Done section by tapping on ... icon on\n\nOnce you complete the tasks in Todo and In progress section, you will see a button to mark the task as Completed');
  }

  Future addTask(int projectId, String projectTitle, String task) async {
    final status = 'Todo';
    Task tasks = Task(
        projectId: projectId,
        projectTitle: projectTitle,
        task: task,
        status: status);
    await TaskDatabase.instance
        .create(tasks)
        .then((value) => projectManagementController.taskToDo.add(value))
        .whenComplete(() {
      projectManagementController.refreshToDoTask(projectId);
      print('$projectId , $projectTitle, $task, $status');
      Get.offAllNamed(Routes.HOME);
    });
  }
}
