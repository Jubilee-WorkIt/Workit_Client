import 'package:flutter/material.dart';

class SeekerMyWorkitBookmarkedSearchScreen extends StatefulWidget {
  const SeekerMyWorkitBookmarkedSearchScreen({super.key});

  @override
  State<SeekerMyWorkitBookmarkedSearchScreen> createState() => _SeekerMyWorkitBookmarkedSearchScreenState();
}

class _SeekerMyWorkitBookmarkedSearchScreenState extends State<SeekerMyWorkitBookmarkedSearchScreen> {
  // 최근 검색 기록 리스트
  List<String> recentSearches = ["Bookmarked", "name", "name", "name"];
  final TextEditingController _searchController = TextEditingController();

  // 검색어 제출 시 리스트에 추가 로직
  void _onSearchSubmitted(String value) {
    if (value.trim().isEmpty) return;
    setState(() {
      // 중복 검색어 방지 (선택 사항): if (recentSearches.contains(value.trim())) recentSearches.remove(value.trim());
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
            // --- 상단 검색바 영역 ---
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
                            onSubmitted: _onSearchSubmitted, // 엔터 키 입력 시 검색
                            decoration: const InputDecoration(
                              hintText: "Search in bookmarked", // 힌트 텍스트 수정
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
            
            // --- 최근 검색어 헤더 영역 ---
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
                  onTap: () {
                    setState(() {
                      recentSearches.clear(); // 전체 삭제
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
            
            // --- 최근 검색어 칩(Chip) 영역 ---
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: recentSearches.asMap().entries.map((entry) {
                return _buildRecentSearchChip(entry.value, entry.key);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // 개별 검색어 칩 위젯
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
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(width: 9),
          GestureDetector(
            onTap: () {
              setState(() {
                recentSearches.removeAt(index); // 개별 삭제
              });
            },
            child: Image.asset('assets/images/close.png', width: 12, height: 12),
          ),
        ],
      ),
    );
  }
}