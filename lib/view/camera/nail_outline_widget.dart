import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/other/dimension_utils.dart';

import '../../main.dart';

class NailOutlineWidget extends StatelessWidget{
  const NailOutlineWidget({super.key});

  @override
  Widget build(BuildContext context){
    return Center(
        child: Stack(
            children: [
              Center(
                child: Opacity(
                  opacity: 0.7,
                  child: ImageIcon(
                    AssetImage("resources/nailoutline.png"),
                    size: getWidth(context) / 2.5,
                  ),
                ),
              ),
              Center(
                child: Opacity(
                  opacity: 0.3,
                  child: Icon(
                    Icons.square_rounded,
                    size: getWidth(context) / 1.2,
                  ),
                ),
              ),
            ]
        )
    );
  }
}