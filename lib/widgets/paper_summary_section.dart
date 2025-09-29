// 논문 요약 텍스트 박스

import 'package:flutter/material.dart';

class PaperSummarySection extends StatelessWidget {
  final String summary;
  const PaperSummarySection({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        summary,
        style: const TextStyle(fontSize: 14, height: 1.5),
      ),
    );
  }
}
