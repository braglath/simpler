import 'package:get/get.dart';

import '../controllers/project_avatar_controller.dart';

class ProjectAvatarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectAvatarController>(
      () => ProjectAvatarController(),
    );
  }
}
