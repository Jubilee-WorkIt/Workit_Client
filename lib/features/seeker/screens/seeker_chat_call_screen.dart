// seeker_chat_call_screen.dart 파일 내용
import 'package:flutter/material.dart';
// import 'package:workit_app/features/seeker/screens/seeker_chat_call_screen.dart';

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
      Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(color: Color(0xFF1A2C4D), shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white),
      ),
      const SizedBox(height: 8),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12, fontFamily: 'Pretendard')),
    ],
  );
}