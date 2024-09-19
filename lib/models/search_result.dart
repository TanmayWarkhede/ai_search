class SearchResult {
  final String title;
  final String url;
  final String snippet;

  SearchResult({required this.title, required this.url, required this.snippet});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      title: json['Text'] ?? '',
      url: json['FirstURL'] ?? '',
      snippet: json['Result'] ?? '',
    );
  }
}

class SearchResponse {
  final String overallSummary;
  final List<SearchResult> searchResults;

  SearchResponse({required this.overallSummary, required this.searchResults});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    var list = json['RelatedTopics'] as List;
    List<SearchResult> searchResultsList =
        list.map((i) => SearchResult.fromJson(i)).toList();

    return SearchResponse(
      overallSummary:
          "Here are some results for your query.", // Simple placeholder summary
      searchResults: searchResultsList,
    );
  }
}
