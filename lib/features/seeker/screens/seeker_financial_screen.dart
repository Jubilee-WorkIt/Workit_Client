import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

// --- 천 단위 콤마 실시간 입력을 위한 포맷터 ---
class CommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    
    // 숫자 이외의 문자 제거
    String newText = newValue.text.replaceAll(',', '');
    final double? value = double.tryParse(newText);
    
    if (value == null) return oldValue;

    final formatter = NumberFormat('#,###');
    String formatted = formatter.format(value);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class DepositData {
  final String date;
  final String amount;
  final String from;
  final String to;
  DepositData({required this.date, required this.amount, required this.from, required this.to});
}

class SeekerFinancialScreen extends StatefulWidget {
  const SeekerFinancialScreen({super.key});

  @override
  State<SeekerFinancialScreen> createState() => _SeekerFinancialScreenState();
}

class _SeekerFinancialScreenState extends State<SeekerFinancialScreen> {
  final TextEditingController _audController = TextEditingController(text: "1");
  final NumberFormat _commaFormat = NumberFormat('#,###.##');
  
  double _exchangeRate = 967.30;
  String _calculatedKrw = "967.30";
  bool _isLoading = false;
  String _lastUpdated = DateFormat('MMMM d, yyyy').format(DateTime.now());

  final List<DepositData> _depositHistory = [
    DepositData(date: "Tuesday, December 23, 2025", amount: "1,000,000원", from: "회사명", to: "계좌명"),
    DepositData(date: "Sunday, November 23, 2025", amount: "1,000,000원", from: "회사명", to: "계좌명"),
  ];

  @override
  void initState() {
    super.initState();
    _fetchRate();
    _audController.addListener(_onAmountChanged);
  }

  Future<void> _fetchRate() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(Uri.parse('https://open.er-api.com/v6/latest/AUD'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _exchangeRate = data['rates']['KRW'];
          _lastUpdated = DateFormat('MMMM d, yyyy').format(DateTime.now());
          _onAmountChanged();
        });
      }
    } catch (e) {
      debugPrint("API Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onAmountChanged() {
    final String cleanText = _audController.text.replaceAll(',', '');
    final double input = double.tryParse(cleanText) ?? 0;
    setState(() {
      _calculatedKrw = _commaFormat.format(input * _exchangeRate);
    });
  }

  @override
  void dispose() {
    _audController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF011637),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 70, bottom: 150),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 31),
            _buildPaydaySection(),
            const SizedBox(height: 40),
            _buildExchangeRateHeader(),
            const SizedBox(height: 24),
            _buildExchangeCard("Australia", "AUD", _audController, "dollar", 'assets/images/aus.png', isInput: true),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 17),
              child: Center(child: Image.asset('assets/images/equal.png', width: 20)),
            ),
            _buildExchangeCard("Korea", "KRW", TextEditingController(text: _calculatedKrw), "won", 'assets/images/kor.png', isInput: false),
            const SizedBox(height: 40),
            _buildDepositHistoryHeader(),
            ..._depositHistory.map((data) => _buildDepositItem(data)).toList(),
          ],
        ),
      ),
    );
  }

  // --- 위젯 헬퍼 함수들 ---

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Financial", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
        Image.asset('assets/images/notification.png', width: 22, height: 22),
      ],
    );
  }

  Widget _buildPaydaySection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Until the next payday", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
            _buildSmallOutlineButton("My payday"),
          ],
        ),
        const SizedBox(height: 21),
        Row(
          children: [
            Image.asset('assets/images/koala_financial.png', width: 93, height: 81),
            const SizedBox(width: 22),
            Expanded(
              child: Container(
                height: 85,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFF43C7FF), width: 6)),
                alignment: Alignment.center,
                child: const Text("D - 19", style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600, color: Color(0xFF43C7FF))),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExchangeRateHeader() {
    return Row(
      children: [
        const Text("Today's exchange rate", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
        const SizedBox(width: 10),
        Text("As of $_lastUpdated", style: const TextStyle(color: Color(0xFFF2F2F2), fontSize: 10)),
        const Spacer(),
        GestureDetector(
          onTap: _fetchRate,
          child: _isLoading 
            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
            : Image.asset('assets/images/refresh.png', width: 18, height: 18),
        ),
      ],
    );
  }

  Widget _buildExchangeCard(String country, String unit, TextEditingController controller, String unitLabel, String flag, {required bool isInput}) {
    return Container(
      height: 66,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            width: 150,
            decoration: const BoxDecoration(color: Color(0xFFCBEDFB), borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(flag, width: 28),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(country, style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
                    Text(unit, style: const TextStyle(color: Colors.black, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  isInput 
                    ? TextField(
                        controller: controller,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, CommaTextInputFormatter()],
                        style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
                        decoration: const InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.zero),
                      )
                    : Text(controller.text, style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600)),
                  Text("${controller.text} $unitLabel", style: const TextStyle(color: Color(0xFF707676), fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepositHistoryHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Deposit history", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
          _buildSmallOutlineButton("View details"),
        ],
      ),
    );
  }

  Widget _buildDepositItem(DepositData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data.date, style: const TextStyle(color: Color(0xFF9DA8B7), fontSize: 14)),
              Image.asset('assets/images/arrow_right.png', width: 18),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const CircleAvatar(radius: 28, backgroundColor: Colors.white),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.amount, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text("${data.from}  →  ${data.to}", style: const TextStyle(color: Color(0xFF929696), fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallOutlineButton(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFF4E5B70), width: 1)),
      child: Text(label, style: const TextStyle(color: Color(0xFFBCC1C3), fontSize: 10)),
    );
  }
}