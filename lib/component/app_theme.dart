import 'dart:ui';

import 'package:get/get.dart';

class AppThemes{

  AppThemes._();


  static bool isTablet = Get.width > 1000 || Get.height > 1000;
  static double containerWidth = isTablet ? 800 : 500;
  static double h1FontSize = isTablet ? 50 : 20;
  static double h2FontSize = isTablet ? 30 : 20;
  static double h3FontSize = isTablet ? 20 : 14;
  static double h4FontSize = isTablet ? 17 : 15;
  static double h5FontSize = isTablet ? 15 : 10;
  static double evSwitchSize = isTablet ? 5 : 5;
  static double loginButtonHeight = isTablet ? 65 : 50;
  static double loginButtonWidth = isTablet ? 350 : 200;

  static double switchHeight = isTablet ? 75 : 50;
  static double switchWidth = isTablet ? 100 : 75;

  static double iconSize = isTablet ? 45 : 25;

  //HOME
  static double homeBatterySize = isTablet ? 120 : 65;
  static double homeHeaderIconSize = isTablet ? 50 : 25;

  //SPLASH SCREEN
  static double splashLogoHeight = isTablet ? 220 : 110;
  static double splashLogoWidth = isTablet ? 500 : 250;

  static double splashInverterHeight = isTablet ? 150 : 75;
  static double splashInverterWidth = isTablet ? 150 : 75;

  // static double batteryPercentFontSize = isTablet ?

  static const Color mainColorGreen = Color(0xff4fbba9);
  static const Color mainColorBlue = Color(0xff233c7b);
  static const Color mainColorYellow = Color(0xfff8dd6c);
  static const Color mainColorOrange = Color(0xffffb54d);
  static const Color mainColorRed = Color(0xffeb5b56);
  static const Color mainColorGrey = Color(0xff9e9e9e);
  static const Color mainColorDarkGrey = Color(0xff616161);

  static const Color offWhite = Color(0xfff9f9f9);
  static const Color disabledGrey = Color(0xffebebe4);

  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color whiteLilac = Color.fromRGBO(248, 250, 252, 1);
  static const Color blackPearl = Color.fromRGBO(30, 31, 43, 1);

  static const Color nevada = Color.fromRGBO(105, 109, 119, 1);
  static const Color absoluteBlack = Color(0xff2e2e30);

}