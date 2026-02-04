import 'package:flutter/material.dart';
import 'package:workit_app/features/seeker/screens/seeker_home_job_detail_screen.dart';
import 'package:workit_app/features/seeker/screens/seeker_myworkit_bookmark_search_screen.dart';



class SeekerMyWorkitBookmarkScreen extends StatefulWidget {
  const SeekerMyWorkitBookmarkScreen({super.key});

  @override
  State<SeekerMyWorkitBookmarkScreen> createState() => _SeekerMyWorkitBookmarkScreenState();
}

class _SeekerMyWorkitBookmarkScreenState extends State<SeekerMyWorkitBookmarkScreen> {
  static const Color _darkBgColor = Color(0xFF011637);
  static const Color _activeBlue = Color(0xFF43C7FF);
  static const Color _inactiveBg = Color(0xFF132A4D);
  static const Color _disabledGrey = Color(0xFFBCC1C3);
  static const double _hPadding = 20.0;

  String _selectedFilter = 'All';
  bool _isSelectAll = false;

  final List<Map<String, dynamic>> _bookmarks = List.generate(
    5,
    (index) => {
      'company': 'Company name',
      'title': 'Posting title',
      'location': 'Location',
      'amount': 'Amount',
      'time': '8 hours ago',
      'isSelected': false,
    },
  );

  bool get _isAnySelected => _bookmarks.any((item) => item['isSelected'] == true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkBgColor,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _hPadding),
        child: Column(
          children: [
            const SizedBox(height: 15),
            _buildFilterSection(),
            const SizedBox(height: 15),
            _buildSelectAllSection(),
            const Divider(color: Colors.white24, height: 1, thickness: 0.5),
            _buildBookmarkList(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset('assets/images/chats_arrow_left.png', width: 24, height: 24),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: const Text(
        "Bookmarked",
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),
      ),
      actions: [
        IconButton(
          icon: Image.asset('assets/images/chats_search_small.png', width: 22, height: 22),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SeekerMyWorkitBookmarkedSearchScreen()),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    final filters = ['All', 'Currently being published', 'Deadline'];
    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((label) {
            return Row(
              children: [
                _buildFilterChip(label),
                const SizedBox(width: 8),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFA4E1F9) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.white, width: 0.5),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.black : Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildSelectAllSection() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: _toggleSelectAll,
            child: Row(
              children: [
                _buildCheckBox(_isSelectAll),
                const SizedBox(width: 12),
                const Text("Select all", style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: 'Pretendard')),
              ],
            ),
          ),
          _buildCommonButton(label: "Delete", isActive: _isAnySelected, onPressed: () {
            // TODO: Delete Logic
          }),
        ],
      ),
    );
  }

  Widget _buildBookmarkList() {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: _bookmarks.length,
        separatorBuilder: (context, index) => const Divider(color: Colors.white24, height: 1, thickness: 0.5),
        itemBuilder: (context, index) => _buildBookmarkItem(index),
      ),
    );
  }

  Widget _buildBookmarkItem(int index) {
    final item = _bookmarks[index];
    return Padding(
      // [수정] vertical 패딩을 줄여 전체적인 여백 최적화
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _toggleSingleItem(index),
            child: _buildCheckBox(item['isSelected']),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['company'],
                        style: const TextStyle(color: _disabledGrey, fontSize: 15, fontFamily: 'Pretendard')),
                    Text(item['time'],
                        style: const TextStyle(color: _disabledGrey, fontSize: 12, fontFamily: 'Pretendard')),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  item['title'],
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),
                ),
                // [수정] title과 footer 사이 여백을 줄임
                const SizedBox(height:1), 
                Row(
                  // [수정] spaceBetween 대신 start를 사용하여 요소들을 왼쪽부터 핏하게 배치
                  // 만약 양 끝으로 벌리고 싶다면 유지하되, 전체를 Padding으로 감싸 여백을 조절합니다.
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  crossAxisAlignment: CrossAxisAlignment.center, // 세로 중앙 정렬
                  children: [
                    // 왼쪽 정보 그룹 (핀 + 위치, 시계 + 금액)
                    Row(
                      mainAxisSize: MainAxisSize.min, // [핵심] 자식 크기만큼만 공간 차지
                      children: [
                        _buildIconInfo('assets/images/pin.png', item['location']),
                        const SizedBox(width: 10), // 정보 사이 간격 살짝 축소
                        _buildIconInfo('assets/images/clock.png', item['amount']),
                      ],
                    ),
                    
                    // 오른쪽 Apply 버튼
                    _buildCommonButton(
                      label: "Apply", 
                      isActive: true, 
                      isApplyType: true, 
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SeekerHomeJobDetailScreen()),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildCommonButton({
    required String label,
    required bool isActive,
    bool isApplyType = false,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      height: 24, // [수정] 세로 높이를 32에서 24로 줄임
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isApplyType ? Colors.transparent : (isActive ? _activeBlue : _inactiveBg),
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 11), // 가로 여백 유지
          minimumSize: Size.zero, // [추가] 설정한 height를 따르도록 최소 크기 해제
          tapTargetSize: MaterialTapTargetSize.shrinkWrap, // [추가] 불필요한 터치 타겟 여백 제거
          side: const BorderSide(color: _disabledGrey, width: 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(label, style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w400,
          letterSpacing: 0.1,
          )),
      ),
    );
  }

  Widget _buildCheckBox(bool checked) {
    return Image.asset(
      checked ? 'assets/images/checked_full.png' : 'assets/images/unchecked.png',
      width: 22, height: 22,
    );
  }

  Widget _buildIconInfo(String assetPath, String text) {
    return Row(
      children: [
        Image.asset(assetPath, width: 16, height: 16, color: _disabledGrey),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: _disabledGrey, fontSize: 12, fontFamily: 'Pretendard')),
      ],
    );
  }

  void _toggleSelectAll() {
    setState(() {
      _isSelectAll = !_isSelectAll;
      for (var item in _bookmarks) {
        item['isSelected'] = _isSelectAll;
      }
    });
  }

  void _toggleSingleItem(int index) {
    setState(() {
      _bookmarks[index]['isSelected'] = !_bookmarks[index]['isSelected'];
      _isSelectAll = _bookmarks.every((e) => e['isSelected']);
    });
  }
}