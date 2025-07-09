import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/view/camera/camera_page.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/page_switching/page_switching_controller.dart';
import '../../controller/storage/storage_controller.dart';
import '../../utils/other/style/style_methods.dart';

class CustomNavigationBarButton extends StatefulWidget{
  final Color iconColor = Colors.white60;
  final IconData iconData;
  final Widget switchWidget;

  const CustomNavigationBarButton({required this.switchWidget, required this.iconData, super.key});

  @override
  State<CustomNavigationBarButton> createState() => CustomNavigationBarButtonState();
}

class CustomNavigationBarButtonState extends State<CustomNavigationBarButton> {
  late Color iconColor;
  late IconData iconData;
  late Widget switchWidget;

  @override
  void initState() {
    super.initState();
    iconColor = widget.iconColor;
    iconData = widget.iconData;
    switchWidget = widget.switchWidget;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black.withOpacity(0.3),
      highlightColor: Colors.black.withOpacity(0.3),
      onTap: () => pageSwitchingController.setActivePage(context: context, switchWidget: switchWidget),
      child: SizedBox(
          width: getWidth(context) / 3,
          height: getHeight(context) * 0.15,
          child: Icon(
            iconData,
            color: iconColor,
            size: getMinDimension(context) / 10,
          )
      ),
    );
  }
}