import 'package:get/get.dart';
import 'package:luvit_dating_app/app/modules/spot/controllers/spot_controller.dart';


class SpotBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpotController>(
      () => SpotController(),
    );
  }
}
