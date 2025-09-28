import 'package:flutter/material.dart';
import '../../models/paper_item.dart';
import '../../widgets/paper_card.dart';
import '../Home/paper_detail_screen.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 더미 데이터
    final List<PaperItem> papers = [
      PaperItem(
        title: "Attention Is All You Need",
        authors: "Ashish Vaswani, Jakob Uszkoreit, ...",
        conference: "NIPS",
        year: 2017,
        summary: "이 논문은 Transformer라는 새로운 신경망 아키텍처를 제안합니다...",
      ),
      PaperItem(
        title: "BERT: Pre-training of Deep Bidirectional Transformers",
        authors: "Jacob Devlin, Ming-Wei Chang, ...",
        conference: "NAACL",
        year: 2019,
        summary: "BERT는 양방향 Transformer를 사용한 사전 훈련된 언어 모델입니다...",
      ),
      PaperItem(
        title: "ResNet: Deep Residual Learning for Image Recognition",
        authors: "Kaiming He, Xiangyu Zhang, ...",
        conference: "CVPR",
        year: 2016,
        summary: "ResNet은 잔차 연결(residual connection)을 도입하여...",
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),

            /// 상단 타이틀
            const Center(
              child: Column(
                children: [
                  Text(
                    "내 논문 목록",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "지금까지 읽은 논문들을 다시 들어보세요 🎧",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 26),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: papers.length,
                itemBuilder: (context, index) {
                  final paper = papers[index];
                  return PaperCard(
                    paper: paper,
                    showDate: false,
                    showPlayIcon: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaperDetailScreen(paper: paper),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
