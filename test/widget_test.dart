// import 'package:flutter_test/flutter_test.dart';
// import 'package:workit_app/main.dart';  // 프로젝트 이름에 맞게

// void main() {
//   testWidgets('운동 투두 리스트 기본 테스트', (WidgetTester tester) async {
//     // 앱 실행
//     await tester.pumpWidget(const WorkitApp());

//     // 앱바에 "오늘의 운동 계획" 텍스트 있는지 확인
//     expect(find.text('오늘의 운동 계획'), findsOneWidget);

//     // 힌트 텍스트 확인
//     expect(find.text('오늘 할 운동 (예: 푸시업 50회)'), findsOneWidget);

//     // 추가 버튼 있는지 확인
//     expect(find.text('추가'), findsOneWidget);

//     // 처음엔 리스트 비어 있어서 안내 문구 보이는지 확인
//     expect(find.textContaining('오늘 할 운동을 추가해 보세요'), findsOneWidget);
//   });
// }