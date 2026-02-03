import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({required this.text, required this.isMe, required this.timestamp});

  String get time => DateFormat('h:mm a').format(timestamp);
  String get dateKey => DateFormat('yyyy-MM-dd').format(timestamp);
}

class SeekerChatDetailScreen extends StatefulWidget {
  final String name;
  const SeekerChatDetailScreen({super.key, required this.name});

  @override
  State<SeekerChatDetailScreen> createState() => _SeekerChatDetailScreenState();
}

class _SeekerChatDetailScreenState extends State<SeekerChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<ChatMessage> _messages = [
    ChatMessage(text: "Hello, Annie! I'm Julee.", isMe: false, timestamp: DateTime(2026, 1, 26, 14, 4)),
    ChatMessage(text: "Nice to meet you.", isMe: false, timestamp: DateTime(2026, 1, 26, 14, 5)),
    ChatMessage(text: "Oh, Hi.", isMe: true, timestamp: DateTime(2026, 1, 27, 10, 18)),
    ChatMessage(text: "Nice to meet you too.", isMe: true, timestamp: DateTime(2026, 1, 27, 10, 20)),
  ];

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add(ChatMessage(text: _controller.text, isMe: true, timestamp: DateTime.now()));
      _controller.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  // 1. [+] 버튼 클릭 시 하단 메뉴
  void _showAddMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A2C4D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuIcon(Icons.camera_alt, "Camera"),
                  _buildMenuIcon(Icons.photo, "Gallery"),
                  _buildMenuIcon(Icons.folder, "File"),
                  _buildMenuIcon(Icons.location_on, "Location"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60, height: 60,
          decoration: const BoxDecoration(color: Color(0xFF354E6B), shape: BoxShape.circle),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Pretendard')),
      ],
    );
  }

// 2. [more] 버튼 클릭 시 메뉴 (신고, 차단, 나가기)
  void _showMoreMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // 배경 투명 (커스텀 디자인을 위해)
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A2C4D), // 기존 다크 네이비
          borderRadius: BorderRadius.circular(24),
          // ignore: deprecated_member_use
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1), // 부드러운 스트로크
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              // 상단 핸들러 바
              Container(
                width: 40, height: 4,
                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(height: 8),
              
              _buildActionTile(
                title: "Report", 
                icon: Icons.report_problem_outlined,
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User has been reported.")),
                  );
                }
              ),
              _buildActionDivider(),
              _buildActionTile(
                title: "Block", 
                icon: Icons.block,
                isDestructive: true,
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User has been blocked.")),
                  );
                }
              ),
              _buildActionDivider(),
              _buildActionTile(
                title: "Leave Chatroom", 
                icon: Icons.exit_to_app,
                onTap: () {
                  Navigator.pop(context); // 시트 닫기
                  _showExitDialog(); // 다이얼로그 띄우기
                }
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  // 메뉴 사이 구분선
  Widget _buildActionDivider() {
    // ignore: deprecated_member_use
    return Divider(color: Colors.white.withOpacity(0.05), height: 1, indent: 20, endIndent: 20);
  }

  // 개선된 메뉴 타일 디자인
  Widget _buildActionTile({
    required String title, 
    required IconData icon, 
    bool isDestructive = false, 
    VoidCallback? onTap
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? Colors.redAccent : Colors.white70, size: 22),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: isDestructive ? Colors.redAccent : Colors.white,
                fontSize: 16,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            // ignore: deprecated_member_use
            Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.2), size: 20),
          ],
        ),
      ),
    );
  }

  // 나가기 확인 다이얼로그 (실제 나가기 기능 포함)
  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1A2C4D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          // ignore: deprecated_member_use
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              child: Column(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 40),
                  SizedBox(height: 16),
                  Text(
                    "Leave Chatroom?",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Are you sure you want to leave?\nYour chat history will be deleted.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF9DA8B7), fontSize: 14, height: 1.5),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white10, height: 1),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  ),
                ),
                Container(width: 1, height: 50, color: Colors.white10),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context); // 다이얼로그 닫기
                      Navigator.pop(context); // 현재 채팅 상세 화면(SeekerChatDetailScreen) 닫기 -> 목록으로 이동
                    },
                    child: const Text("Leave", style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF011637);
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
        child: Column(
          children: [
            _buildCustomAppBar(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: 150),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  bool showDateDivider = index == 0 || (_messages[index - 1].dateKey != message.dateKey);
                  double bottomPadding = (index < _messages.length - 1 && _messages[index].isMe == _messages[index + 1].isMe) ? 8 : 22;

                  return Column(
                    children: [
                      if (showDateDivider) _buildDateDivider(message.timestamp),
                      Padding(padding: EdgeInsets.only(bottom: bottomPadding), child: _buildBubble(message)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(color: backgroundColor, child: SafeArea(child: _buildInputArea())),
    );
  }

  Widget _buildDateDivider(DateTime dateTime) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          const Expanded(child: Divider(color: Colors.white10, thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(DateFormat('MMMM d, yyyy').format(dateTime), style: const TextStyle(color: Color(0xFF9DA8B7), fontSize: 12)),
          ),
          const Expanded(child: Divider(color: Colors.white10, thickness: 1)),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Row(
      children: [
        // 1. 왼쪽 영역 (뒤로가기 + 숫자)
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬
              children: [
                Image.asset('assets/images/chats_arrow_left.png', 
                  width: 24, height: 24, 
                  errorBuilder: (c, e, s) => const Icon(Icons.arrow_back, color: Colors.white)),
                const SizedBox(width: 8),
                const Text("12", style: TextStyle(
                  color: Colors.white, 
                  fontSize: 14, 
                  fontFamily: 'Pretendard'
                )),
              ],
            ),
          ),
        ),

        // 2. 중앙 영역 (이름)
        Expanded(
          flex: 2, // 이름을 위해 더 넓은 공간 할당
          child: Text(
            widget.name,
            textAlign: TextAlign.center, // 텍스트 중앙 정렬
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // 3. 오른쪽 영역 (전화 + 더보기)
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // 오른쪽 정렬
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SeekerChatCallScreen(name: widget.name))),
                child: Image.asset('assets/images/call.png', 
                  width: 24, height: 24, 
                  errorBuilder: (c, e, s) => const Icon(Icons.call, color: Colors.white)),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: _showMoreMenu,
                child: Image.asset('assets/images/more.png', 
                  width: 24, height: 24, 
                  errorBuilder: (c, e, s) => const Icon(Icons.more_vert, color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBubble(ChatMessage message) {
    return Row(
      mainAxisAlignment: message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!message.isMe) ...[
          const CircleAvatar(radius: 18, backgroundColor: Colors.white),
          const SizedBox(width: 8)
        ],
        if (message.isMe) Text(message.time, style: const TextStyle(color: Color(0xFF9DA8B7), fontSize: 10)),
        const SizedBox(width: 4),
        Container(
          constraints: const BoxConstraints(maxWidth: 240),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: message.isMe ? const Color(0xFFCBEDFB) : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(message.text, style: const TextStyle(color: Colors.black, fontSize: 14, height: 1.4)),
        ),
        const SizedBox(width: 4),
        if (!message.isMe) Text(message.time, style: const TextStyle(color: Color(0xFF9DA8B7), fontSize: 10)),
      ],
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 60),
      child: Row(
        children: [
          GestureDetector(
            onTap: _showAddMenu,
            child: Image.asset('assets/images/add.png', width: 28, height: 28, 
              errorBuilder: (c, e, s) => const Icon(Icons.add_circle, color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: const Color(0xFF4E5B70)),
              ),
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Pretendard'),
                // [수정 포인트 1] 텍스트를 수직 중앙 정렬합니다.
                textAlignVertical: TextAlignVertical.center, 
                decoration: const InputDecoration(
                  hintText: "Write a message here",
                  hintStyle: TextStyle(
                    color:  Color(0xFFBCC1C3),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.only(left: 16, right: 16, bottom: -11), 
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _sendMessage, 
            child: Image.asset('assets/images/send.png', width: 28, height: 28, 
              errorBuilder: (c, e, s) => const Icon(Icons.send, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class SeekerChatCallScreen extends StatelessWidget {
  final String name;
  const SeekerChatCallScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011637),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          const CircleAvatar(radius: 60, backgroundColor: Colors.white),
          const SizedBox(height: 24),
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Pretendard')),
          const SizedBox(height: 8),
          const Text("Calling...", style: TextStyle(color: Color(0xFF43C7FF), fontSize: 16, fontFamily: 'Pretendard')),
          const Spacer(flex: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCallBtn(Icons.mic_off, "Mute"),
              _buildCallBtn(Icons.videocam, "Video"),
              _buildCallBtn(Icons.volume_up, "Speaker"),
            ],
          ),
          const SizedBox(height: 60),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
              child: const Icon(Icons.call_end, color: Colors.white, size: 32),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildCallBtn(IconData icon, String label) => Column(
    children: [
      Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Color(0xFF1A2C4D), shape: BoxShape.circle), child: Icon(icon, color: Colors.white)),
      const SizedBox(height: 8),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12, fontFamily: 'Pretendard')),
    ],
  );
}