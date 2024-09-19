import 'package:flutter/material.dart';
import '../models/search_result.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchResultsScreen extends StatelessWidget {
  final SearchResponse results;

  SearchResultsScreen({required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results', style: GoogleFonts.lato()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Overall Summary',
              style:
                  GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(results.overallSummary, style: GoogleFonts.lato(fontSize: 16)),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: results.searchResults.length,
                itemBuilder: (context, index) {
                  final result = results.searchResults[index];
                  return ListTile(
                    title: Text(result.title, style: GoogleFonts.lato()),
                    subtitle: Text(result.snippet, style: GoogleFonts.lato()),
                    onTap: () => _openUrl(result.url),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
