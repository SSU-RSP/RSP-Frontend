import 'package:flutter/material.dart';
import '../../models/paper_item.dart';
import '../../widgets/paper_audio_player.dart';
import '../../widgets/paper_summary_section.dart';
import '../../widgets/paper_toc_section.dart';
import '../../widgets/paper_figure_section.dart';

class PaperDetailScreen extends StatelessWidget {
  final PaperItem paper;

  const PaperDetailScreen({super.key, required this.paper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 상단 AppBar + 오디오 플레이어
          SliverAppBar(
            pinned: true,
            expandedHeight: 420,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF6593FF), Color(0xFF9B6DFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: PaperAudioPlayer(paper: paper),
                ),
              ),
            ),
          ),

          // 🔹 본문 (카드 스타일)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSectionCard(
                    context,
                    title: "논문 요약",
                    child: PaperSummarySection(summary: paper.summary),
                  ),
                  const SizedBox(height: 16),

                  _buildSectionCard(
                    context,
                    title: "목차",
                    child: const PaperTocSection(),
                  ),
                  const SizedBox(height: 16),

                  _buildSectionCard(
                    context,
                    title: "수식·그림·표 해석",
                    child: PaperFigureSection(
                      equations: paper.equations,
                      tables: paper.tables,
                      figures: paper.figures,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 카드 스타일 공통 위젯
  Widget _buildSectionCard(BuildContext context,
      {required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.bookmark, color: Color(0xFF6593FF), size: 20),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
