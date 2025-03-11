

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controller/news_controller.dart';
import 'package:flutter/material.dart';

import '../detailnews.dart';

class SavedArticlesScreen extends StatelessWidget {
  final NewsController newsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text(
          "Saved Articles",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade900,
        actions: [
          IconButton(onPressed: newsController.removeAllArticles,
              icon: const Icon(Icons.delete),
            color: Colors.red,
          )
        ],
      ),
      body: newsController.savedArticles.isEmpty
          ? const Center(
              child: Text(
                "No Saved Articles...",
                style: TextStyle(fontSize: 16),
              ),
            )
          : Obx(() {
              return ListView.builder(
                itemCount: newsController.savedArticles.length,
                itemBuilder: (context, index) {
                  final article = newsController.savedArticles[index];

                  return GestureDetector(
                    onTap: () {
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
                            category: article.category!.join(', ').toString(),
                            link: article.link,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 130,
                              width: 130,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    article.imageUrl != null &&
                                            article.imageUrl!.isNotEmpty
                                        ? article.imageUrl.toString()
                                        : "https://images.app.goo.gl/UJ2U9tR2mj1k6sH96",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            const SizedBox(
                                width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            article.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.grey.shade300,
                                        child: Center(
                                          child: IconButton(
                                            onPressed: () {
                                              newsController
                                                  .removeArticle(article);
                                            },
                                            icon: const Icon(
                                              Icons.mark_chat_unread_sharp,
                                              size: 16,
                                              color: Colors
                                                  .red,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade900,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      article.category != null &&
                                              article.category!.isNotEmpty
                                          ? article.category!.join(', ')
                                          : "General",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(
                                        Icons.watch_later,
                                        size: 20,
                                        color: Colors.grey,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Text(
                                          article.pubDate != null
                                              ? article.pubDate.toString()
                                              : "Unknown Date",
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
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
              );
            }),
    );
  }
}

