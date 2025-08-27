part of 'info_popup.dart';

class MultipleDetectionsPopup extends InfoPopup {
  const MultipleDetectionsPopup({super.key, required super.transparentBackground, required super.widthPercentage, required super.heightPercentage});

  @override
  List<Widget> _getContentItems(BuildContext context){
    return [
      SizedBox(
        height: getHeight(context) * 0.1,
        child: Align(
          alignment: Alignment.center,
          child: AutoSizeText(
              "Wykryto więcej niż jeden paznokieć.",
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
              InfoButton(translationEntry: "Wróć do ekranu głównego", pageToGo: MainPage(), widthPercentage: widthPercentage * 0.4, heightPercentage: heightPercentage * 0.3),
              InfoButton(translationEntry: "Zrób zdjęcie ponownie", pageToGo: CameraPage(), widthPercentage: widthPercentage * 0.4, heightPercentage: heightPercentage * 0.3),
              // Wybierz konkretny paznokieć
            ],
          ),
        ],
      )
    ];
  }
}