import 'package:get/get.dart';
import 'package:luvit_dating_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:luvit_dating_app/app/modules/spot/controllers/spot_controller.dart';

import '../../me/controllers/settings_controller.dart';
import '/app/modules/home/controllers/home_controller.dart';
import '/app/modules/main/controllers/main_controller.dart';
import '/app/modules/other/controllers/other_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
      fenix: true,
    );
    Get.lazyPut<OtherController>(
      () => OtherController(),
      fenix: true,
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );
    Get.lazyPut<SpotController>(
      () => SpotController(),
    );
    Get.lazyPut<ChatController>(
          () => ChatController(),
    );
    Get.lazyPut<SettingsController>(
      () => SettingsController(),
    );
  }
}
