import 'package:flutter/material.dart';

class SeekerHomeSearchScreen extends StatefulWidget {
  const SeekerHomeSearchScreen({super.key});

  @override
  State<SeekerHomeSearchScreen> createState() => _SeekerHomeSearchScreenState();
}

class _SeekerHomeSearchScreenState extends State<SeekerHomeSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  List<String> recentSearches = ["Search terms", "Search terms", "Search terms"];
  List<String> recommendedSearches = [
    "Search terms", "Search terms", "Search terms", "Search terms", 
    "Search terms", "Search terms", "Search terms", "Search terms"
  ];

  bool _isCollapsed = true;

  void _onSearchSubmitted(String value) {
    if (value.trim().isEmpty) return;
    setState(() {
      recentSearches.insert(0, value.trim());
      _searchController.clear();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 접혀있을 때는 처음 6개만 표시
    final displayRecommended = _isCollapsed 
        ? recommendedSearches.take(6).toList() 
        : recommendedSearches;

    return Scaffold(
      backgroundColor: const Color(0xFF011637),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 70),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 상단 검색 바 ---
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset('assets/images/chats_arrow_left.png', width: 24, height: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF011637),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: const Color(0xFF4E5B70)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                              onSubmitted: _onSearchSubmitted,
                              decoration: const InputDecoration(
                                hintText: "Enter your search term",
                                hintStyle: TextStyle(color: Color(0xFFBCC1C3), fontSize: 14),
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

              // --- 최근 검색어 섹션 ---
              _buildSectionHeader("Recent search terms", true),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 12,
                children: recentSearches.asMap().entries.map((entry) {
                  return _buildChip(entry.value, true, () {
                    setState(() => recentSearches.removeAt(entry.key));
                  });
                }).toList(),
              ),

              const SizedBox(height: 48),

              // --- 추천 검색어 섹션 ---
              _buildSectionHeader("Recommended search terms", false),
              const SizedBox(height: 16),
              Wrap(
                spacing: 7,
                runSpacing: 12,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ...displayRecommended.asMap().entries.map((entry) {
                    return _buildChip(entry.value, true, () {
                      setState(() => recommendedSearches.removeAt(entry.key));
                    });
                  }).toList(),
                  
                  // --- 수정사항: 화살표를 이미지로 교체 ---
                  GestureDetector(
                    onTap: () => setState(() => _isCollapsed = !_isCollapsed),
                    child: Image.asset(
                      _isCollapsed 
                        ? 'assets/images/arrow_down_circle.png' // 접혀있을 때 (더보기)
                        : 'assets/images/arrow_up_circle.png',   // 펼쳐져있을 때 (접기)
                      width: 24, 
                      height: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool showDeleteAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
        if (showDeleteAll)
          GestureDetector(
            onTap: () => setState(() => recentSearches.clear()),
            child: const Text("Delete all", style: TextStyle(color: Color(0xFFADB5BD), fontSize: 12, decoration: TextDecoration.underline)),
          ),
      ],
    );
  }

  Widget _buildChip(String label, bool showClose, VoidCallback onDelete) {
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
              fontWeight: FontWeight.w400
            )
          ),
          if (showClose) ...[
            const SizedBox(width: 8),
            GestureDetector(
              onTap: onDelete,
              child: Image.asset('assets/images/close.png', width: 12, height: 12),
            ),
          ]
        ],
      ),
    );
  }
}