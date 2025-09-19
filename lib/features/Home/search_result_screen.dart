import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;
  final List<PaperItem> results;

  const SearchResultScreen({
    super.key,
    required this.query,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "검색 결과",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "\"$query\" 검색 결과 ${results.length}개",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),

            /// 결과 리스트
            Expanded(
              child: ListView.separated(
                itemCount: results.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final paper = results[index];
                  return _buildPaperCard(context, paper);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 논문 카드 위젯
  Widget _buildPaperCard(BuildContext context, PaperItem paper) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        // TODO: 상세 페이지로 이동
        // Navigator.push(context, MaterialPageRoute(builder: (_) => PaperDetailScreen(paper: paper)));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 제목
            Text(
              paper.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            /// 저자 + 학회 + 연도
            Text(
              "${paper.authors} · ${paper.conference} ${paper.year}",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),

            /// 요약
            Text(
              paper.summary,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 데이터 모델
class PaperItem {
  final String title;
  final String authors;
  final String conference;
  final int year;
  final String summary;

  PaperItem({
    required this.title,
    required this.authors,
    required this.conference,
    required this.year,
    required this.summary,
  });
}
