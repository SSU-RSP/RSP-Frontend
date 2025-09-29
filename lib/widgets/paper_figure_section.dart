// 수식/그림/표 위젯
import 'package:flutter/material.dart';

class PaperFigureSection extends StatelessWidget {
  const PaperFigureSection({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO 실제 데이터 연동 전에는 더미로 2~3개 보여주기
    final dummyFigures = [
      "그림 1. 모델 구조 개요",
      "표 1. 성능 비교 결과",
      "수식 1. 손실 함수 정의",
    ];

    return Column(
      children: dummyFigures.map((caption) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Icon(Icons.image, size: 40, color: Colors.black45),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                caption,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
