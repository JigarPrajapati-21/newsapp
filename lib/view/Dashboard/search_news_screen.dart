
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../model/article_model.dart';
import '../../utils/strings.dart';
import '../detailnews.dart';

class SearchNewsScreen extends StatefulWidget {
  @override
  _SearchNewsScreenState createState() => _SearchNewsScreenState();
}

class _SearchNewsScreenState extends State<SearchNewsScreen> {
  List<Article> _articles = [];
  bool _isLoading = false;
  String _errorMessage = '';
  final TextEditingController _searchController = TextEditingController();

  Future<void> _searchNews(String searchString) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _articles = [];
    });

    try {
      final response = await http.get(Uri.parse(
          "https://newsdata.io/api/1/news?apikey=${Strings.key}&q=$searchString"));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData["status"] == "success") {
          final List<dynamic> data = responseData['results'];
          _articles = data.map((json) => Article.fromJson(json)).toList();
        } else {
          setState(() {
            _errorMessage = "No results found.";
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Failed to load articles';
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'Error fetching articles: $error';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text('Search News'),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                labelText: 'Search',
                labelStyle: TextStyle(color: Colors.grey[700]),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.indigo),
                  onPressed: () {
                    _searchNews(_searchController.text);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.indigo),
                ),
              ),
              onSubmitted: (value) {
                _searchNews(value);
              },
            ),
            const SizedBox(height: 18),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
                ),
              ),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Expanded(
              child: ListView.separated(
                itemCount: _articles.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final article = _articles[index];
                  return Card(
                    elevation: 3,
                    // color: Colors.blue.shade50,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: InkWell( // Use InkWell for tap effect
                      onTap: () {
                        print("Article link: ${article.link}");


                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detailnews(
                              title: article.title,
                              imageUrl: article.imageUrl.toString(),
                              description: article.description.toString(),
                              sourceName: article.sourceName.toString(),
                              sourceIcon: article.sourceIcon.toString(),
                              pubDate: article.pubDate.toString(),
                              category: article.category!
                                  .join(', ')
                                  .toString(),
                              link: article.link,
                            ),
                          ),);



                      },
                      borderRadius: BorderRadius.circular(12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            article.imageUrl != null && article.imageUrl!.isNotEmpty
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                article.imageUrl!,
                                width: 100,
                                height: 120,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported),
                              ),
                            )
                                : const Icon(Icons.image_not_supported, size: 50),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[800]),
                                  ),
                                  const SizedBox(height: 8),
                                  if (article.description != null)
                                    Text(
                                      article.description!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  const SizedBox(height: 8),
                                  if (article.pubDate != null)
                                    Text(
                                      article.pubDate!,
                                      style: TextStyle(
                                          color: Colors.grey[600], fontSize: 12),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
