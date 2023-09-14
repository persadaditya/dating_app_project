import 'package:get/get.dart';

import '/app/data/remote/user_remote_data_source.dart';
import '/app/data/remote/user_remote_data_source_impl.dart';

class RemoteSourceBindings implements Bindings {
  @override
  void dependencies() {
    //TODO: put your remote dependencies here
    Get.lazyPut<UserRemoteData>(
      () => UserRemoteDataImpl(),
      tag: (UserRemoteData).toString(),
    );
  }
}
