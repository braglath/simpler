import 'package:get/get.dart';

import '../controllers/all_projects_controller.dart';

class AllProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllProjectsController>(
      () => AllProjectsController(),
    );
  }
}
