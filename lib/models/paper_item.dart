class PaperItem {
  final String title;
  final String authors;
  final String conference;
  final int year;
  final String summary;
  final String? arxivId;
  final String? publishedDate;
  final String? abstractText;
  final List<FigureItem>? equations;
  final List<FigureItem>? tables;
  final List<FigureItem>? figures;
  final String? podcastScript;
  final StorytellingItem? storytelling;

  PaperItem({
    required this.title,
    required this.authors,
    required this.conference,
    required this.year,
    required this.summary,
    this.arxivId,
    this.publishedDate,
    this.abstractText,
    this.equations,
    this.tables,
    this.figures,
    this.podcastScript,
    this.storytelling,
  });
}

class StorytellingItem {
  final String? title;
  final String? background;
  final String? problem;
  final String? method;
  final String? experiment;
  final String? result;
  final String? impact;

  StorytellingItem({
    this.title,
    this.background,
    this.problem,
    this.method,
    this.experiment,
    this.result,
    this.impact,
  });
}

class FigureItem {
  final String imageUrl;
  final String description;

  FigureItem({
    required this.imageUrl,
    required this.description,
  });
}
