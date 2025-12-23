import 'package:flutter/material.dart';

class Responsive {
  static const double mobileBreakpoint = 768.0;

  // BuildContext를 사용하여 현재 화면이 모바일인지 확인
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }
}