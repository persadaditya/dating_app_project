import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:luvit_dating_app/app/core/base/base_view.dart';

import '../../../core/values/text_styles.dart';
import '../controllers/chat_controller.dart';

class ChatView extends BaseView<ChatController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text(appLocalization.chatting),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Text(appLocalization.workingProgress,
        style: titleStyleWhite,
      ),
    );
  }

}
