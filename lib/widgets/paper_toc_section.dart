// 목차
import 'package:flutter/material.dart';

class PaperTocSection extends StatelessWidget {
  const PaperTocSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ["배경", "문제", "해결", "실험", "결과", "영향"];

    return Column(
      children: items.map(
            (title) => Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFFE9EBF0), width: 1),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ).toList(),
    );
  }
}
