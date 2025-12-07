import 'package:flutter/material.dart';
import 'search_result_screen.dart';
import '../../models/paper_item.dart';
import '../../data/dummy_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  /// 검색 실행 함수
  void _executeSearch() {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("검색어를 입력해주세요.")),
      );
      return;
    }

    // ✅ 더미 데이터 (getSearchResults 함수 사용)
    final results = getSearchResults(query);

    // 검색 결과 화면으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultScreen(
          query: query,
          results: results,
        ),
      ),
    );
  }

  // 인기 검색어 Chip 위젯
  Widget _buildKeywordChip(String keyword) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _searchController.text = keyword;
        });
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          keyword,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              /// 상단 아이콘 + 타이틀
              Column(
                children: const [
                  Icon(Icons.auto_awesome, size: 64, color: Color(0xFF6593FF)),
                  SizedBox(height: 16),
                  Text(
                    "논문 검색",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "키워드로 관련 논문을 찾아보세요",
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              /// 검색 입력창
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        focusNode: _focusNode,
                        decoration: const InputDecoration(
                          hintText: "논문 검색 키워드 입력 (예: Transformer)",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search, color: Color(0xFF6593FF)),
                      onPressed: _executeSearch,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              /// 검색 버튼
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _executeSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6593FF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "논문 검색하기",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              /// 인기 검색어
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "인기 검색어",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildKeywordChip("PromptBERT"),
                  _buildKeywordChip("Transformer"),
                  _buildKeywordChip("BERT"),
                  _buildKeywordChip("GPT"),
                  _buildKeywordChip("Vision"),
                  _buildKeywordChip("Deep Learning"),
                  _buildKeywordChip("LLM"),
                ],
              ),

              const SizedBox(height: 32),

              /// 검색 팁
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "검색 팁\n"
                      "• 구체적인 기술명이나 방법론으로 검색하면 더 정확한 결과를 얻을 수 있습니다\n"
                      "• 영어 키워드를 사용하면 더 많은 논문을 찾을 수 있습니다\n"
                      "• 여러 키워드를 조합해서 검색해보세요",
                  style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
