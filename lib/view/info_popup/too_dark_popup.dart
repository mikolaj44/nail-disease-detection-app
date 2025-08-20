part of 'info_popup.dart';

class TooDarkPopup extends InfoPopup {
  const TooDarkPopup({super.key, required super.transparentBackground, required super.widthPercentage, required super.heightPercentage});

  @override
  List<Widget> _getContentItems(BuildContext context){
    return [
      SizedBox(
        height: getHeight(context) * 0.1,
        child: Align(
          alignment: Alignment.center,
          child: AutoSizeText(
              "Zdjęcie jest zbyt ciemne.",
              textAlign: TextAlign.center,
              wrapWords: false,
              minFontSize: 0,
              maxLines: 2,
              style: getTextStyle(context, Color.fromARGB(255, 255, 255, 255), fontSize: getMinDimension(context) * 60)
          ),
        ),
      ),
      Divider(thickness: 2),
    ];
  }

  @override
  List<Widget> _getButtons(BuildContext context){
    return [
      Column(
        children: [
          SizedBox(
            height: getHeight(context) * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InfoButton(translationEntry: "Wróć do ekranu głównego", doesPushWidget: false, pageToGo: SizedBox(), widthPercentage: widthPercentage * 0.4, heightPercentage: heightPercentage * 0.3),
              InfoButton(translationEntry: "Zrób zdjęcie ponownie", doesPushWidget: true, pageToGo: CameraPage(), widthPercentage: widthPercentage * 0.4, heightPercentage: heightPercentage * 0.3),
            ],
          ),
        ],
      )
    ];
  }
}