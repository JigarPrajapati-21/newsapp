
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/all_news_controller.dart';
import '../../controller/news_controller.dart';
import '../detailnews.dart';
import '../filter_modal_bottom_sheet.dart';

class AllNewsArticleScreen extends StatelessWidget {
  final AllNewsController controller = Get.put(AllNewsController());
  final NewsController newsController = Get.put(NewsController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "News Articles",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            elevation: 3,
            showDragHandle: true,
            enableDrag: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
              ),
            ),
            builder: (BuildContext context) {
              return FilterModalBottomSheet();
            },
          );
        },
        backgroundColor: Colors.blue.shade900,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.filter_alt,
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (controller.newsArticles.isEmpty) {
          return const Center(
            child: Text(
              "No news found",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: controller.newsArticles.length,
          itemBuilder: (context, index) {
            final article = controller.newsArticles[index];
            return _buildNewsCard(context, article,index);
          },
        );
      }),
    );
  }

  Widget _buildNewsCard(BuildContext context, article,index) {
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
          category: article.category!
              .join(', ')
              .toString(),
          link: article.link,
        ),
        ),);

      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        article.imageUrl != null && article.imageUrl!.isNotEmpty
                            ? article.imageUrl!
                            : 'https://via.placeholder.com/400',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child:  Obx(
                        () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: IconButton(
                          onPressed: () {
                            if (newsController.savedArticles
                                .contains(article)) {
                              newsController.removeArticle(
                                  article);
                            } else {
                              newsController.saveArticle(
                                  article);
                            }
                          },
                          icon: Icon(
                            Icons.mark_chat_unread_sharp,
                            size: 20,
                            color: newsController
                                .savedArticles
                                .contains(article)
                                ? Colors.red
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    article.description ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      if (article.category != null && article.category!.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            article.category!.join(', '),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.watch_later,
                            size: 20,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              article.pubDate.toString(),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

