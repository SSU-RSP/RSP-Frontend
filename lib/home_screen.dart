import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1; // 기본은 메인 탭

  final List<Widget> _pages = [
    const ListPage(), // 목록
    const HomePage(), // 메인 (검색)
    const MyPage(),   // 마이
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF6593FF),
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.list_bullet), label: "목록"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_fill), label: "메인"),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: "마이"),
        ],

      ),
    );
  }
}

/// 임시 페이지들 (세부 기능은 각자 구현 예정)
class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("목록 페이지"));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("메인 (검색) 페이지"));
  }
}

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("마이 페이지"));
  }
}
