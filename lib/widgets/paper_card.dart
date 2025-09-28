import 'package:flutter/material.dart';
import '../models/paper_item.dart';

class PaperCard extends StatelessWidget {
  final PaperItem paper;
  final bool showDate;
  final bool showPlayIcon;
  final VoidCallback? onTap;

  const PaperCard({
    super.key,
    required this.paper,
    this.showDate = true,
    this.showPlayIcon = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FBFF), // 살짝 파란톤 배경
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 왼쪽 컬러 라인
            Container(
              width: 4,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF6593FF),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 12),

            // 본문
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 제목
                  Text(
                    paper.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),

                  /// 저자 + 학회 + 연도
                  Text(
                    "${paper.authors} · ${paper.conference} ${paper.year}"
                        "${showDate ? " · 2일 전" : ""}",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),

                  /// 요약
                  Text(
                    paper.summary,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // 오른쪽 재생 버튼
            if (showPlayIcon)
              Container(
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF6593FF),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.white),
                  onPressed: () {
                    // TODO: 재생 기능
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

