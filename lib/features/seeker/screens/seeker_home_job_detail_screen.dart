import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_map/flutter_map.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

class SeekerHomeJobDetailScreen extends StatefulWidget {
  const SeekerHomeJobDetailScreen({super.key});

  @override
  State<SeekerHomeJobDetailScreen> createState() => _SeekerHomeJobDetailScreenState();
}

class _SeekerHomeJobDetailScreenState extends State<SeekerHomeJobDetailScreen> {
  bool isFavorite = false;

  final String uploadDateTime = '2026.01.01 12:00';
  final String locationAddress = 'Preston 77 St Georges Rd, Preston VIC 3072, Australia';
  final List<String> categories = ['#Category', '#Category', '#Category', '#Category'];
  static const LatLng locationLatLng = LatLng(-37.7412, 145.0053);

  @override
  Widget build(BuildContext context) {
    const Color darkBgColor = Color(0xFF001533);
    const Color pointBlue = Color(0xFFA4E1F9); 
    const Color subTextGrey = Color(0xFFDEE3E3);

    return Scaffold(
      backgroundColor: darkBgColor,
      // --- 요청하신 AppBar 스타일 적용 ---
      appBar: AppBar(
        backgroundColor: darkBgColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/chats_arrow_left.png', width: 24, height: 24),
          ),
        ),
        title: const Text(
          "Job Posting", // 타이틀 수정 (Region Settings -> Job Posting)
          style: TextStyle(
            color: Colors.white, 
            fontSize: 18, 
            fontWeight: FontWeight.w600, 
            fontFamily: 'Pretendard',
            letterSpacing: -0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          // 하트 버튼을 AppBar 우측에 배치
          IconButton(
            onPressed: () => setState(() => isFavorite = !isFavorite),
            icon: isFavorite
                ? Image.asset('assets/images/heart_select.png', width: 22, height: 22)
                : Image.asset('assets/images/heart.png', width: 22, height: 22),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 22, bottom: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _statusTag('NEW', const Color(0xFF00A3FF)),
                            Text(uploadDateTime, style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.2, // 자간 조정
                            )),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Posting title',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Container(
                              width: 60, height: 60,
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 16),
                            const Text(
                              'Company name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: categories.map((tag) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: _hashTag(tag),
                            )).toList(),
                          ),
                        ),
                        const SizedBox(height: 27),
                        const Divider(color: Color(0xFFE4E4E4), thickness: 1),
                        const SizedBox(height: 20),
                        _sectionTitle('Detailed Information'),
                        const Text(
                          'Lorem ipsum dolor sit amet consectetur. Diam a vitae dolor \nsollicitudin. Viverra dui neque vitae cras nec congue \nfaucibus. Id tellus cursus adipiscing nam maecenas.',
                          style: TextStyle(
                            color: Color(0xFFDEE3E3),
                            fontSize: 13,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 1.5, // 행간 확보
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 32),
                        _sectionTitle('Qualifications'),
                        ...List.generate(4, (index) => _bulletPoint('Lorem ipsum dolor sit amet consectetur.', subTextGrey)),
                        const SizedBox(height: 32),
                        _sectionTitle('Location'),
                        Text(locationAddress, style: const TextStyle(
                          color: Color(0xFFDEE3E3),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.3,
                        )),
                        const SizedBox(height: 16),
                        
                        Container(
                          width: double.infinity,
                          height: 172,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: FlutterMap(
                              options: const MapOptions(
                                initialCenter: locationLatLng,
                                initialZoom: 15,
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                  userAgentPackageName: 'com.example.workit_app',
                                ),
                                const MarkerLayer(
                                  markers: [
                                    Marker(
                                      point: locationLatLng,
                                      width: 40, height: 40,
                                      child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildApplyButton(pointBlue, darkBgColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 기존 Helper Widgets ---

  Widget _buildApplyButton(Color btnColor, Color bgColor) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [bgColor.withOpacity(0), bgColor.withOpacity(0.9), bgColor],
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: btnColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 0,
            ),
            child: const Text('Apply', style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            )),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title, style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      )),
    );
  }

Widget _bulletPoint(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6), // 항목 간 간격
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // 상단 정렬 유지
        children: [
          // 점(Bullet) 부분: 컨테이너로 감싸서 텍스트의 첫 줄 높이에 맞춤
          Container(
            margin: const EdgeInsets.only(top: 8), // 텍스트 첫 줄 중앙에 오도록 미세 조정
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          // 텍스트 부분
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                height: 1.4, // 행간을 주어 가독성 확보 (점과의 정렬 기준이 됨)
                letterSpacing: -0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: const TextStyle(
        color: Colors.white, 
        fontSize: 11, 
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      )),
    );
  }

  Widget _hashTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: ShapeDecoration(
        color: const Color(0xFF011637),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0xFFFFFFFF)),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Text(text, style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontFamily: 'Pretendard',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.2,
      )),
    );
  }
}