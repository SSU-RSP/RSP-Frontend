// 논문 요약 텍스트 박스

import 'package:flutter/material.dart';

class PaperSummarySection extends StatefulWidget {
  final String summary;
  const PaperSummarySection({super.key, required this.summary});

  @override
  State<PaperSummarySection> createState() => _PaperSummarySectionState();
}

class _PaperSummarySectionState extends State<PaperSummarySection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.summary,
            maxLines: _isExpanded ? null : 5,
            overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, height: 1.5),
          ),
          if (widget.summary.length > 150) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(
                _isExpanded ? "접기" : "더 보기",
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF6593FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
