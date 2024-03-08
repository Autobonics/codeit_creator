import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreatorConsts {
  static const inputModuleColor = Color(0xffD63B9B);
  static const outputModuleColor = Color(0xffFFC300);
  static const plutoColor = Color(0xff0088CC);

  static const double categoriesDrawerWidth = 220;

  static const Color creatorMainColor = Color(0xffFDA78B);

  static const Color creatorMoveColor = Color(0xff990011);
  static const Color creatorTextColor = Color(0xff9966ff);
  static const Color creatorInputColor = Color(0xffF96167);
  static const Color creatorDisplayColor = Color(0xffFFC300);
  static const Color creatorMusicColor = Color(0xff317773);
  static const Color creatorRotateColor = Color(0xff3A6B35);
  static const Color creatorMovementColor = Color(0xff234E70);
  static const Color creatorButtonColor = Color(0xffEF2B95);
  static const Color creatorAiColor = Color(0xff0088CC);
  static const Color creatorFunctionsColor = Color(0xff28282B);

  static const int totalTextures = 0;

  static const Color cominSoonCardColor = Color(0xffFFC300);
  static const Color cominSoonInnerCardColor = Color.fromARGB(255, 153, 118, 1);

  static final List<Color> textureColors = [
    Colors.white,
    plutoColor,
    outputModuleColor,
    inputModuleColor,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.blueGrey,
    Colors.orange,
    Colors.redAccent,
  ];

  static const int DriveLeftMotorPort = 1;
  static const int DriveRightMotorPort = 5;

  static AppLocalizations? getLocale(BuildContext context) {
    return AppLocalizations.of(context);
  }
}
