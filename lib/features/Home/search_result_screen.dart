import 'package:flutter/material.dart';
import '../../models/paper_item.dart';
import '../../widgets/paper_card.dart';
import 'paper_detail_screen.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;
  final List<PaperItem> results;

  const SearchResultScreen({
    super.key,
    required this.query,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("검색 결과"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: results.length,
        itemBuilder: (context, index) {
          final paper = results[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PaperDetailScreen(paper: paper),
                ),
              );
            },
            child: PaperCard(
                paper: paper,
                showDate: false,
            ),
          );
        },
      ),
    );
  }
}