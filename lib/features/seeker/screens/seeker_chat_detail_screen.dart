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
  
  bool _isMenuOpen = false;
  final List<int> _selectedPhotoIndices = [];

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
      _isMenuOpen = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
    if (_isMenuOpen) {
      FocusScope.of(context).unfocus();
      _scrollToBottom();
    }
  }

  void _onPhotoTap(int index) {
    setState(() {
      if (_selectedPhotoIndices.contains(index)) {
        _selectedPhotoIndices.remove(index);
      } else {
        _selectedPhotoIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFF011637);
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
            child: Column(
              children: [
                _buildCustomAppBar(),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.only(bottom: _isMenuOpen ? 380 : 120),
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
          Positioned(bottom: 0, left: 0, right: 0, child: _buildAnimatedBottomArea()),
        ],
      ),
    );
  }

  Widget _buildAnimatedBottomArea() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      height: _isMenuOpen ? 420 : 110,
      decoration: const BoxDecoration(color: Color(0xFF011637)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _toggleMenu,
                  child: Image.asset('assets/images/add.png', width: 21, height: 21),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 44,
                    alignment: Alignment.center, // 텍스트 필드 정렬 보조
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: const Color(0xFF4E5B70)),
                    ),
                    child: TextField(
                      controller: _controller,
                      onTap: () => setState(() => _isMenuOpen = false),
                      style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'Pretendard'),
                      textAlignVertical: TextAlignVertical.center, // 수직 중앙 정렬
                      decoration: const InputDecoration(
                        hintText: "Write a message here",
                        hintStyle: TextStyle(color: Color(0xFFBCC1C3), fontSize: 14),
                        border: InputBorder.none,
                        isCollapsed: true, // 내부 패딩 제어를 위해 설정
                        contentPadding: EdgeInsets.symmetric(horizontal: 16), 
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _sendMessage, 
                  child: Image.asset('assets/images/send.png', width: 28, height: 28),
                ),
              ],
            ),
          ),
          if (_isMenuOpen)
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, mainAxisSpacing: 8, crossAxisSpacing: 8,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(color: const Color(0xFFBCC1C3), borderRadius: BorderRadius.circular(8)),
                        child: Center(child: Image.asset('assets/images/camera.png', width: 30, height: 30)),
                      ),
                    );
                  }
                  
                  bool isSelected = _selectedPhotoIndices.contains(index);
                  int selectionOrder = _selectedPhotoIndices.indexOf(index) + 1;

                  return GestureDetector(
                    onTap: () => _onPhotoTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected ? Border.all(color: const Color(0xFF43C7FF), width: 2) : null,
                        image: const DecorationImage(image: NetworkImage("https://via.placeholder.com/150"), fit: BoxFit.cover),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 5, right: 5,
                            child: Container(
                              width: 22, height: 22,
                              decoration: BoxDecoration(
                                // 선택 여부에 따른 배경색 변경
                                // ignore: deprecated_member_use
                                color: isSelected ? const Color(0xFF43C7FF) : Colors.black.withOpacity(0.2),
                                shape: BoxShape.circle,
                                // 선택되지 않았을 때만 회색 테두리 (레퍼런스 스타일)
                                border: Border.all(
                                  color: isSelected ? Colors.white : const Color(0xFFBCC1C3), 
                                  width: 1.5
                                ),
                              ),
                              child: isSelected 
                                ? Center(child: Text("$selectionOrder", style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)))
                                : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  // --- 기존 UI 유지 ---
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
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                Image.asset('assets/images/chats_arrow_left.png', width: 24, height: 24),
                const SizedBox(width: 8),
                const Text("12", style: TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(widget.name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SeekerChatCallScreen(name: widget.name))),
                child: Image.asset('assets/images/call.png', width: 24, height: 24),
              ),
              const SizedBox(width: 10),
              GestureDetector(onTap: _showMoreMenu, child: Image.asset('assets/images/more.png', width: 24, height: 24)),
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

  void _showMoreMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0xFF1A2C4D), borderRadius: BorderRadius.circular(24)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            _buildActionTile(title: "Report", icon: Icons.report_problem_outlined, onTap: () => Navigator.pop(context)),
            _buildActionTile(title: "Block", icon: Icons.block, isDestructive: true, onTap: () => Navigator.pop(context)),
            _buildActionTile(title: "Leave Chatroom", icon: Icons.exit_to_app, onTap: () { Navigator.pop(context); _showExitDialog(); }),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile({required String title, required IconData icon, bool isDestructive = false, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? Colors.redAccent : Colors.white70),
      title: Text(title, style: TextStyle(color: isDestructive ? Colors.redAccent : Colors.white)),
      onTap: onTap,
    );
  }

  void _showExitDialog() {
    showDialog(context: context, builder: (context) => AlertDialog(
      backgroundColor: const Color(0xFF1A2C4D),
      title: const Text("Leave?", style: TextStyle(color: Colors.white)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
        TextButton(onPressed: () { Navigator.pop(context); Navigator.pop(context); }, child: const Text("Leave", style: TextStyle(color: Colors.redAccent))),
      ],
    ));
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
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text("Calling...", style: TextStyle(color: Color(0xFF43C7FF), fontSize: 16)),
          const Spacer(flex: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCallBtn('assets/images/mute.png', "Mute"),
              _buildCallBtn('assets/images/video.png', "Video"),
              _buildCallBtn('assets/images/speaker.png', "Speaker"),
            ],
          ),
          const SizedBox(height: 80),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              // [수정] 종료 버튼도 다른 버튼들과 비율을 맞추기 위해 크기 조정
              padding: const EdgeInsets.all(24), 
              decoration: const BoxDecoration(
                color: Color(0xFFFF5252), // 레퍼런스의 레드 컬러
                shape: BoxShape.circle
              ),
              child: Image.asset(
                'assets/images/call_end.png', 
                width: 40, 
                height: 40,
                errorBuilder: (c, e, s) => const Icon(Icons.call_end, color: Colors.white, size: 40)
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildCallBtn(String assetPath, String label) => Column(
    children: [
      Container(
        // [수정] 패딩을 늘려 원의 크기를 레퍼런스처럼 크게 만듭니다.
        padding: const EdgeInsets.all(20), 
        decoration: const BoxDecoration(
          color: Color(0xFF354E6B), // 레퍼런스의 밝은 네이비 톤 반영
          shape: BoxShape.circle
        ),
        child: Image.asset(
          assetPath, 
          width: 36, 
          height: 36,
          errorBuilder: (c, e, s) => const Icon(Icons.error, color: Colors.white, size: 36),
        ),
      ),
      const SizedBox(height: 12), // 아이콘과 글자 사이 간격 약간 확대
      Text(
        label, 
        style: const TextStyle(
          color: Colors.white, 
          fontSize: 14, // 글자 크기 가독성 있게 조정
          fontFamily: 'Pretendard'
        )
      ),
    ],
  );
}