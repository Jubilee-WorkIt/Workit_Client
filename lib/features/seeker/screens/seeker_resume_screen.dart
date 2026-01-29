import 'package:flutter/material.dart';

class SeekerResumeScreen extends StatefulWidget {
  const SeekerResumeScreen({super.key});

  @override
  // [수정] 아래 클래스 이름과 동일하게 맞춰야 합니다.
  State<SeekerResumeScreen> createState() => _SeekerResumeScreenState();
}

// [수정] 클래스 이름을 위와 일치시키고, State 뒤의 제네릭도 맞춰줍니다.
class _SeekerResumeScreenState extends State<SeekerResumeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF001437), // 요청하신 배경색 적용
      body: Center(
        child: Text(
          "Resume Screen Hello",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}