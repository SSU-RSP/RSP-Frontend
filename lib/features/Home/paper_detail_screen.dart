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
      appBar: AppBar(
        title: const Text("논문 상세"),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 1) 오디오 플레이어
            PaperAudioPlayer(
              title: paper.title,
              authors: paper.authors,
              conference: paper.conference,
              year: paper.year,
            ),
            const SizedBox(height: 24),

            /// 2) 요약 섹션
            const Text(
              "논문 요약",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            PaperSummarySection(summary: paper.summary),
            const SizedBox(height: 24),

            /// 3) 목차 (고정 6단계)
            const Text(
              "목차",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const PaperTocSection(),
            const SizedBox(height: 24),

            /// 4) 그림/표/수식 섹션
            const Text(
              "수식·그림·표 해석",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const PaperFigureSection(),
          ],
        ),
      ),
    );
  }
}
