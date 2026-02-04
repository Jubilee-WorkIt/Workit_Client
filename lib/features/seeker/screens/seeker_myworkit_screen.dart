import 'package:flutter/material.dart';
import 'package:workit_app/features/seeker/screens/seeker_myworkit_bookmark_screen.dart';
import 'package:workit_app/features/seeker/screens/seeker_myworkit_recently_viewed_screen.dart';
import 'package:workit_app/features/seeker/screens/seeker_myworkit_application_status_screen.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 50),
        child: Column(
          children: [
            _buildCustomHeader(),
            const SizedBox(height: 16),
            _buildProfileCard(),
            const SizedBox(height: 20),
            _buildStatsSection(), // 여기서 아래 함수를 호출합니다.
            const SizedBox(height: 20),
            _buildMenuCard(),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "My Workit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Image.asset(
            'assets/images/settings.png',
            width: 22,
            height: 22,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }

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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
              ),
              const SizedBox(width: 15),
              const Text(
                "Name",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 98),
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

  // --- [수정된 섹션] 각 아이템에 onTap 콜백 연결 ---
  Widget _buildStatsSection() {
    return Row(
      children: [
        _buildStatItem('assets/images/bookmark.png', "0", "Bookmarked\n", () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SeekerMyWorkitBookmarkScreen()),
          );
        }),
        const SizedBox(width: 12),
        _buildStatItem('assets/images/recent.png', "0", "Recently\nviewed", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SeekerMyWorkitRecentlyViewedScreen()));
        }),
        const SizedBox(width: 12),
        _buildStatItem('assets/images/status.png', "0", "Application\nstatus", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SeekerMyWorkitApplicationStatusScreen()));
        }),
      ],
    );
  }

  // --- [수정된 아이템 위젯] GestureDetector 추가 및 onTap 파라미터 추가 ---
  Widget _buildStatItem(String imagePath, String count, String label, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap, // 터치 이벤트 연결
        behavior: HitTestBehavior.opaque, // 빈 공간 클릭도 인식
        child: Container(
          height: 105,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, width: 22, height: 22),
              const SizedBox(height: 4),
              Text(
                count,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
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
      ),
    );
  }

  Widget _buildMenuCard() {
    return Container(
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
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: Row(
          children: [
            Image.asset(imagePath, width: 22, height: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  height: 1.0,
                  letterSpacing: 0.1,
                ),
              ),
            ),
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