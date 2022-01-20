import 'package:get/get.dart';

import '../controllers/pick_deadline_controller.dart';

class PickDeadlineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickDeadlineController>(
      () => PickDeadlineController(),
    );
  }
}
