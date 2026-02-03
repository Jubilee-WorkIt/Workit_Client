import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:workit_app/features/seeker/screens/seeker_home_screen.dart';
import 'package:workit_app/features/seeker/screens/seeker_resume_screen.dart';
import 'package:workit_app/features/seeker/screens/seeker_financial_screen.dart';
import 'package:workit_app/features/seeker/screens/seeker_chat_list_screen.dart';
import 'package:workit_app/features/seeker/screens/seeker_myworkit_screen.dart';


class SeekerBottomBar extends StatefulWidget {
  const SeekerBottomBar({super.key});

  @override
  State<SeekerBottomBar> createState() => _SeekerBottomBarState();
}

class _SeekerBottomBarState extends State<SeekerBottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const SeekerHomeScreen(),
    const SeekerResumeScreen(),
    const SeekerFinancialScreen(),
    const SeekerChatsScreen(),
    const SeekerMyworkitScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const Color navBarBgColor = Color(0xFF001437);
    const Color selectedTextColor = Color(0xFF43C7FF);
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true, 
      backgroundColor: const Color(0xFF001437),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          // 바텀바 자체의 가로 길이를 살짝 줄여서 더 콤팩트하게 만들 수도 있습니다.
          width: screenWidth * 0.94, 
          height: 65,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: navBarBgColor,
            borderRadius: BorderRadius.circular(35),
            border: Border.all(
              // ignore: deprecated_member_use
              color: Colors.white, 
              width: 0.5,
            ),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            // [수정] 아이템들을 중앙으로 밀착시킴
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavItem(0, 'home', 'Home', selectedTextColor),
              _buildNavItem(1, 'resume', 'Resume', selectedTextColor),
              _buildNavItem(2, 'financial', 'Financial', selectedTextColor),
              _buildNavItem(3, 'chats', 'Chats', selectedTextColor),
              _buildNavItem(4, 'myworkit', 'My Workit', selectedTextColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String iconBaseName, String label, Color selectedColor) {
    bool isSelected = _selectedIndex == index;
    final String assetPath = 'assets/icons/${iconBaseName}_${isSelected ? 'on' : 'off'}.svg';

    // [수정] Expanded를 제거하고 SizedBox로 너비를 고정하여 간격을 좁힘
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _selectedIndex = index),
      child: SizedBox(
        width: 64, // 이 값을 줄일수록 아이콘 사이가 더 촘촘해집니다 (추천: 60~68)
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 3),
            SvgPicture.asset(
              assetPath,
              width: 30, // 아이콘 크기를 살짝 줄여서 비율 최적화
              height: 30,
              fit: BoxFit.contain,
              placeholderBuilder: (context) => const Icon(Icons.error, color: Colors.red, size: 10),
            ),
            const SizedBox(height: 1.5), // 아이콘과 텍스트 사이 간격 밀착
            Text(
              label,
              style: TextStyle(
                // ignore: deprecated_member_use
                color: isSelected ? selectedColor : Colors.white.withOpacity(0.4),
                fontSize: 11, // 촘촘한 레이아웃을 위해 폰트 사이즈 미세 조정
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}