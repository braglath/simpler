import 'package:get/get.dart';
import 'package:simpler/app/data/database/project_database.dart';
import 'package:simpler/app/data/database/task_database.dart';
import 'package:simpler/app/data/user_data/user_data.dart';

class ProfilePageController extends GetxController {
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void logoutandClearData() async {
    Get.back();
    isLoading.value = true;
    await ProjectDatabase.instance
        .deleteDataBase()
        .whenComplete(() async => await TaskDatabase.instance.deleteDataBase())
        .whenComplete(() => UserDataDetails().deleteUserDetails())
        .whenComplete(() => isLoading.value = false);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
