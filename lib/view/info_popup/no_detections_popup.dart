part of 'info_popup.dart';

class NoDetectionsPopup extends InfoPopup {
  const NoDetectionsPopup({super.key, required super.transparentBackground, required super.widthPercentage, required super.heightPercentage});

  @override
  List<Widget> _getContentItems(BuildContext context){
    return [
      SizedBox(
        height: getHeight(context) * 0.1,
        child: Align(
          alignment: Alignment.center,
          child: AutoSizeText(
              "Nie wykryto paznokcia.",
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
              InfoButton(translationEntry: "Wróć do ekranu głównego", pageToGo: HomePage(), widthPercentage: 0.2, heightPercentage: 0.2),
              InfoButton(translationEntry: "Zrób zdjęcie ponownie", pageToGo: CameraPage(), widthPercentage: 0.2, heightPercentage: 0.2),
            ],
          ),
        ],
      )
    ];
  }
}