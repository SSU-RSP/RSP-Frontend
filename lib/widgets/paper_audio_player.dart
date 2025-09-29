// Description: 논문 오디오 플레이어 위젯
import 'package:flutter/material.dart';

class PaperAudioPlayer extends StatelessWidget {
  final String title;
  final String authors;
  final String conference;
  final int year;

  const PaperAudioPlayer({
    super.key,
    required this.title,
    required this.authors,
    required this.conference,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 논문 메타정보
        Column(
          children: [
            const Icon(Icons.insert_drive_file, size: 80, color: Colors.blue),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "$authors · $conference $year",
              style: const TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 24),

        /// 컨트롤 버튼
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.play_circle_fill,
                  size: 56, color: Colors.blue),
              onPressed: () {
                // TODO: Typecast API 연동
              },
            ),
          ],
        ),
        const SizedBox(height: 16),

        /// 성별 선택 버튼
        TextButton.icon(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.male),
                    title: const Text("남성 음성"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.female),
                    title: const Text("여성 음성"),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.record_voice_over),
          label: const Text("음성 선택"),
        ),
      ],
    );
  }
}
