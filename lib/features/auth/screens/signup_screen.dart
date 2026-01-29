import 'package:flutter/material.dart';
import 'package:workit_app/core/style/app_colors.dart';
import 'login_screen.dart';
import '../../../core/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25), // 뒤로가기 버튼 공간

              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                child: Image.asset(
                  'assets/images/light_arrow-back.png',
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 35), // 뒤로가기 버튼과 로고 사이 간격

              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 240,
                  height: 50.64,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 50), // 로고와 타이틀 사이 간격

              const Text(
                'Create your Account',
                style: TextStyle(
                  color: AppColors.inputBackground,
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),

              // [수정] 이메일 입력창: 빨간 줄 해결 (hintLetterSpacing 추가 및 const 제거)
              const CustomTextField(
                hint: 'Email',
                hintLetterSpacing: -0.5,
              ),
              const SizedBox(height: 16),
              
              // [수정] 비밀번호 입력창: 빨간 줄 해결 (hintLetterSpacing 추가 및 const 제거)
              const CustomTextField(
                hint: 'Password',
                isPassword: true,
                hintLetterSpacing: -0.5,
              ),
              const SizedBox(height: 16),

              // [수정] 비밀번호 확인창: 빨간 줄 해결 (hintLetterSpacing 추가 및 const 제거)
              const CustomTextField(
                hint: 'Confirm Password', 
                isPassword: true,
                hintLetterSpacing: -0.5,
              ),

              const SizedBox(height: 40),

              const _SignUpButton(),
              
              const SizedBox(height: 50),
              
              const _SocialDivider(),
              
              const SizedBox(height: 50),
              
              const _SocialIconsRow(),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 회원가입 처리 로직 여기에 추가
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainSkyblue,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(color: Color(0xFF000000), fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _SocialDivider extends StatelessWidget {
  const _SocialDivider();
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: Color(0xFFBCC1C3))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Or sign up with', style: TextStyle(color: Color(0xFFBCC1C3), fontSize: 14)),
        ),
        Expanded(child: Divider(color: Color(0xFFBCC1C3))),
      ],
    );
  }
}

class _SocialIconsRow extends StatelessWidget {
  const _SocialIconsRow();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialCircle('assets/images/google.png'),
        const SizedBox(width: 16),
        _socialCircle('assets/images/apple.png'),
      ],
    );
  }

  Widget _socialCircle(String path) {
    return Container(
      width: 70, height: 70,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF2F2F2)),
      child: Center(child: Image.asset(path, width: 24)),
    );
  }
}