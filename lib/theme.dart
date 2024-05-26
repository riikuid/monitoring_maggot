import 'package:flutter/material.dart';

// COLOR SCHEME
Color whiteColor = const Color(0xFFFEFDFF);
Color blackColor = const Color(0xFF0E0E0E);

Color subtitleTextColor = const Color(0xFF808080);
Color hintTextColor = const Color(0xFFBAC2C7);

Color greyBackgroundColor = const Color(0xFFE5E5E5);

Color disabledColor = const Color(0xFFC4C4C4);
Color transparentColor = Colors.transparent;

Color primaryColor500 = const Color(0xFF75A8DE);
Color secondaryColor = const Color(0xFFFFFFE8);

Color greenLableColor = const Color(0xFF00D26E);
Color orangeLableColor = const Color(0xFFFA9F3C);

// TEXT STYLE
TextStyle primaryTextStyle = TextStyle(
  color: blackColor,
);

TextStyle headingSmallTextStyle = primaryTextStyle.copyWith(fontSize: 14);
TextStyle headingNormalTextStyle = primaryTextStyle.copyWith(fontSize: 16);
TextStyle headingMediumTextStyle = primaryTextStyle.copyWith(fontSize: 20);
TextStyle headingLargeTextStyle = primaryTextStyle.copyWith(fontSize: 24);
TextStyle headingExtraLargeTextStyle = primaryTextStyle.copyWith(fontSize: 40);

TextStyle paragraphSmallTextStyle = primaryTextStyle.copyWith(fontSize: 12);
TextStyle paragraphNormalTextStyle = primaryTextStyle.copyWith(fontSize: 14);
TextStyle paragraphLargeTextStyle = primaryTextStyle.copyWith(fontSize: 18);

TextStyle labelSmallTextStyle = primaryTextStyle.copyWith(fontSize: 10);
TextStyle labelNormalTextStyle = primaryTextStyle.copyWith(fontSize: 12);
TextStyle labelLargeTextStyle = primaryTextStyle.copyWith(fontSize: 14);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semibold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

// SHADOW
BoxShadow defaultShadow = const BoxShadow(
  color: Color(0x19000000),
  blurRadius: 10,
  offset: Offset(0, 0),
);
