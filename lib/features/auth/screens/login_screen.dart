import 'package:flutter/material.dart';
import 'package:workit_app/core/style/app_colors.dart';
import 'package:workit_app/features/auth/screens/signup_screen.dart';
import 'role_selection_screen.dart';
import '../../../core/widgets/custom_text_field.dart';
import 'package:workit_app/features/auth/services/google_auth_service.dart';
// import 'package:workit_app/features/seeker/widgets/seeker_bottom_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              const SizedBox(height: 98),
              // 로고
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/images/logo.png', width: 240, height: 50.64),
              ),
              const SizedBox(height: 50),
              const Text(
                'Login to your Account',
                style: TextStyle(
                  color: AppColors.inputBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              
              // [수정] 힌트 자간 적용을 위해 const를 제거하고 매개변수 추가
              const CustomTextField(
                hint: 'Email',
                hintLetterSpacing: -0.5, // 힌트 텍스트 자간 설정
              ),
              const SizedBox(height: 16),
              
              // [수정] 힌트 자간 적용을 위해 const를 제거하고 매개변수 추가
              const CustomTextField(
                hint: 'Password',
                isPassword: true,
                hintLetterSpacing: -0.5, // 힌트 텍스트 자간 설정
              ),
              
              const SizedBox(height: 40),
              
              // [수정된 부분] 일반 로그인 버튼: 즉시 역할 선택 페이지로 이동
              const _LoginButton(),
              
              const SizedBox(height: 50),
              const _SocialDivider(),
              const SizedBox(height: 50),
              
              // 소셜 로그인 아이콘들
              const _SocialIconsRow(),
              
              const SizedBox(height: 65),
              const _LoginPrompt(),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          // 버튼 클릭 시 즉시 RoleSelectionScreen으로 교체
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainSkyblue,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
            ),
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
          child: Text('Or sign in with', style: TextStyle(
            color:  Color(0xFFBCC1C3),
            fontSize: 14,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            letterSpacing: 0.1,
            )),
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
        _socialCircle(
          context,
          'assets/images/google.png',
          onTap: () async {
            final googleAuthService = GoogleAuthService();
            final user = await googleAuthService.signInWithGoogle();
            
            if (user != null && context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
              );
            }
          },
        ),    
        const SizedBox(width: 16),
        _socialCircle(context, 'assets/images/apple.png'),
      ],
    );
  }

  Widget _socialCircle(BuildContext context, String path, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70, height: 70,
        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFF2F2F2)),
        child: Center(child: Image.asset(path, width: 24)),
      ),
    );
  }
}

class _LoginPrompt extends StatelessWidget {
  const _LoginPrompt();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?", style: TextStyle(
          color:  Color(0xFFBCC1C3),
          fontSize: 14,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w400,
          letterSpacing: 0.01,
          )),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SignUpScreen()),
          ),
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color:  Color(0xFF43C7FF),
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.01,
              ),
          ),
        ),
      ],
    );
  }
}