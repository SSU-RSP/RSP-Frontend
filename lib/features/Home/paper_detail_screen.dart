import 'package:flutter/material.dart';
import '../../models/paper_item.dart';

class PaperDetailScreen extends StatelessWidget {
  final PaperItem paper;

  const PaperDetailScreen({super.key, required this.paper});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(paper.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              paper.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text("${paper.authors} · ${paper.conference} ${paper.year}"),
            const SizedBox(height: 16),
            Text(paper.summary),
          ],
        ),
      ),
    );
  }
}
