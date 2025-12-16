import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/paper_item.dart';

class PaperApiService {
  static const String baseUrl = 'https://diphase-woodrow-caespitosely.ngrok-free.dev';
  
  /// 논문 검색 API 호출 (POST)
  static Future<List<PaperItem>> searchPapers(String query) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/papers/search'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'keyword': query,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> searchResults = data['searchResultList'] ?? [];
        return searchResults.map((json) => _parseSearchResultItem(json)).toList();
      } else {
        throw Exception('검색 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('검색 중 오류 발생: $e');
    }
  }

  /// 논문 상세 정보 API 호출 (arxivId로 조회)
  static Future<PaperItem> getPaperDetail(String arxivId) async {
    try {
      // TODO: 실제 상세 정보 API 엔드포인트 확인 필요
      // 예상: GET /api/papers/detail?arxivId=...
      final response = await http.get(
        Uri.parse('$baseUrl/api/papers/detail?arxivId=${Uri.encodeComponent(arxivId)}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return _parsePaperItem(data);
      } else {
        throw Exception('상세 정보 조회 실패: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('상세 정보 조회 중 오류 발생: $e');
    }
  }

  /// 검색 결과를 PaperItem으로 변환 (목록용 - 간단한 정보만)
  static PaperItem _parseSearchResultItem(Map<String, dynamic> json) {
    // publishedDate에서 year 추출
    int year = 0;
    if (json['publishedDate'] != null) {
      try {
        final dateStr = json['publishedDate'] as String;
        if (dateStr.length >= 4) {
          year = int.tryParse(dateStr.substring(0, 4)) ?? 0;
        }
      } catch (e) {
        // 파싱 실패 시 0 유지
      }
    }

    return PaperItem(
      title: json['title'] ?? '',
      authors: json['authors'] ?? '',
      conference: 'arXiv', // 검색 결과에는 conference 정보가 없으므로 기본값
      year: year,
      summary: json['abstractText'] ?? '',
      arxivId: json['arxivId'],
      publishedDate: json['publishedDate'],
      abstractText: json['abstractText'],
    );
  }

  /// 상세 정보를 PaperItem으로 변환 (전체 정보 포함)
  static PaperItem _parsePaperItem(Map<String, dynamic> json) {
    // publishedDate에서 year 추출
    int year = 0;
    if (json['publishedDate'] != null) {
      try {
        final dateStr = json['publishedDate'] is String 
            ? json['publishedDate'] as String
            : json['publishedDate'].toString();
        if (dateStr.length >= 4) {
          year = int.tryParse(dateStr.substring(0, 4)) ?? 0;
        }
      } catch (e) {
        // 파싱 실패 시 0 유지
      }
    }

    return PaperItem(
      title: json['title'] ?? '',
      authors: json['authors'] ?? '',
      conference: json['conference'] ?? 'arXiv',
      year: year,
      summary: json['summary'] ?? json['abstractText'] ?? '',
      arxivId: json['arxivId'],
      publishedDate: json['publishedDate']?.toString(),
      abstractText: json['abstractText'],
      equations: json['equations'] != null
          ? (json['equations'] as List)
              .map((e) => FigureItem(
                    imageUrl: e['image_url'] ?? e['imageUrl'] ?? '',
                    description: e['description'] ?? '',
                  ))
              .toList()
          : null,
      tables: json['tables'] != null
          ? (json['tables'] as List)
              .map((e) => FigureItem(
                    imageUrl: e['image_url'] ?? e['imageUrl'] ?? '',
                    description: e['description'] ?? '',
                  ))
              .toList()
          : null,
      figures: json['figures'] != null
          ? (json['figures'] as List)
              .map((e) => FigureItem(
                    imageUrl: e['image_url'] ?? e['imageUrl'] ?? '',
                    description: e['description'] ?? '',
                  ))
              .toList()
          : null,
      podcastScript: json['podcastScript'],
    );
  }
}
