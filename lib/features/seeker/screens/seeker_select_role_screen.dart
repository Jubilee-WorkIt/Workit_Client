import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SeekerSelectRoleScreen()));

class SeekerSelectRoleScreen extends StatefulWidget {
  const SeekerSelectRoleScreen({super.key});

  @override
  State<SeekerSelectRoleScreen> createState() => _SeekerSelectRoleScreenState();
}

class _SeekerSelectRoleScreenState extends State<SeekerSelectRoleScreen> {
  // 현재 선택된 인덱스 저장 (0: Short-term, 1: Long-term, 2: No preference)
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    // 배경색 및 테마 설정
    const Color backgroundColor = Color(0xFF001533); // 어두운 네이비색
    const Color primaryBlue = Color(0xFF76C8FF);   // 밝은 하늘색

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios, color: Colors.white),
        title: const Text('Select field of interest', style: TextStyle(color: Colors.white, fontSize: 18)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            
            // 1. 상단 진행 바 (5단계 중 1단계)
            Row(
              children: List.generate(5, (index) {
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: index == 0 ? primaryBlue : Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerRight,
              child: Text('1 / 5', style: TextStyle(color: Colors.white, fontSize: 12)),
            ),

            const Spacer(flex: 1),

            // 2. 중앙 아이콘 (이미지의 하늘색 원 부분)
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFFBDE7FF),
            ),
            const SizedBox(height: 30),

            // 3. 텍스트 문구
            const Text(
              'What kind of job are you\nlooking for?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Choose the type of job you want to apply for.',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 40),

            // 4. 선택 버튼 리스트
            _buildOptionButton(0, 'Short-term'),
            const SizedBox(height: 12),
            _buildOptionButton(1, 'Long-term'),
            const SizedBox(height: 12),
            _buildOptionButton(2, 'No preference'),

            const Spacer(flex: 2),

            // 5. 하단 네비게이션 버튼 (Previous, Next)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Previous', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 0,
                    ),
                    child: const Text('Next', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // 선택 버튼 위젯 빌더
  Widget _buildOptionButton(int index, String label) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedIndex = index),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF76C8FF) : const Color(0xFFE5E9ED),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}