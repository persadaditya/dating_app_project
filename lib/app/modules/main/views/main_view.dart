import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luvit_dating_app/app/core/values/app_colors.dart';
import 'package:luvit_dating_app/app/core/widget/asset_image_view.dart';
import 'package:luvit_dating_app/app/modules/chat/views/chat_view.dart';
import 'package:luvit_dating_app/app/modules/main/views/bottom_app_bar.dart';
import 'package:luvit_dating_app/app/modules/spot/views/spot_view.dart';

import '../../me/views/settings_view.dart';
import '/app/core/base/base_view.dart';
import '/app/modules/home/views/home_view.dart';
import '/app/modules/main/controllers/main_controller.dart';
import '/app/modules/main/model/menu_code.dart';
import '/app/modules/other/views/other_view.dart';

// ignore: must_be_immutable
class MainView extends BaseView<MainController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Obx(() => getPageOnSelectedMenu(controller.selectedMenuCode)),
    );
  }

  @override
  Widget? bottomNavigationBar() {
    return CustomBottomAppBar(
        items: _getNavItems(),
        selectedColor: AppColors.colorSecondary,
        color: AppColors.colorBlack300,
        onTabSelected: (index){
          if(index==0){
            controller.selectedMenuCode = MenuCode.HOME;
          }
          if(index==1){
            controller.selectedMenuCode = MenuCode.SPOT;
          }
          if(index==2){
            controller.selectedMenuCode = MenuCode.CHAT;
          }
          if(index==3){
            controller.selectedMenuCode = MenuCode.ME;
          }
        }
    );
  }

  @override
  Widget? floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.black,
        onPressed: (){
          //TODO
        },
      child: const AssetImageView(fileName: 'ic_fab_like.png',),
    );
  }

  final HomeView homeView = HomeView();
  SpotView? spotView;
  ChatView? chatView;
  SettingsView? settingsView;

  Widget getPageOnSelectedMenu(MenuCode menuCode) {
    switch (menuCode) {
      case MenuCode.HOME:
        return homeView;
      case MenuCode.SPOT:
        spotView ??= SpotView();
        return spotView!;
      case MenuCode.CHAT:
        chatView ??= ChatView();
        return chatView!;
      case MenuCode.ME:
        settingsView ??= SettingsView();
        return settingsView!;
      default:
        return OtherView(
          viewParam: describeEnum(menuCode),
        );
    }
  }

  List<FABBottomAppBarItem> _getNavItems() {
    return [
      FABBottomAppBarItem(text: appLocalization.home,
        iconData: 'ic_home.svg',
      ),
      FABBottomAppBarItem(text: appLocalization.spot,
        iconData: 'ic_spot.svg',
      ),
      FABBottomAppBarItem(text: appLocalization.chatting,
        iconData: 'ic_chatting.svg',
      ),
      FABBottomAppBarItem(text: appLocalization.me,
        iconData: 'ic_me.svg',
      ),
    ];
  }
}
