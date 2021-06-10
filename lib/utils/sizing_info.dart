import 'package:flutter/material.dart';

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width > tabletSmall;
}

bool isTablet(BuildContext context) {
  return MediaQuery.of(context).size.width >= tabletSmall &&
      MediaQuery.of(context).size.width < tabletExtraLarge;
}

bool isDesktop(BuildContext context) {
  return MediaQuery.of(context).size.width > desktopSmall;
}

bool isMobileAndTablet(BuildContext context) {
  return MediaQuery.of(context).size.width <= tabletExtraLarge;
}

double get mobileSmall => 320;

double get tabletSmall => 600;

double get tabletExtraLarge => 900;

double get desktopSmall => 950;
