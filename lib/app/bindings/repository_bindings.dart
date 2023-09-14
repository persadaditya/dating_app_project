import 'package:get/get.dart';

import '/app/data/repository/user_repository.dart';
import '/app/data/repository/user_repository_impl.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    //TODO: put your repo dependencies here
    Get.lazyPut<UserRepository>(
      () => UserRepositoryImpl(),
      tag: (UserRepository).toString(),
    );
  }
}
