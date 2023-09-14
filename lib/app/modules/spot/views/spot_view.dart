import 'package:flutter/material.dart';
import 'package:luvit_dating_app/app/modules/spot/controllers/spot_controller.dart';

import '/app/core/base/base_view.dart';
import '/app/core/values/text_styles.dart';

class SpotView extends BaseView<SpotController> {
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text(appLocalization.spot),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Center(
      child: Text(
        appLocalization.workingProgress,
        style: titleStyleWhite,
      ),
    );
  }
}
