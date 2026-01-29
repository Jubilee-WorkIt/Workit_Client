import 'package:flutter/material.dart';

class SeekerHomeRingScreen extends StatefulWidget {
  const SeekerHomeRingScreen({super.key});

  @override
  State<SeekerHomeRingScreen> createState() => _SeekerHomeRingScreenState();

  // 1. static 메서드로 정의하여 외부(DetailScreen)에서도 클래스명을 통해 접근 가능하게 수정
  static Widget buildNotificationItem({
    required bool isRead,
    required Color backgroundColor,
    required Color textColor,
    required Color subTextColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        // 알림 구분 라인
        border: Border(
          bottom: BorderSide(
            color: isRead ? const Color(0xFF1A2C4D) : const Color(0xFFB8D9F2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Image.asset(
              isRead ? 'assets/images/read.png' : 'assets/images/unread.png',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Today's Recommended Part-Time Jobs",
                      style: TextStyle(color: subTextColor, fontSize: 12, fontFamily: 'Pretendard'),
                    ),
                    const Spacer(), // 시간 텍스트 우측 정렬
                    Text(
                      "5 hours ago",
                      style: TextStyle(color: subTextColor, fontSize: 10, fontFamily: 'Pretendard'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Melbourne Woolworths Cashier",
                  style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.w700, fontFamily: 'Pretendard'),
                ),
                const SizedBox(height: 4),
                Text(
                  "Click to see more about part-time jobs",
                  style: TextStyle(color: subTextColor, fontSize: 13, fontFamily: 'Pretendard'),
                ),
                const SizedBox(height: 8),
                Text(
                  "+ 13 See more notifications",
                  style: TextStyle(
                    color: subTextColor,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    fontFamily: 'Pretendard',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SeekerHomeRingScreenState extends State<SeekerHomeRingScreen> {
  @override
  Widget build(BuildContext context) {
    const Color darkBgColor = Color(0xFF011637);
    const Color cardBgColor = Color(0xFFD9EFFF);

    return Scaffold(
      backgroundColor: darkBgColor,
      appBar: AppBar(
        backgroundColor: darkBgColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/chats_arrow_left.png', width: 24, height: 24),
          ),
        ),
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader("New notifications", "View all", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationDetailScreen(isNew: true)));
            }),
            // static 메서드 호출
            SeekerHomeRingScreen.buildNotificationItem(
              isRead: false,
              backgroundColor: cardBgColor,
              textColor: Colors.black,
              subTextColor: const Color(0xFF666666),
            ),
            SeekerHomeRingScreen.buildNotificationItem(
              isRead: false,
              backgroundColor: cardBgColor,
              textColor: Colors.black,
              subTextColor: const Color(0xFF666666),
            ),
            const SizedBox(height: 32),
            _buildSectionHeader("Read notifications", "View all", () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationDetailScreen(isNew: false)));
            }),
            SeekerHomeRingScreen.buildNotificationItem(
              isRead: true,
              backgroundColor: darkBgColor,
              textColor: Colors.white,
              subTextColor: const Color(0xFFBCC1C3),
            ),
            SeekerHomeRingScreen.buildNotificationItem(
              isRead: true,
              backgroundColor: darkBgColor,
              textColor: Colors.white,
              subTextColor: const Color(0xFFBCC1C3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Pretendard')),
          GestureDetector(
            onTap: onTap,
            child: Text(actionText, style: const TextStyle(color: Color(0xFFADB5BD), fontSize: 12, fontFamily: 'Pretendard')),
          ),
        ],
      ),
    );
  }
}

// 전체보기 상세 화면
class NotificationDetailScreen extends StatelessWidget {
  final bool isNew;
  const NotificationDetailScreen({super.key, required this.isNew});

  @override
  Widget build(BuildContext context) {
    const Color darkBgColor = Color(0xFF011637);
    const Color cardBgColor = Color(0xFFD9EFFF);

    return Scaffold(
      backgroundColor: darkBgColor,
      appBar: AppBar(
        backgroundColor: darkBgColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/chats_arrow_left.png', width: 24, height: 24),
          ),
        ),
        title: Text(
          isNew ? "New notifications" : "Read notifications",
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          // SeekerHomeRingScreen의 static 메서드를 호출하여 오류 해결
          return SeekerHomeRingScreen.buildNotificationItem(
            isRead: !isNew,
            backgroundColor: isNew ? cardBgColor : darkBgColor,
            textColor: isNew ? Colors.black : Colors.white,
            subTextColor: isNew ? const Color(0xFF666666) : const Color(0xFFBCC1C3),
          );
        },
      ),
    );
  }
}