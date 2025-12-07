// 수식/그림/표 위젯
import 'package:flutter/material.dart';
import '../models/paper_item.dart';

class PaperFigureSection extends StatelessWidget {
  final List<FigureItem>? equations;
  final List<FigureItem>? tables;
  final List<FigureItem>? figures;

  const PaperFigureSection({
    super.key,
    this.equations,
    this.tables,
    this.figures,
  });

  @override
  Widget build(BuildContext context) {
    final allItems = <Map<String, dynamic>>[];

    // 수식 추가
    if (equations != null) {
      for (var i = 0; i < equations!.length; i++) {
        allItems.add({
          'type': '수식',
          'index': i + 1,
          'item': equations![i],
        });
      }
    }

    // 테이블 추가
    if (tables != null) {
      for (var i = 0; i < tables!.length; i++) {
        allItems.add({
          'type': '표',
          'index': i + 1,
          'item': tables![i],
        });
      }
    }

    // 그림 추가
    if (figures != null) {
      for (var i = 0; i < figures!.length; i++) {
        allItems.add({
          'type': '그림',
          'index': i + 1,
          'item': figures![i],
        });
      }
    }

    if (allItems.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "수식·그림·표 정보가 없습니다.",
            style: TextStyle(color: Colors.black54),
          ),
        ),
      );
    }

    return Column(
      children: allItems.map((data) {
        final type = data['type'] as String;
        final index = data['index'] as int;
        final item = data['item'] as FigureItem;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FB),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 타입 라벨
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF6593FF),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "$type $index",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 이미지
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.broken_image, size: 40, color: Colors.black45),
                            SizedBox(height: 8),
                            Text(
                              "이미지를 불러올 수 없습니다",
                              style: TextStyle(fontSize: 12, color: Colors.black45),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),

              // 설명
              Text(
                item.description,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
