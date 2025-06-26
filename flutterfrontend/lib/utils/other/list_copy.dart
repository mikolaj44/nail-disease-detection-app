import 'package:flutter_application_1/utils/interfaces/copyable.dart';

List<T> listCopy<T extends Copyable<T>>(List<T> origList){
  List<T> newList = [];

  for(T el in origList){
    newList.add(el.copy());
  }

  return newList;
}