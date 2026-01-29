import 'package:flutter/material.dart';
import 'package:workit_app/features/seeker/screens/seeker_home_ring_screen.dart';
// import 'seeker_home_ring_screen.dart';

class SeekerHomeRingDetailScreen extends StatelessWidget {
  final bool isNew; 
  const SeekerHomeRingDetailScreen({super.key, required this.isNew});

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
          isNew ? "New Notifications" : "Read Notifications",
          style: const TextStyle(
            color: Colors.white, 
            fontSize: 18, 
            fontWeight: FontWeight.w600,
            fontFamily: 'Pretendard'
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 15, // 전체보기 리스트 개수
        itemBuilder: (context, index) {
          // 호출부: SeekerHomeRingScreen에 정의한 공용 메서드 사용
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