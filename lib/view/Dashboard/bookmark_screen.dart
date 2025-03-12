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
      // backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: const Text(
          "Saved Articles",
          // style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        // foregroundColor: Colors.white,

        actions: [
          IconButton(onPressed: newsController.removeAllArticles,
              icon: Icon(Icons.delete),
            color: Colors.red,
          )
        ],
      ),
      body: newsController.savedArticles.isEmpty
          ? Center(
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
                            category: article.category!.join(', ').toString(), link: article.link,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      // color: Colors.white,
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
                                        : "https://images.app.goo.gl/UJ2U9tR2mj1k6sH96", // Fallback image
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                            const SizedBox(
                                width: 10), // Add space between image and text
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

                                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                                fontSize: 16, fontWeight: FontWeight.bold
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
                                              // Remove the article when the icon is pressed
                                              newsController
                                                  .removeArticle(article);
                                            },
                                            icon: const Icon(
                                              Icons.bookmark,
                                              size: 16,
                                              color: Colors
                                                  .red, // Change the icon color to red
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    color: Colors.blue.shade900,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text(
                                          article.category!.join(', ').toString(),
                                          style: const TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 12,
                                            // color: Colors.white,
                                          ),
                                        ),
                                      ),
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
                                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                              fontSize: 14
                                          ),
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

