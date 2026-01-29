import 'package:flutter/material.dart';

class AppLayout {
  static const double horizontalPadding = 30.0;
  static const double sectionSpacing = 30.0;
  static const double inputSpacing = 20.0;
  static const double borderRadius = 30.0; // 👈 이 숫자만 바꾸면 모든 버튼/입력창이 바뀝니다.
}

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  
  static const TextStyle hint = TextStyle(
    color: Colors.grey,
    fontSize: 14,
  );
}