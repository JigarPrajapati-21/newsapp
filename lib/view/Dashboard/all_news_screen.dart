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
      // backgroundColor: Colors.blue.shade50,
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

        // Return a direct widget instead of using ListView.builder inside Obx
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

  // Extract the news card building to a separate method
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
        // color: Colors.white,
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
                  top: 15,
                  right: 15,
                  child: Obx(
                        () => CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          if (newsController.savedArticles.contains(article)) {
                            newsController.removeArticle(article);
                          } else {
                            newsController.saveArticle(article);
                          }
                        },
                        icon: Icon(
                          Icons.bookmark,
                          color: newsController.savedArticles.contains(article)
                              ? Colors.red
                              : Colors.grey,
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
                article.title ?? "No Title",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,

                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 20, fontWeight: FontWeight.bold
                ),
              ),
                  const SizedBox(height: 6),


                  Text(
                    article.description ?? '',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,

                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 16,
                    ),

                  ),


                  const SizedBox(height: 10),

                  if (article.category != null && article.category!.isNotEmpty)
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
                            ),
                          ),
                        ),
                      ),
                    ),




                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [

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
                              article.pubDate ?? '',
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(

                              ),
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
