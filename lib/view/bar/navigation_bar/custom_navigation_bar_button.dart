import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/utils/dimension_utils.dart';
import 'package:flutter_application_1/controller/page_switching/page_switching_controller.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigationBarButton extends StatelessWidget {
  final int _switchWidgetIndex;
  final Color _iconColor;
  final IconData _iconData;

  const CustomNavigationBarButton({super.key, required switchWidgetIndex, required iconData, required iconColor}) : _switchWidgetIndex = switchWidgetIndex, _iconColor = iconColor, _iconData = iconData;

  @override
  Widget build(BuildContext context) {
    return Consumer<PageSwitchingController> (
        builder: (context, analysis, child) {
          return InkWell(
            splashColor: Colors.black.withOpacity(0.3),
            highlightColor: Colors.black.withOpacity(0.3),
            onTap: () => pageSwitchingController.setActivePageIndex(activePageIndex: _switchWidgetIndex),
            child: SizedBox(
                width: getWidth(context) / 3,
                height: getHeight(context) * 0.12,
                child: Icon(
                  _iconData,
                  color: pageSwitchingController.getActivePageIndex() == _switchWidgetIndex ? Colors.white : _iconColor,
                  size: getMinDimension(context) / 10,
                )
            ),
          );
    });
  }
}