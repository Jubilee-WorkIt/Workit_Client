import 'package:flutter/material.dart';

class SeekerMyworkitScreen extends StatefulWidget {
  const SeekerMyworkitScreen({super.key});

  @override
  State<SeekerMyworkitScreen> createState() => _SeekerMyworkitScreenState();
}

class _SeekerMyworkitScreenState extends State<SeekerMyworkitScreen> {
  static const Color darkBgColor = Color(0xFF011637);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBgColor,
appBar: PreferredSize(
        // 1. 앱바의 전체 높이를 기본(56)보다 약간 낮은 48~50 정도로 설정하여 위로 올림
        preferredSize: const Size.fromHeight(36), 
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          titleSpacing: 20,
          // 2. 툴바 내부의 수직 여백을 최소화
          toolbarHeight: 50, 
          title: const Text(
            "My Workit",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
          actions: [
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: Image.asset(
                    'assets/images/settings.png',
                    width: 22,
                    height: 22,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildProfileCard(),
            const SizedBox(height: 20),
            _buildStatsSection(),
            const SizedBox(height: 20),
            _buildMenuCard(),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  // --- 이하 동일 (생략 가능하나 구조 유지를 위해 유지) ---

Widget _buildProfileCard() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Image.asset(
        'assets/images/profilecard.png',
        width: double.infinity,
        fit: BoxFit.contain,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Row(
          // 전체 Row는 왼쪽부터 정렬
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. 프로필 이미지
            const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
            ),
            const SizedBox(width: 15),

            // 2. 이름 (너비를 차지하는 Expanded를 제거해서 텍스트 크기만큼만 가집니다)
            const Text(
              "Name",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
              ),
            ),

            // 3. 이름 바로 옆 간격 (원하시는 만큼 조절하세요)
            const SizedBox(width: 98),

            // 4. 프로필 설정 버튼 (이름 바로 옆에 붙어서 생성됩니다)
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                minimumSize: const Size(0, 0),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Profile settings",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

  Widget _buildStatsSection() {
    return Row(
      children: [
        _buildStatItem('assets/images/bookmark.png', "0", "Bookmarked\n"),
        const SizedBox(width: 12),
        _buildStatItem('assets/images/recent.png', "0", "Recently\nviewed"),
        const SizedBox(width: 12),
        _buildStatItem('assets/images/status.png', "0", "Application\nstatus"),
      ],
    );
  }

Widget _buildStatItem(String imagePath, String count, String label) {
  return Expanded(
    child: Container(
      height: 105, // [수정] 모든 카드의 높이를 통일하여 균일하게 만듭니다.
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // [수정] 수직 중앙 정렬
        children: [
          Image.asset(imagePath, width: 22, height: 22),
          const SizedBox(height: 4),
          Text(
            count,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 10,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,),
          ),
          const SizedBox(height: 8),
          // [수정] 텍스트가 두 줄이 되어도 카드의 높이가 변하지 않습니다.
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
              height: 1.3,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildMenuCard() {
    return Container(
      // padding: const EdgeInsets.all(20),
      padding: const EdgeInsets.only(top: 18, left: 16, right: 16, bottom: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Contact us",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
              ),
          ),
          const SizedBox(height: 24),
          _buildMenuItem('assets/images/menu_new.png', "What's new?"),
          const SizedBox(height: 14),
          _buildMenuItem('assets/images/menu_faq.png', "FAQs"),
          const SizedBox(height: 14),
          _buildMenuItem('assets/images/menu_feedback.png', "Feedback"),
          const SizedBox(height: 14),
          _buildMenuItem('assets/images/menu_terms.png', "Terms and policies"),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String imagePath, String title) {
    return InkWell(
      onTap: () {},
      child: Padding(
        // [여백 조절 핵심] 위아래 패딩을 줄여서 메뉴 간격을 조절하세요.
        padding: const EdgeInsets.symmetric(vertical: 1), 
        child: Row(
          children: [
            // 1. 아이콘
            Image.asset(imagePath, width: 22, height: 22),
            const SizedBox(width: 12), // 아이콘과 글자 사이 간격
            
            // 2. 제목 (자간/행간 적용)
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  height: 1.0,        // 행간 최소화
                  letterSpacing: 0.1, // 자간 타이트하게
                ),
              ),
            ),
            
            // 3. 화살표
            Image.asset(
              'assets/images/menu_arrow_right.png',
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
