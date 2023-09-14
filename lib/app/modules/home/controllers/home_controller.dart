import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luvit_dating_app/app/data/model/user_dating.dart';
import 'package:luvit_dating_app/app/data/repository/user_repository.dart';

import '/app/core/base/base_controller.dart';

class HomeController extends BaseController {

  final UserRepository repository = Get.find(tag: (UserRepository).toString());

  final _userDating = <UserDating>[].obs;
  List<UserDating> get userDating => _userDating.toList();
  set userDating(List<UserDating>val) => _userDating.value = val;

  final _showDelete = false.obs;
  bool get showDelete => _showDelete.value;
  set showDelete(bool val) => _showDelete.value = val;

  final _dragUpdate = const Offset(0,0).obs;
  Offset get dragUpdate => _dragUpdate.value;
  set dragUpdate(Offset val) => _dragUpdate.value = val;

  final pageController = PageController(initialPage: 0, viewportFraction: 0.9);



  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  loadData(){
    // userDating = dummyData;
    callDataService(repository.getUserDating(),
      onSuccess: (response){
        userDating = response as List<UserDating>;
      }
    );
  }

  onDragUpdate(DragUpdateDetails details){
    var offset = dragUpdate;
    var setX = offset.dx + details.delta.dx;
    var setY = offset.dy + details.delta.dy;
    dragUpdate = Offset(setX, setY);
    showDelete = setX < 0 && setY > 0;
  }

  onDragEnd(DraggableDetails details, UserDating user){
    dragUpdate = const Offset(0, 0);
    showDelete = false;
    if(details.offset.dx < 0 && details.offset.dy > 0){
      var dataList = userDating;
      dataList.removeWhere((element) => element.name == user.name);
      userDating = dataList;
    }
  }

}
