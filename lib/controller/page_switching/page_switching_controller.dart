import 'package:flutter/material.dart';

class PageSwitchingController with ChangeNotifier {
  int _activePageIndex;

  PageSwitchingController({required activePageIndex}) : _activePageIndex = activePageIndex;

  void setActivePageIndex({required int activePageIndex}){
    _activePageIndex = activePageIndex;
    notifyListeners();
  }

  int getActivePageIndex() {
    return _activePageIndex;
  }
}