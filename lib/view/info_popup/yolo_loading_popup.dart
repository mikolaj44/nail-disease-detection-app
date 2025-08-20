part of "info_popup.dart";

class YOLOLoadingPopup extends InfoPopup {
  const YOLOLoadingPopup({super.key, required super.transparentBackground, required super.widthPercentage, required super.heightPercentage});

  @override
  List<Widget> _getContentItems(BuildContext context){
    return [
      SizedBox(
        height: getHeight(context) * 0.1,
        child: Align(
          alignment: Alignment.center,
          child: AutoSizeText(
              context.tr("yolo_loading"),
              textAlign: TextAlign.center,
              wrapWords: false,
              minFontSize: 0,
              maxLines: 3,
              style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
          ),
        ),
      ),
      Divider(thickness: 2),
    ];
  }

  @override
  List<Widget> _getButtons(BuildContext context){
    return [];
  }
}