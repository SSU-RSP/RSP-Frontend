// 목차
import 'package:flutter/material.dart';
import '../models/paper_item.dart';

class PaperTocSection extends StatelessWidget {
  final StorytellingItem? storytelling;

  const PaperTocSection({
    super.key,
    this.storytelling,
  });

  @override
  Widget build(BuildContext context) {
    // API에서 받은 storytelling 정보가 있으면 사용, 없으면 더미 데이터 사용
    final items = storytelling != null
        ? [
            if (storytelling!.background != null)
              {
                "title": "배경",
                "content": storytelling!.background!,
              },
            if (storytelling!.problem != null)
              {
                "title": "문제",
                "content": storytelling!.problem!,
              },
            if (storytelling!.method != null)
              {
                "title": "해결",
                "content": storytelling!.method!,
              },
            if (storytelling!.experiment != null)
              {
                "title": "실험",
                "content": storytelling!.experiment!,
              },
            if (storytelling!.result != null)
              {
                "title": "결과",
                "content": storytelling!.result!,
              },
            if (storytelling!.impact != null)
              {
                "title": "영향",
                "content": storytelling!.impact!,
              },
          ]
        : [
            // 더미 데이터 (API에서 storytelling이 없을 때)
            {
              "title": "배경",
              "content": "BERT가 자연어 처리의 최강자지만, 유독 '문장 임베딩(Sentence Embedding)' 성능은 최악임. 심지어 옛날 모델인 GloVe보다도 성능이 안 나오는 상황."
            },
            {
              "title": "문제",
              "content": "원인은 '단어 편향(Bias)' 때문. BERT가 문장의 '의미'보다 단어의 빈도수, 대소문자, 문장부호 같은 껍데기 정보에 너무 민감하게 반응함."
            },
            {
              "title": "해결",
              "content": "프롬프트(Prompt) 활용: 문장을 그냥 넣지 않고, '이 문장의 뜻은 [MASK]다' 같은 템플릿에 넣어 질문함. 템플릿 디노이징(Denoising): 템플릿 자체(껍데기)가 주는 불필요한 정보 값을 수학적으로 제거해서 순수 의미만 남김."
            },
            {
              "title": "실험",
              "content": "정답 데이터가 없는 환경(비지도 학습)에서 테스트. 당시 가장 성능이 좋았던 SimCSE 모델과 비교 실험."
            },
            {
              "title": "결과",
              "content": "기존 BERT 사용법 대비 성능 대폭 상승. 경쟁 모델(SimCSE)보다 약 2.5점 더 높은 점수를 기록하며 최고 성능(SOTA) 달성."
            },
            {
              "title": "영향",
              "content": "BERT 성능이 나쁜 게 아니라, 우리가 쓰는 방법이 틀렸다는 것을 증명. 복잡한 학습 없이 프롬프트만 잘 써도 문장 임베딩 성능을 극대화할 수 있음을 보여줌."
            },
          ];

    if (items.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "목차 정보가 없습니다.",
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );
    }

    return Column(
      children: items.map((item) {
        return ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(vertical: 4),
          childrenPadding: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
          title: Text(
            item["title"]!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          children: [
            Text(
              item["content"]!,
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
