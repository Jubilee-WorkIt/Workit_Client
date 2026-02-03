import 'package:flutter/material.dart';
import 'package:workit_app/features/seeker/screens/seeker_home_ring_screen.dart';

class SeekerHomeRingDetailScreen extends StatefulWidget {
  final bool isNew; 
  const SeekerHomeRingDetailScreen({super.key, required this.isNew});

  @override
  State<SeekerHomeRingDetailScreen> createState() => _SeekerHomeRingDetailScreenState();
}

class _SeekerHomeRingDetailScreenState extends State<SeekerHomeRingDetailScreen> {
  // 1. 각 알림 아이템의 읽음 상태를 개별적으로 관리할 리스트
  late List<bool> readStatusList;

  @override
  void initState() {
    super.initState();
    // 초기화: 새 알림 페이지면 모두 false(안읽음), 읽은 알림 페이지면 모두 true(읽음)
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
          widget.isNew ? "New Notifications" : "Read Notifications",
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
        itemCount: readStatusList.length,
        itemBuilder: (context, index) {
          // 현재 아이템의 읽음 상태 확인
          bool isCurrentRead = readStatusList[index];

          return GestureDetector(
            // 2. 클릭 시 읽음 처리 로직
            onTap: () {
              if (!isCurrentRead) {
                setState(() {
                  readStatusList[index] = true;
                });
                // TODO: 여기에 서버 읽음 처리 API를 연결하세요.
              }
            },
            child: SeekerHomeRingScreen.buildNotificationItem(
              // 3. 상태(isCurrentRead)에 따라 UI가 동적으로 변경됨
              isRead: isCurrentRead,
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