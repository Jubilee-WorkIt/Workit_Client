// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:workit_app/features/auth/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase already initialized: $e");
  }

  runApp(const WorkitApp());
}

class WorkitApp extends StatelessWidget {
  const WorkitApp({super.key});

  @override
  Widget build(BuildContext context) {
    // [추가] 앱 전체에서 사용할 공통 자간 설정
    const double globalLetterSpacing = -0.8;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Workit',
      theme: ThemeData(
        fontFamily: 'Pretendard',
        scaffoldBackgroundColor: Colors.white,

        // 1. 일반 Text 위젯들에 대한 자간 설정
        textTheme: const TextTheme(
          bodyLarge: TextStyle(letterSpacing: globalLetterSpacing),
          bodyMedium: TextStyle(letterSpacing: globalLetterSpacing),
          titleLarge: TextStyle(letterSpacing: globalLetterSpacing),
          titleMedium: TextStyle(letterSpacing: globalLetterSpacing),
          labelLarge: TextStyle(letterSpacing: globalLetterSpacing),
        ),

        // 2. 모든 입력창(TextField)의 힌트 및 기본 스타일에 대한 자간 설정
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(
            letterSpacing: globalLetterSpacing,
            color: Color(0xFFBCC1C3),
          ),
          labelStyle: TextStyle(letterSpacing: globalLetterSpacing),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}