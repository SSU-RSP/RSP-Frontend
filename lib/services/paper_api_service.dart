import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/paper_item.dart';

class PaperApiService {
  static const String baseUrl = 'https://diphase-woodrow-caespitosely.ngrok-free.dev';
  
  /// TTS API 키 가져오기 (환경 변수에서)
  static String? get ttsApiKey => dotenv.env['TTS_API_KEY'];
  
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

  /// 논문 상세 정보 API 호출 (/api/summary)
  /// 검색 결과 전체 객체를 전달
  static Future<PaperItem> getPaperDetail(PaperItem searchResult) async {
    try {
      print('🔵 [API] 요약 정보 요청 시작: ${searchResult.arxivId}');
      
      // 검색 결과 전체 객체를 body에 포함
      final requestBody = {
        'arxivId': searchResult.arxivId,
        'title': searchResult.title,
        'authors': searchResult.authors,
        'publishedDate': searchResult.publishedDate,
        'abstractText': searchResult.abstractText,
      };
      
      print('🔵 [API] 요청 본문: ${json.encode(requestBody)}');
      
      // POST 방식: 검색 결과 전체 객체 전달
      final response = await http.post(
        Uri.parse('$baseUrl/api/summary'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(requestBody),
      );

      print('🔵 [API] 응답 상태 코드: ${response.statusCode}');
      print('🔵 [API] 응답 본문: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> data = json.decode(response.body);
          print('🔵 [API] 파싱 성공');
          return _parseSummaryResponse(data);
        } catch (e) {
          print('🔴 [API] JSON 파싱 실패: $e');
          throw Exception('응답 파싱 실패: $e');
        }
      } else {
        print('🔴 [API] 요청 실패: ${response.statusCode}');
        print('🔴 [API] 에러 본문: ${response.body}');
        throw Exception('요약 정보 조회 실패: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('🔴 [API] 예외 발생: $e');
      rethrow;
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

  /// /api/summary 응답을 PaperItem으로 변환
  static PaperItem _parseSummaryResponse(Map<String, dynamic> json) {
    final paper = json['paper'] as Map<String, dynamic>? ?? {};
    final summary = json['summary'] as Map<String, dynamic>? ?? {};
    final assets = json['assets'] as Map<String, dynamic>? ?? {};
    final podcast = json['podcast'] as Map<String, dynamic>? ?? {};
    final storytelling = json['storytelling'] as Map<String, dynamic>?;

    // 서버 에러 체크: paper 필드가 모두 null이면 서버 에러
    final hasError = paper['title'] == null && 
                     paper['authors'] == null && 
                     summary['text']?.toString().contains('에러') == true;
    
    if (hasError) {
      print('🔴 [API] 서버에서 에러 응답: ${summary['text']}');
    }

    // publishedAt 또는 publishedDate에서 year 추출
    int year = 0;
    final dateStr = paper['publishedAt'] ?? paper['publishedDate'];
    if (dateStr != null) {
      try {
        final date = dateStr is String ? dateStr : dateStr.toString();
        if (date.length >= 4) {
          year = int.tryParse(date.substring(0, 4)) ?? 0;
        }
      } catch (e) {
        // 파싱 실패 시 0 유지
      }
    }

    // StorytellingItem 생성
    StorytellingItem? storytellingItem;
    if (storytelling != null && storytelling.isNotEmpty) {
      storytellingItem = StorytellingItem(
        title: storytelling['title'],
        background: storytelling['background'],
        problem: storytelling['problem'],
        method: storytelling['method'],
        experiment: storytelling['experiment'],
        result: storytelling['result'],
        impact: storytelling['impact'],
      );
    }

    // summary.text가 에러 메시지인 경우 빈 문자열로 처리
    String summaryText = summary['text'] ?? '';
    if (summaryText.contains('에러로 인해') || summaryText.contains('불러오지 못했습니다')) {
      summaryText = '';
    }

    return PaperItem(
      title: paper['title'] ?? '제목 없음',
      authors: paper['authors'] ?? '저자 정보 없음',
      conference: 'arXiv', // 응답에 없으면 기본값
      year: year,
      summary: summaryText, // summary.text 사용
      arxivId: paper['arxivId'],
      publishedDate: dateStr?.toString(),
      abstractText: paper['abstractText'],
      equations: null, // API에서 제공하지 않음
      tables: assets['tables'] != null && (assets['tables'] as List).isNotEmpty
          ? (assets['tables'] as List)
              .map((e) => FigureItem(
                    imageUrl: e['imageUrl'] ?? '',
                    description: e['description'] ?? '',
                  ))
              .toList()
          : null,
      figures: assets['figures'] != null && (assets['figures'] as List).isNotEmpty
          ? (assets['figures'] as List)
              .map((e) => FigureItem(
                    imageUrl: e['imageUrl'] ?? '',
                    description: e['description'] ?? '',
                  ))
              .toList()
          : null,
      podcastScript: podcast['script']?.toString().isNotEmpty == true 
          ? podcast['script'] 
          : null,
      storytelling: storytellingItem,
    );
  }

  /// 상세 정보를 PaperItem으로 변환 (기존 방식 - 호환성 유지)
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
