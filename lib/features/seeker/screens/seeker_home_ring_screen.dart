import 'package:flutter/material.dart';

class SeekerHomeRingScreen extends StatefulWidget {
  const SeekerHomeRingScreen({super.key});

  @override
  State<SeekerHomeRingScreen> createState() => _SeekerHomeRingScreenState();

  // 1. 공용 알림 아이템 UI (static)
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
          Image.asset(
            isRead ? 'assets/images/read.png' : 'assets/images/unread.png',
            width: 24,
            height: 24,
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
                    const Spacer(),
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

// --- 전체보기 상세 화면 (StatefulWidget으로 수정됨) ---
class NotificationDetailScreen extends StatefulWidget {
  final bool isNew;
  const NotificationDetailScreen({super.key, required this.isNew});

  @override
  State<NotificationDetailScreen> createState() => _NotificationDetailScreenState();
}

class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
  // 2. 개별 아이템의 읽음 상태를 관리하는 리스트
  late List<bool> readStatusList;

  @override
  void initState() {
    super.initState();
    // 시작 시: 새 알림(isNew=true)이면 전부 false(안읽음), 읽은 알림이면 전부 true(읽음)
    readStatusList = List.generate(15, (index) => !widget.isNew);
  }

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
          widget.isNew ? "New notifications" : "Read notifications",
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: readStatusList.length,
        itemBuilder: (context, index) {
          bool isCurrentRead = readStatusList[index];

          return GestureDetector(
            // 3. 클릭 시 읽음 처리 로직 추가
            onTap: () {
              if (!isCurrentRead) {
                setState(() {
                  readStatusList[index] = true;
                });
              }
            },
            child: SeekerHomeRingScreen.buildNotificationItem(
              isRead: isCurrentRead,
              // [중요] 상태에 따라 배경색과 텍스트 색상이 오토로 변경됩니다.
              backgroundColor: isCurrentRead ? darkBgColor : cardBgColor,
              textColor: isCurrentRead ? Colors.white : Colors.black,
              subTextColor: isCurrentRead ? const Color(0xFFBCC1C3) : const Color(0xFF666666),
            ),
          );
        },
      ),
    );
  }
}