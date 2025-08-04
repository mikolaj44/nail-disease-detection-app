import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

double getWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context){
  return MediaQuery.of(context).size.height;
}

double getMinDimension(BuildContext context){
  return math.min(getWidth(context), getHeight(context));
}