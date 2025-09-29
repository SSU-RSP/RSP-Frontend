// Description: 논문 오디오 플레이어 위젯
import 'package:flutter/material.dart';
import '../../models/paper_item.dart';

class PaperAudioPlayer extends StatelessWidget {
  final PaperItem paper;

  const PaperAudioPlayer({super.key, required this.paper});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 40),

        // 논문 아이콘
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.description,
            color: Colors.white,
            size: 60,
          ),
        ),
        const SizedBox(height: 16),

        // 논문 제목
        Text(
          paper.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),

        // 저자/컨퍼런스
        Text(
          "${paper.authors} · ${paper.conference} ${paper.year}",
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),

        // 재생 버튼
        ElevatedButton(
          onPressed: () {
            // TODO: 오디오 API 연동
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            backgroundColor: Colors.white,
            shadowColor: Colors.black26,
            elevation: 6,
          ),
          child: const Icon(
            Icons.play_arrow,
            color: Color(0xFF6593FF),
            size: 36,
          ),
        ),
        const SizedBox(height: 12),

        // 음성 선택 버튼
        TextButton.icon(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  ListTile(
                    leading: Icon(Icons.male),
                    title: Text("남성 음성"),
                  ),
                  ListTile(
                    leading: Icon(Icons.female),
                    title: Text("여성 음성"),
                  ),
                  ListTile(
                    leading: Icon(Icons.list),
                    title: Text("목차 음성"),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.record_voice_over, color: Colors.white70),
          label: const Text(
            "음성 선택",
            style: TextStyle(color: Colors.white70),
          ),
        ),
      ],
    );
  }
}
