import 'package:flutter/material.dart';
import 'search_result_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  /// 검색 실행 함수
  void _executeSearch() {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("검색어를 입력해주세요.")),
      );
      return;
    }

    // TODO: 실제 API 연동 자리
    // 지금은 임시 데이터로 예시 보여줌
    final dummyResults = [
      PaperItem(
        title: '"$query"와 관련된 딥러닝 연구',
        authors: "Research Team A et al.",
        conference: "ICML",
        year: 2024,
        summary: "이 논문은 $query 에 대한 최신 연구를 다룹니다. "
            "혁신적인 접근으로 기존 한계를 극복하고 성능을 향상시켰습니다.",
      ),
      PaperItem(
        title: "$query 기반 새로운 아키텍처 설계",
        authors: "Research Team B et al.",
        conference: "NeurIPS",
        year: 2023,
        summary: "$query 를 활용한 아키텍처의 최적화 연구입니다. "
            "실험 결과 기존 모델 대비 성능 향상을 확인했습니다.",
      ),
      PaperItem(
        title: "$query 의 실제 응용 사례 연구",
        authors: "Industry Team C et al.",
        conference: "ICLR",
        year: 2024,
        summary: "$query 기술을 실제 산업 현장에 적용한 사례를 분석하고, "
            "안정성을 평가한 연구입니다.",
      ),
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SearchResultScreen(query: query, results: dummyResults),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// 임시 아이콘 (추후 이미지 교체)
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6593FF), Color(0xFF9BBEFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 20),

              /// 타이틀
              const Text(
                "논문 검색",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "키워드로 관련 논문을 찾아보세요",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 24),

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
                  _buildKeywordChip("Transformer"),
                  _buildKeywordChip("BERT"),
                  _buildKeywordChip("GPT"),
                  _buildKeywordChip("Vision"),
                  _buildKeywordChip("Deep Learning"),
                  _buildKeywordChip("LLM"),
                  _buildKeywordChip("Diffusion Models"),
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "검색 팁",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "• 구체적인 기술명이나 방법론으로 검색하면 더 정확한 결과를 얻을 수 있습니다\n"
                          "• 영어 키워드를 사용하면 더 많은 논문을 찾을 수 있습니다\n"
                          "• 여러 키워드를 조합해서 검색해보세요",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 애플스러운 키워드 Chip
  static Widget _buildKeywordChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6FA),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }
}
