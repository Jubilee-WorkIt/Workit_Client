import 'package:flutter/material.dart';
import 'package:workit_app/features/seeker/screens/seeker_home_job_detail_screen.dart';
import 'package:workit_app/features/seeker/screens/seeker_home_search_screen.dart';
import 'package:workit_app/features/seeker/screens/seeker_home_ring_screen.dart';

class SeekerHomeScreen extends StatefulWidget {
  const SeekerHomeScreen({super.key});

  @override
  State<SeekerHomeScreen> createState() => _SeekerHomeScreenState();
}

class _SeekerHomeScreenState extends State<SeekerHomeScreen> {
  String selectedFilter = 'All';

  // 페이지 상태 관리를 위한 변수
  int _popularPageIndex = 1;
  int _latestPageIndex = 1;
  final int _totalPages = 20;

  @override
  Widget build(BuildContext context) {
    const Color darkBgColor = Color(0xFF001533);

    return Scaffold(
      backgroundColor: darkBgColor,
      appBar: AppBar(
        backgroundColor: darkBgColor,
        elevation: 0,
        centerTitle: false,
        title: Image.asset('assets/images/logo.png', width: 121, height: 22),
        actions: [
          // 1. 돋보기(검색) 클릭 시 이동
          _appBarIcon('assets/images/search.png', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SeekerHomeSearchScreen()));
          }),
          // 2. 종(알림) 클릭 시 이동
          _appBarIcon('assets/images/ring.png', () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SeekerHomeRingScreen()));
          }),
          // 3. more(메뉴) 클릭 시 이동
          _appBarIcon('assets/images/menu.png', () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const SeekeMenuScreen()));
          }),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 150),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _locationHeader(),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _buildBanner(),
              ),
              const SizedBox(height: 20),
              _buildFilterSection(),
              const SizedBox(height: 48),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _sectionHeader('Popular job postings right now', '$_popularPageIndex / $_totalPages'),
              ),
              const SizedBox(height: 24),
              _buildTripleCardPageView(
                context: context,
                onPageChanged: (index) => setState(() => _popularPageIndex = index + 1),
              ),

              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _sectionHeader("Today's Latest Job Postings", '$_latestPageIndex / $_totalPages'),
              ),
              const SizedBox(height: 24),
              _buildTripleCardPageView(
                context: context,
                onPageChanged: (index) => setState(() => _latestPageIndex = index + 1),
                isHotDefault: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- 수정된 부분: 클릭 가능하도록 제스처 추가 ---
  Widget _appBarIcon(String path, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque, // 터치 영역 최적화
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5), // 간격을 조금 넓혔습니다.
        child: Image.asset(path, width: 22, height: 22),
      ),
    );
  }

  // --- 기존 위젯 로직들 ---
  Widget _buildTripleCardPageView({required BuildContext context, required Function(int) onPageChanged, bool isHotDefault = true}) {
    return SizedBox(
      height: 520,
      child: PageView.builder(
        onPageChanged: onPageChanged,
        itemCount: _totalPages,
        controller: PageController(viewportFraction: 0.95),
        itemBuilder: (context, pageIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                _jobCard(isHot: isHotDefault, context: context),
                const SizedBox(height: 13),
                _jobCard(isHot: isHotDefault, context: context),
                const SizedBox(height: 13),
                _jobCard(isHot: isHotDefault, context: context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _jobCard({required bool isHot, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SeekerHomeJobDetailScreen()),
        );
      },
      child: Container(
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
                  width: 86, height: 86, 
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9ECEF), 
                    borderRadius: BorderRadius.circular(8)
                  )
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Posting title', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                          _statusTag(isHot ? 'HOT' : 'NEW', isHot ? const Color(0xFF43C7FF) : const Color(0xFF009DFF)),
                        ],
                      ),
                      const Text('Company name', style: TextStyle(fontSize: 13, color: Colors.black)),
                      const SizedBox(height: 10),
                      _cardIconInfo('assets/images/pin.png', 'Location'),
                      _cardIconInfo('assets/images/clock.png', 'Amount'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: List.generate(4, (i) => _hashTag('#Category'))),
            )
          ],
        ),
      ),
    );
  }

  Widget _locationHeader() {
    return Row(
      children: [
        Image.asset('assets/images/location.png', width: 18, height: 18),
        const SizedBox(width: 4),
        const Text('Location', style: TextStyle(color: Colors.white, fontSize: 16)),
        const Icon(Icons.arrow_drop_down, color: Colors.white),
      ],
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Widget _buildFilterSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: ['All', 'By Location', 'Long-term', 'Short-term', 'Immediate']
            .map((label) => _filterChip(label))
            .toList(),
      ),
    );
  }

  Widget _filterChip(String label) {
    bool isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
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

  Widget _cardIconInfo(String path, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(children: [
        Image.asset(path, width: 14, height: 14, color: const Color(0xFFADB5BD)),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 12, color: Color(0xFF707676)))
      ]),
    );
  }

  Widget _sectionHeader(String title, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text.rich(TextSpan(children: [
          TextSpan(text: count.split(' / ')[0], style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
          TextSpan(text: ' / ${count.split(' / ')[1]}', style: const TextStyle(color: Color(0xFFBCC1C3), fontSize: 12)),
        ])),
      ],
    );
  }

  Widget _statusTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _hashTag(String text) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFFE9ECED), borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: const TextStyle(color: Color(0xFF929696), fontSize: 10)),
    );
  }
}

// --- 임시 이동 페이지들 ---

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF001533),
    appBar: AppBar(title: const Text("Search"), backgroundColor: Colors.transparent),
    body: const Center(child: Text("Search Screen", style: TextStyle(color: Colors.white))),
  );
}

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF001533),
    appBar: AppBar(title: const Text("Notifications"), backgroundColor: Colors.transparent),
    body: const Center(child: Text("Notification Screen", style: TextStyle(color: Colors.white))),
  );
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF001533),
    appBar: AppBar(title: const Text("Menu"), backgroundColor: Colors.transparent),
    body: const Center(child: Text("Menu Screen", style: TextStyle(color: Colors.white))),
  );
}