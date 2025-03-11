import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../t_to_s.dart';
import 'article_webview_screen.dart';

class Detailnews extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final String sourceName;
  final String sourceIcon;
  final String pubDate;
  final String category;
  final String link;

  const Detailnews(
      {super.key,
        required this.title,
        required this.imageUrl,
        required this.description,
        required this.sourceName,
        required this.sourceIcon,
        required this.pubDate,
        required this.category,
        required this.link});

  @override
  Widget build(BuildContext context) {
    String textToSpeechString = title + description;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade900,
      ),
      bottomSheet: BottomAppBar(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextToSpeechButton(
                text: textToSpeechString,
              ),

              ElevatedButton.icon(
                onPressed: () {
                  Get.to(WebViewScreen(
                    url: link,
                    title: title,
                  ));
                },

                style: ElevatedButton.styleFrom(
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.white,
                ),

                icon: Icon(Icons.link),
                label: Text(
                  "Open Website",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Image Section
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Category and Publication Date
              Row(
                children: [
                  Card(
                    color: Colors.blue.shade900,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Spacer(),
                  Icon(Icons.calendar_today, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(
                    pubDate,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Source Information
              Card(
                elevation: 0,
                color: Colors.blue.shade50,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue.shade900),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.network(
                            sourceIcon,
                            height: 40,
                            width: 40,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.rectangle,
                                size: 40,
                                color: Colors.grey,
                              );
                            },
                          ),
                          const SizedBox(width: 12),
                          Text(
                            sourceName,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.verified,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Description
              Text(
                description.isNotEmpty ? description : "Description not available.",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 150),

            ],
          ),
        ),
      ),
    );
  }
}