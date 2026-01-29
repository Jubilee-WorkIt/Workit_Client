import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SeekerHomeJobDetailScreen extends StatefulWidget {
  const SeekerHomeJobDetailScreen({super.key});

  @override
  State<SeekerHomeJobDetailScreen> createState() => _SeekerHomeJobDetailScreenState();
}

class _SeekerHomeJobDetailScreenState extends State<SeekerHomeJobDetailScreen> {
  bool isFavorite = false;

  final double topSpacing = 10.0; 
  final double contentTopPadding = 70.0; 

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
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: topSpacing),
            // 1 & 2. 이미지 에셋이 적용된 커스텀 AppBar
            Container(
              width: double.infinity,
              height: 54, 
              color: pointBlue,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                    // --- 수정 1: 화살표 이미지로 변경 ---
                    icon: Image.asset(
                      'assets/images/arrow_left.png', 
                      width: 24, 
                      height: 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  // const SizedBox(width: 12),
                  const Text(
                    'Job Posting',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),

                  IconButton(
                    onPressed: () => setState(() => isFavorite = !isFavorite),
                    icon: isFavorite
                        ? Image.asset(
                            'assets/images/heart_select.png', // 채워진 하트 이미지 경로
                            width: 22,
                            height: 22,
                          )
                        : Image.asset(
                            'assets/images/heart.png', // 빈 하트 이미지 경로
                            width: 22,
                            height: 22,
                          ),
                        ),  
                      ],
                    ),
                  ),
            
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
                              color: Color(0xFFDEE3E3),
                              fontSize: 11,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.2,
                            )),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Posting title',
                          style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
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
                                ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // 가로 스크롤 해시태그
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
                        const SizedBox(height: 28),
                        const Divider(color: Color(0xFFDEE3E3), thickness: 1),
                        const SizedBox(height: 25),
                        _sectionTitle('Detailed Information'),
                        const Text(
                          'Lorem ipsum dolor sit amet consectetur. Diam a vitae dolor sollicitudin. Viverra dui neque vitae cras nec congue faucibus.',
                          style: TextStyle(
                            color:  Color(0xFFDEE3E3),
                            fontSize: 13,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            ),
                        ),
                        const SizedBox(height: 32),
                        _sectionTitle('Qualifications'),
                        ...List.generate(4, (index) => _bulletPoint('Lorem ipsum dolor sit amet consectetur.', subTextGrey)),
                        const SizedBox(height: 32),
                        _sectionTitle('Location'),
                        Text(locationAddress, style: const TextStyle(
                          color:  Color(0xFFDEE3E3),
                          fontSize: 13,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          )),
                        const SizedBox(height: 16),
                        
                        // --- 수정 3: 지도 표시 설정 최적화 ---
                        Container(
                          width: double.infinity,
                          height: 172,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: FlutterMap(
                              options: const MapOptions(
                                initialCenter: locationLatLng, // center -> initialCenter로 변경 (v6+)
                                initialZoom: 17, // zoom -> initialZoom로 변경 (v6+)
                                maxZoom: 18,    // 사용자가 직접 확대할 수 있는 최대치 설정 (선택사항)
                                minZoom: 5,     // 최소 축소치 설정 (선택사항)
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

  // --- 나머지 Helper Widgets (_hashTag, _bulletPoint 등)은 동일하게 유지 ---
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
          height: 50,
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
              fontWeight: FontWeight.w600,
              )),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _bulletPoint(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 8), child: Icon(Icons.circle, size: 4, color: Colors.white)),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(
            color: Color(0xFFDEE3E3),
            fontSize: 13,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w400,
            ))),
        ],
      ),
    );
  }

  Widget _statusTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }

  Widget _hashTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(border: Border.all(color: Colors.white38), borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 13)),
    );
  }
}