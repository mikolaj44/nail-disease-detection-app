import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';

import '../../controller/page_switching/page_switching_controller.dart';
import '../../controller/storage/storage_controller.dart';
import '../../utils/other/style/style_methods.dart';
import 'custom_navigation_bar.dart';

class CustomNavigationBarButton extends StatelessWidget{
  final Color iconColor;
  final IconData iconData;
  final Widget switchWidget;

  const CustomNavigationBarButton({required this.switchWidget, required this.iconData, required this.iconColor, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black.withOpacity(0.3),
      highlightColor: Colors.black.withOpacity(0.3),
      onTap: () => pageSwitchingController.setActivePage(context: context, switchWidget: switchWidget),
      child: SizedBox(
          width: getWidth(context) / 3,
          height: getHeight(context) * CustomNavigationBar.HEIGHT_PERCENTAGE,
          child: Icon(
            iconData,
            color: iconColor,
            size: getMinDimension(context) / 10,
          )
      ),
    );
  }
}