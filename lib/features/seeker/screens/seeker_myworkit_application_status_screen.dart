import 'package:flutter/material.dart';
import 'package:workit_app/features/seeker/screens/seeker_home_job_detail_screen.dart';

class SeekerMyWorkitApplicationStatusScreen extends StatefulWidget {
  const SeekerMyWorkitApplicationStatusScreen({super.key});

  @override
  State<SeekerMyWorkitApplicationStatusScreen> createState() => _SeekerMyWorkitApplicationStatusScreenState();
}

class _SeekerMyWorkitApplicationStatusScreenState extends State<SeekerMyWorkitApplicationStatusScreen> {
  static const Color _darkBgColor = Color(0xFF011637);
  
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  // 가상의 데이터 리스트 (상태 필드 추가)
  final List<Map<String, dynamic>> _applications = List.generate(
    5,
    (index) => {
      'company': 'Company name',
      'title': 'Posting title',
      'location': 'Location',
      'amount': 'Amount',
      'status': index == 0 ? 'Passed' : (index == 1 ? 'Failed' : 'Application submitted'),
    },
  );

  void _onSearchSubmitted(String value) {
    print("Search: $value");
  }

  // 상태별 텍스트 컬러 지정
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Passed':
        return const Color(0xFF43C7FF);
      case 'Failed':
        return const Color(0xFFFF4B4B);
      case 'Application submitted':
        return const Color(0xFF009DFF);
      default:
        return Colors.grey;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkBgColor,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildSearchBar(),
            const SizedBox(height: 15),
            _buildFilterSection(),
            const SizedBox(height: 15),
            _buildApplicationList(),
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
        "Application status",
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
    );
  }

  Widget _buildFilterSection() {
    final filters = ['All', 'Application submitted', 'Passed', 'Failed'];
    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((label) {
            bool isSelected = _selectedFilter == label;
            return Padding(
              padding: const EdgeInsets.only(right: 11.6),
              child: GestureDetector(
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
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildApplicationList() {
    // 선택된 필터에 따라 리스트 필터링
    final filteredList = _selectedFilter == 'All' 
      ? _applications 
      : _applications.where((item) => item['status'] == _selectedFilter).toList();

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 20),
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return _buildApplicationCard(filteredList[index]);
        },
      ),
    );
  }

  Widget _buildApplicationCard(Map<String, dynamic> item) {
    final String status = item['status'];
    final Color statusColor = _getStatusColor(status);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SeekerHomeJobDetailScreen()),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9ECEF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(item['title'],
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                )),
                          ),
                          // HOT/NEW 대신 지원 상태 태그 표시
                          _statusTag(status, statusColor),
                        ],
                      ),
                      Text(item['company'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.1,
                          )),
                      const SizedBox(height: 10),
                      _cardIconInfo('assets/images/pin.png', item['location']),
                      _cardIconInfo('assets/images/clock.png', item['amount']),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(4, (i) => _hashTag('#Category')),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _statusTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text == 'Application submitted' ? 'Applied' : text, // 텍스트가 길 경우 축약 표시
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: - 0.1),
      ),
    );
  }

  Widget _cardIconInfo(String assetPath, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: [
          Image.asset(assetPath, width: 12, height: 12, color:const Color(0xFF707676),),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(
            color:  Color(0xFF707676),
            fontSize: 12,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            letterSpacing: 0.1,
            )),
        ],
      ),
    );
  }

  Widget _hashTag(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF868E96), fontSize: 11),
      ),
    );
  }
}