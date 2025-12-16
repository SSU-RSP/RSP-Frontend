import 'package:flutter/material.dart';
import '../../models/paper_item.dart';
import '../../widgets/paper_card.dart';
import '../../services/paper_api_service.dart';
import 'paper_detail_screen.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;
  final List<PaperItem> results;

  const SearchResultScreen({
    super.key,
    required this.query,
    required this.results,
  });

  Future<void> _navigateToDetail(BuildContext context, PaperItem paper) async {
    // arxivId가 없으면 현재 paper 정보로 바로 이동
    if (paper.arxivId == null || paper.arxivId!.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PaperDetailScreen(paper: paper),
        ),
      );
      return;
    }

    // 로딩 다이얼로그 표시
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      // 상세 정보 API 호출
      final detailedPaper = await PaperApiService.getPaperDetail(paper.arxivId!);

      // 로딩 다이얼로그 닫기
      if (context.mounted) Navigator.pop(context);

      // 상세 화면으로 이동
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PaperDetailScreen(paper: detailedPaper),
          ),
        );
      }
    } catch (e) {
      // 로딩 다이얼로그 닫기
      if (context.mounted) Navigator.pop(context);

      // 에러 발생 시 기본 정보로 이동
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PaperDetailScreen(paper: paper),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('상세 정보를 불러올 수 없습니다: $e'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("검색 결과 (${results.length}개)"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: results.isEmpty
          ? const Center(
              child: Text(
                "검색 결과가 없습니다.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final paper = results[index];
                return GestureDetector(
                  onTap: () => _navigateToDetail(context, paper),
                  child: PaperCard(
                    paper: paper,
                    showDate: false,
                  ),
                );
              },
            ),
    );
  }
}