import 'package:flutter/material.dart';
import 'auth_login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// 메인 로고
              Image.asset(
                'assets/MainLogo.png',
                width: 160,
                height: 160,
              ),
              const SizedBox(height: 3),

              /// 앱 타이틀
              const Text(
                "RSP",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  height: 1.0, // 라인 높이 줄여서 여백 최소화
                ),
              ),
              const SizedBox(height: 12),

              /// 설명 텍스트
              const Text(
                "읽고 듣기 쉬운 논문",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),

              const Text(
                "학술 논문을 AI가 요약하고\n음성으로 들려드립니다",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),

              /// 로그인 버튼
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const AuthLoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6593FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "로그인",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              /// 하단 안내 텍스트
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  "계속하면 서비스 약관과 개인정보 보호정책에 동의하는 것으로 간주됩니다.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
