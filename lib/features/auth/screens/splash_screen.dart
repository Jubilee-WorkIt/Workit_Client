// splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:workit_app/core/style/app_colors.dart';
import 'package:workit_app/features/auth/screens/login_screen.dart';
// import 'package:workit_app/features/auth/screens/login_screen.dart';
// import 'package:workit_app/features/seeker/widgets/seeker_bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // 3~5초 정도가 적당하지만, 기존 요청대로 10초 유지합니다.
    _timer = Timer(const Duration(seconds: 10), _navigateToLogin);
  }

  void _navigateToLogin() {
  if (!mounted) return;
  _timer?.cancel();


  Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => const LoginScreen()),
  );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragEnd: (details) {
        final velocity = details.primaryVelocity ?? 0;
        if (velocity.abs() > 300) {
          _navigateToLogin();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.mainWhite,
        body: Stack(
          children: [
            // 1. 중앙 로고
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4, // 화면 높이의 20% 지점 (위로 올림)
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 300, // 로고 크기 조정
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // 2. 우측 하단 캐릭터 (레퍼런스처럼 배치)
            Positioned(
              right: -20, // 화면 밖으로 살짝 나가게 조정 가능
              bottom: 0,
              child: Image.asset(
                'assets/images/koala_peek.png', // 고개 내민 코알라 이미지 파일명 확인
                width: 251.008,
              ),
            ),
          ],
        ),
      ),
    );
  }
}