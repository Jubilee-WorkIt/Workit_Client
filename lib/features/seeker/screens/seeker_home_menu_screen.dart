import 'package:flutter/material.dart';

class SeekerHomeMenuScreen extends StatefulWidget {
  const SeekerHomeMenuScreen({super.key});

  @override
  State<SeekerHomeMenuScreen> createState() => _SeekerHomeMenuScreenState();
}

class _SeekerHomeMenuScreenState extends State<SeekerHomeMenuScreen> {
  static const Color darkBgColor = Color(0xFF011637);

  int focusedColumnIndex = 0;
  String? selectedState; 
  String? selectedCity;
  List<String> selectedSuburbs = [];

  // --- 데이터 구조 정의 (이 부분을 수정하여 각 항목을 관리하세요) ---
  final Map<String, Map<String, List<String>>> regionData = {
    'NSW': {
      'Sydney': ['Sydney CBD', 'Surry Hills', 'Newtown', 'Parramatta', 'Chatswood', 'Burwood', 'Strathfield', 'Bondi', 'Mascot', 'Bankstown'],
      'Newcastle': ['Newcastle CBD', 'Hamilton', 'The Junction', 'Mayfield', 'Kotara', 'Charlestown', 'Wallsend'],
      'Wollongong': ['Wollongong CBD', 'Fairy Meadow ', 'Corrimal', 'Figtree', 'Unanderra', 'Shellharbour'],
      'Central Coast': ['Gosford', 'Erina', 'Terrigal', 'Woy Woy', 'Wyong', 'Tuggerah', 'The Entrance'],
      'Regional NSW': ['Albury', 'Wagga Wagga', 'Orange', 'Bathurst', 'Dubbo', 'Tamworth', 'Coffs Harbour', 'Port Macquarie', 'Byron Bay', 'Broken Hill'],
    },
    'VIC': {
      'Melbourne': ['Melbourne CBD', 'Fitzroy', 'Richmond', 'South Yarra', 'St Kilda', 'Carlton', 'Docklands', 'Footscray', 'Brunswick', 'Box Hill'],
      'Geelong': ['Geelong CBD', 'Newtown', 'Belmont', 'Grovedale', 'Waurn Ponds', 'Corio', 'Norlane'],
      'Ballarat': ['Ballarat Central', 'Ballarat East ', 'Ballarat North', 'Wendouree', 'Delacombe', 'Sebastopol'],
      'Bendigo': ['Bendigo CBD', 'Golden Square', 'Eaglehawk', 'Kangaroo Flat', 'Flora Hill', 'Strathdale'],
      'Regional VIC': ['Shepparton', 'Mildura', 'Warrnambool', 'Traralgon', 'Sale', 'Horsham', 'Wangaratta', 'Echuca'],
    },
    'QLD': {
      'Brisbane': ['Brisbane', 'Gold Coast', 'Sunshine Coast', 'Cairns', 'Townsville', 'Regional QLD'],
      'Gold Coast': ['Surfers Paradise', 'Southport', 'Broadbeach', 'Robina', 'Burleigh Heads', 'Helensvale'],
      'Sunshine Coast': ['Maroochydore', 'Mooloolaba', 'Caloundra', 'Noosa', 'Buderim', 'Sippy Downs'],
      'Cairns': ['Cairns CBD', 'Parramatta Park', 'Manunda', 'Earlville', 'Smithfield'],
      'Townsville': ['Townsville CBD', 'South Townsville', 'Hyde Park', 'Kirwan', 'Thuringowa Central'],
      'Regional QLD': ['Toowoomba', 'Rockhampton', 'Mackay', 'Bundaberg', 'Hervey Bay', 'Gladstone', 'Mount Isa'],
    },
    'WA': {
      'Perth': ['Perth CBD', 'Northbridge', 'Subiaco', 'Fremantle', 'Joondalup', 'Cannington', 'Midland'],
      'Mandurah': ['Mandurah CBD', 'Halls Head', 'Falcon', 'Greenfields'],
      'Bunbury': ['Bunbury CBD', 'South Bunbury', 'East Bunbury', 'Australind'],
      'Regional WA': ['Geraldton', 'Kalgoorlie', 'Albany', 'Broome', 'Karratha', 'Port Hedland', 'Esperance'],
    },
    'SA': {
      'Adelaide': ['Adelaide CBD', 'North Adelaide', 'Glenelg', 'Norwood', 'Unley', 'Prospect', 'Marion'],
      'Mount Gambier': ['Mount Gambier Central', 'Newtown', 'Belmont', 'Grovedale', 'Waurn Ponds', 'Corio', 'Norlane'],
      'Whyalla': ['Ballarat Central', 'Ballarat East ', 'Ballarat North', 'Wendouree', 'Delacombe', 'Sebastopol'],
      'Regional SA': ['Bendigo CBD', 'Mount Gambier ', 'Eaglehawk', 'Kangaroo Flat', 'Flora Hill', 'Strathdale'],
    },
    'TAS': {
      'Hobart': ['Hobart CBD', 'Sandy Bay', 'Battery Point', 'New Town', 'Glenorchy', 'Moonah'],
      'Launceston': ['Launceston CBD', 'Invermay', 'Newstead', 'Mowbray', 'Kings Meadows'],
      'Devonport': ['Devonport CBD', 'East Devonport', 'Miandetta'],
      'Burnie': ['Burnie CBD', 'South Burnie', 'Upper Burnie'],
      'Regional TAS': ['Ulverstone', 'Kingston', 'George Town', 'Scottsdale'],
    },
    'ACT': {
      'Canberra': ['Canberra City', 'Belconnen', 'Gungahlin', 'Woden', 'Tuggeranong', 'Weston Creek'],
    },
    'NT': {
      'Darwin': ['Darwin City', 'Palmerston', 'Nightcliff', 'Casuarina'],
      'Alice Springs': ['Alice Springs CBD', 'East Side', 'Sadadeen'],
      'Regional NT': ['Katherine', 'Tennant Creek', 'Nhulunbuy'],
    },
  };

  // 현재 상태에 따른 리스트 추출 getter
  List<String> get states => regionData.keys.toList();
  
  List<String> get cities {
    if (selectedState == null) return [];
    return regionData[selectedState]!.keys.toList();
  }

  List<String> get suburbs {
    if (selectedState == null || selectedCity == null) return [];
    return regionData[selectedState]![selectedCity] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          "Region Settings",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Pretendard'),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: darkBgColor,
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: const Text(
              'Please select your region.',
              style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Pretendard', fontWeight: FontWeight.w600,),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                // 1. State 컬럼
                _buildColumn(
                  'State', 
                  states, 
                  selectedState != null ? [selectedState!] : [], 
                  (val) {
                    setState(() {
                      if (selectedState == val) {
                        selectedState = null;
                        selectedCity = null;
                        selectedSuburbs.clear();
                        focusedColumnIndex = 0;
                      } else {
                        selectedState = val;
                        selectedCity = null; 
                        selectedSuburbs.clear();
                        focusedColumnIndex = 1;
                      }
                    });
                  }, 
                  const Color(0xFFB3E5FC), 
                  flex: focusedColumnIndex == 0 ? 2 : 1,
                  isLocked: false,
                ),

                // 2. City 컬럼
                _buildColumn(
                  'City', 
                  cities, 
                  selectedCity != null ? [selectedCity!] : [], 
                  (val) {
                    setState(() {
                      if (selectedCity == val) {
                        selectedCity = null;
                        selectedSuburbs.clear();
                        focusedColumnIndex = 1;
                      } else {
                        selectedCity = val;
                        selectedSuburbs.clear();
                        focusedColumnIndex = 2;
                      }
                    });
                  }, 
                  const Color(0xFFB3E5FC), 
                  flex: focusedColumnIndex == 1 ? 2 : 1,
                  isLocked: selectedState == null,
                ),

                // 3. Suburb 컬럼
                _buildColumn(
                  'Suburb', 
                  suburbs, 
                  selectedSuburbs, 
                  (val) {
                    setState(() {
                      if (selectedSuburbs.contains(val)) {
                        selectedSuburbs.remove(val);
                      } else if (selectedSuburbs.length < 4) {
                        selectedSuburbs.add(val);
                      }
                      focusedColumnIndex = 2;
                    });
                  }, 
                  const Color(0xFFB3E5FC), 
                  flex: focusedColumnIndex == 2 ? 2 : 1,
                  isLocked: selectedCity == null,
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFE9ECEF), thickness: 1),
          _buildSelectedLocationSection(),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  // --- UI 컴포넌트 (변경 없음) ---

  Widget _buildColumn(String title, List<String> items, List<String> selectedValues, Function(String) onSelected, Color headerColor, {required int flex, required bool isLocked}) {
    return Expanded(
      flex: flex, 
      child: GestureDetector(
        onTap: isLocked ? null : () => setState(() => focusedColumnIndex = (title == 'State' ? 0 : title == 'City' ? 1 : 2)),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isLocked ? Colors.grey[100] : headerColor,
                border: Border.all(color: Colors.grey.withOpacity(0.3), width: 0.5),
              ),
              child: Text(title, textAlign: TextAlign.center, style: TextStyle(
                fontSize: 12,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w400,
                color: isLocked ? Colors.grey : Colors.black,
                letterSpacing: -0.1,
                )),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isLocked ? Colors.grey[50] : Colors.white,
                  border: Border(right: BorderSide(color: Colors.grey.withOpacity(0.3), width: 0.5)),
                ),
                child: ListView.builder(
                  itemCount: items.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final isSelected = selectedValues.contains(item);

                    return GestureDetector(
                      onTap: isLocked ? null : () => onSelected(item),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFE3F2FD) : Colors.transparent,
                          border: isSelected ? const Border(
                          ) : null,
                        ),
                        child: Text(
                          item,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isLocked ? Colors.grey[300] : (isSelected ? const Color(0xFF009DFF) : const Color(0xFF707676)),
                            fontSize: 13,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            fontFamily: 'Pretendard',
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedLocationSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Selected location", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("Up to 4 selections possible", style: TextStyle(color: Colors.grey[400], fontSize: 12, fontFamily: 'Pretendard')),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: selectedSuburbs.map((suburb) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFD9EFFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => selectedSuburbs.remove(suburb)),
                    child: Image.asset('assets/images/close_icon.png', width: 14, height: 14), 
                  ),
                  const SizedBox(width: 6),
                  Text(suburb, style: const TextStyle(color: Color(0xFF2196F3), fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.1,)),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }

Widget _buildBottomButtons() {
    final bool hasSelection = selectedSuburbs.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: OutlinedButton(
              onPressed: () => setState(() {
                selectedState = null;
                selectedCity = null;
                selectedSuburbs.clear();
                focusedColumnIndex = 0;
              }),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.black12),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Row( // Row를 추가하여 이미지와 텍스트 배치
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/refresh_icon.png', // 아이콘 이미지 경로
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 4), // 아이콘과 글자 사이 간격
                  const Text(
                    "Initialization", 
                    style: TextStyle(
                      color: Colors.black, 
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: hasSelection ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: hasSelection ? const Color(0xFFB3E5FC) : Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: BorderSide(color: hasSelection ? Colors.transparent : Colors.black12),
                ),
              ),
              child: Text(
                hasSelection ? "Apply to ${selectedSuburbs.length} regions" : "Apply",
                style: const TextStyle(
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}