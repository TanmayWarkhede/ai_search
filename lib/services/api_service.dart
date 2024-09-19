import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/search_result.dart';

class ApiService {
  Future<SearchResponse> searchQuery(String query) async {
    final response = await http
        .get(Uri.parse('https://api.duckduckgo.com/?q=$query&format=json'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<SearchResult> searchResults = (data['RelatedTopics'] as List)
          .map((item) => SearchResult(
                title: item['Text'] ?? '',
                url: item['FirstURL'] ?? '',
                snippet: item['Result'] ?? '',
              ))
          .toList();

      return SearchResponse(
        overallSummary:
            "Here are some results for your query.", // Placeholder summary
        searchResults: searchResults,
      );
    } else {
      throw Exception('Failed to fetch search results');
    }
  }
}
