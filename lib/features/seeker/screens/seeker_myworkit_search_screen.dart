import 'package:flutter/material.dart';

class SeekerMyWorkitSearchScreen extends StatefulWidget {
  const SeekerMyWorkitSearchScreen({super.key});

  @override
  State<SeekerMyWorkitSearchScreen> createState() => _SeekerMyWorkitSearchScreenState();
}

class _SeekerMyWorkitSearchScreenState extends State<SeekerMyWorkitSearchScreen> {
  // 2번 수정: 검색 기록을 담을 리스트 (검색했던 내용들이 보임)
  List<String> recentSearches = ["Name", "Name", "Name", "Name"];
  final TextEditingController _searchController = TextEditingController();

  // 검색 추가 로직
  void _onSearchSubmitted(String value) {
    if (value.trim().isEmpty) return;
    setState(() {
      recentSearches.insert(0, value.trim()); // 최신 검색어를 맨 앞으로
      _searchController.clear(); // 입력창 비우기
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011637),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset('assets/images/chats_arrow_left.png', width: 24, height: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF011637),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF4E5B70)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                            // 2번 수정: 엔터를 누르면 검색 기록에 남게 함
                            onSubmitted: _onSearchSubmitted,
                            decoration: const InputDecoration(
                              hintText: "Enter your search term",
                              hintStyle: TextStyle(
                                color: Color(0xFFBCC1C3),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _onSearchSubmitted(_searchController.text),
                          child: Image.asset('assets/images/chats_search_small.png', width: 18, height: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recent",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  // 3번 수정: Delete all 누르면 리스트 비우기
                  onTap: () {
                    setState(() {
                      recentSearches.clear();
                    });
                  },
                  child: const Text(
                    "Delete All",
                    style: TextStyle(
                      color: Color(0xFFDEE3E3),
                      fontSize: 11,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              // 1~2번 수정: 실제 리스트 데이터를 칩으로 보여줌
              children: recentSearches.asMap().entries.map((entry) {
                return _buildRecentSearchChip(entry.value, entry.key);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearchChip(String label, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFCBEDFB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 9),
          GestureDetector(
            onTap: () {
              // 1번 수정: x 이미지 누르면 해당 검색어 삭제
              setState(() {
                recentSearches.removeAt(index);
              });
            },
            child: Image.asset('assets/images/close.png', width: 12, height: 12),
          ),
        ],
      ),
    );
  }
}