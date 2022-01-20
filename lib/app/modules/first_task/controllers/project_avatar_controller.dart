import 'package:get/get.dart';
import 'package:simpler/app/data/database/project_database.dart';
import 'package:simpler/app/data/database/task_database.dart';
import 'package:simpler/app/data/model/project_model.dart';
import 'package:simpler/app/data/model/task_model.dart';
import 'package:simpler/app/routes/app_pages.dart';

class ProjectAvatarController extends GetxController {
  final showBtn = false.obs;
  final userAvatar = ''.obs;
  final onTap = false.obs;

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
    print('deadline - $createdTime');
    final Project project = Project(
        isCompleted: true,
        title: title,
        avatar: assetImage,
        deadline: deadline,
        createdTime: createdTime);
    await ProjectDatabase.instance
        .create(project)
        .whenComplete(() => Get.offAllNamed(Routes.HOME));
  }

  Future addFirstTask(
      int projectId, String projectTitle, String firstTask) async {
    final status = 'To do';
    final Task task = Task(
        projectId: projectId,
        projectTitle: projectTitle,
        task: firstTask,
        status: status);

    await TaskDatabase.instance
        .create(task)
        .whenComplete(() => Get.offAllNamed(Routes.HOME));
  }
}
