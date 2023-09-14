import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luvit_dating_app/app/core/utils/util.dart';
import 'package:luvit_dating_app/app/core/values/app_colors.dart';
import 'package:luvit_dating_app/app/core/values/text_styles.dart';
import 'package:luvit_dating_app/app/core/widget/asset_image_view.dart';
import 'package:luvit_dating_app/app/data/model/user_dating.dart';

import '../widget/item_card_dating.dart';
import '/app/core/base/base_view.dart';
import '/app/core/values/app_values.dart';
import '/app/modules/home/controllers/home_controller.dart';

class HomeView extends BaseView<HomeController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    var like = 323322;

    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      leading: const AssetImageView(fileName: 'ic_spot_appbar.png', width: AppValues.iconSmallerSize, height: AppValues.iconSmallerSize,),
      title: Text('${appLocalization.yourLocation}${appLocalization.whatsNew} ${appLocalization.spot}'),

      titleSpacing: 0,
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.smallPadding),
          margin: const EdgeInsets.symmetric(vertical: AppValues.smallPadding),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.colorBorderGrey),
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(AppValues.radius),
                right: Radius.circular(AppValues.radius))
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const AssetImageView(fileName: 'ic_star.png', color: AppColors.colorSecondary,),
              const SizedBox(width: 8,),
              Text(like.toCommaSeparated, style: whiteText13,)
            ],
          ),
        ),

        const AssetImageView(fileName: 'ic_notification.png')
      ],
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(()=> controller.userDating.isNotEmpty
        ? pageCardWidget()
        : noCardWidget()
    ).marginOnly(bottom: AppValues.heightBottomAppBar);
  }

  Widget pageCardWidget(){
    return PageView(
      controller: controller.pageController,
      scrollDirection: Axis.horizontal,
      children: controller.userDating.map((userDating){
        int index = 0;

        return Draggable<UserDating>(
            feedback: Material(color: Colors.transparent,
              child: Obx(()=>ItemCardDating(item: userDating,
                height: Get.height*4/5,width: Get.width*9/10,
                showDelete: controller.showDelete, index: index,
              )),
            ),
            onDragUpdate: (details){
              controller.onDragUpdate(details);
            },
            onDragEnd: (details){
              controller.onDragEnd(details, userDating);
            },
            childWhenDragging: Container(),
            child: ItemCardDating(item: userDating,
              onSelectedIndex: (val) => index = val,));
      }).toList(),
    );
  }

  Widget noCardWidget(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(appLocalization.preparingTitle, style: bigTitleWhiteStyle, textAlign: TextAlign.center,),
        Text(appLocalization.preparingDescription, style: whiteText16.copyWith(color: AppColors.textColorGrey100), textAlign: TextAlign.center,)
      ],
    );
  }

}
