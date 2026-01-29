import 'package:flutter/material.dart';
import 'seeker_chat_search_screen.dart';
import 'seeker_chat_detail_screen.dart';

class SeekerChatListScreen extends StatefulWidget {
  const SeekerChatListScreen({super.key});

  @override
  State<SeekerChatListScreen> createState() => _SeekerChatListScreenState();
}

class _SeekerChatListScreenState extends State<SeekerChatListScreen> {
  // 현재 선택된 필터 상태 관리
  String selectedFilter = "All";
  final List<String> filters = ["All", "Unread", "In Progress", "Urgent", "Completed"];

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF011637);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopBar(context),
            const SizedBox(height: 24),

            // 필터 섹션
            _buildFilterSection(),
            const SizedBox(height: 24),

            // 채팅 리스트
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 15,
                itemBuilder: (context, index) => _buildChatTile(context, index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Chats",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SeekerChatSearchScreen()),
          ),
          icon: Image.asset('assets/images/chats_search.png', width: 22, height: 22),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }

Widget _buildFilterSection() {
  return SizedBox(
    // 칩과 이미지의 높이를 일치시키기 위해 높이 설정
    height: 30, 
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: filters.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            // 이미지 높이를 SizedBox와 맞춰 정렬
            child: Image.asset('assets/images/chats_setting.png', width: 30, height: 30),
          );
        }
        return _filterChip(filters[index - 1]);
      },
    ),
  );
}

Widget _filterChip(String label) {
  bool isSelected = selectedFilter == label;
  return GestureDetector(
    onTap: () => setState(() => selectedFilter = label),
    child: Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFA4E1F9) : const Color(0xFF001533),
        borderRadius: BorderRadius.circular(20),
        // [수정 포인트] 선택되지 않았을 때만 하얀색 테두리 추가
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.white,
          width: 0.5,
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.white,
          fontSize: 14,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}

  Widget _buildChatTile(BuildContext context, int index) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      onTap: () => Navigator.push(
        context, 
        MaterialPageRoute(builder: (_) => const SeekerChatDetailScreen(name: "Julee"))
      ),
      leading: const CircleAvatar(
        radius: 28, 
        backgroundColor: Colors.white,
      ),
      title: const Text(
        "Name",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          ),
      ),
      
      subtitle: const Text(
        "Conversation content",
        style: TextStyle(
          color:  Color(0xFFDBDFE0),
          fontSize: 12,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w400,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "9:41",
            style: TextStyle(
              color:  Color(0xFFDBDFE0),
              fontSize: 12,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w200,
              ),
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3), // 배지 크기 조정
            decoration: const BoxDecoration(
              color: Color(0xFF43C7FF),
              shape: BoxShape.circle,
            ),
            child: const Text(
              "1",
              style: TextStyle(
                color: Colors.black,
                fontSize: 8,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w600,
                ),
            ),
          ),
        ],
      ),
    );
  }
}