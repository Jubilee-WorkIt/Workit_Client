import 'package:flutter/material.dart';
import 'package:workit_app/features/auth/screens/login_screen.dart';
import 'package:workit_app/features/employer/screens/employer_home_screen.dart';
import 'package:workit_app/features/seeker/widgets/seeker_bottom_bar.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  // 현재 선택된 역할 ('seeker', 'employer')
  String selectedRole = '';

  @override
  Widget build(BuildContext context) {
    const Color darkBgColor = Color(0xFF001533);
    const Color unselectedCardColor = Color(0xFF11233D);
    const Color selectedCardColor = Color(0xFF2C3E5D);
    const Color mintColor = Color(0xFFA4E1F9);

    return Scaffold(
      backgroundColor: darkBgColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),

                  // 상단 바
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/light_arrow-back.png',
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                      ),
                      Image.asset('assets/images/logo.png', width: 150),
                      const SizedBox(width: 30),
                    ],
                  ),

                  const SizedBox(height: 50),
                  const Text(
                    'What is the purpose of your visit?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'To provide you with customized services,\nplease select your membership type.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFBCC1C3),
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Job Seeker
                  _roleCard(
                    roleKey: 'seeker',
                    imagePath: selectedRole == 'seeker'
                        ? 'assets/images/job_2.png'
                        : 'assets/images/job_1.png',
                    title: 'Job seeker',
                    description:
                        "I'm looking for part-time work in Australia and would like help with financial management.",
                    isSelected: selectedRole == 'seeker',
                    selectedColor: selectedCardColor,
                    unselectedColor: unselectedCardColor,
                    mintColor: mintColor,
                  ),

                  const SizedBox(height: 28),

                  // Employer
                  _roleCard(
                    roleKey: 'employer',
                    imagePath: selectedRole == 'employer'
                        ? 'assets/images/employer_2.png'
                        : 'assets/images/employer_1.png',
                    title: 'Employer',
                    description:
                        'I want to hire part-time employees for our company and promote the company.',
                    isSelected: selectedRole == 'employer',
                    selectedColor: selectedCardColor,
                    unselectedColor: unselectedCardColor,
                    mintColor: mintColor,
                  ),

                  const SizedBox(height: 140),
                ],
              ),
            ),

            // Next 버튼
            if (selectedRole.isNotEmpty)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedRole == 'seeker') {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SeekerBottomBar(),
                            ),
                            (route) => false,
                          );
                        } else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const EmployerHomeScreen(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mintColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 역할 카드
  Widget _roleCard({
    required String roleKey,
    required String imagePath,
    required String title,
    required String description,
    required bool isSelected,
    required Color selectedColor,
    required Color unselectedColor,
    required Color mintColor,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = roleKey;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? mintColor : Colors.white,
            width: 0.8,
          ),
          color: isSelected ? selectedColor : unselectedColor,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSelected ? mintColor : Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      width: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white60,
                    height: 1.4,
                  ),
                ),
              ],
            ),

            if (isSelected)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: mintColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/check.png',
                      width: 14,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}