import 'package:flutter/material.dart';
import 'package:workit_app/core/style/app_colors.dart';
import '../style/app_styles.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final double hintLetterSpacing; // 자간 변수 추가

  const CustomTextField({
    super.key, 
    required this.hint, 
    this.isPassword = false, 
    this.hintLetterSpacing = -0.8, // [수정] required 대신 기본값을 -0.8로 설정 (빨간 줄 방지)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(AppLayout.borderRadius),
      ),
      child: TextField(
        obscureText: isPassword,
        // 실제 입력되는 텍스트 스타일 (필요 시 자간 추가 가능)
        style: const TextStyle(
          color: Colors.black, // 입력 텍스트 색상
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hint,
          // [핵심 수정] 전달받은 hintLetterSpacing을 실제 스타일에 적용
          hintStyle: TextStyle(
            color: const Color(0xFFBCC1C3), 
            fontSize: 16,
            letterSpacing: hintLetterSpacing, // 여기서 자간이 적용됩니다.
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
        ),
      ),
    );
  }
}