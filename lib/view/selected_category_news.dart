import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/article_model.dart';
import '../controller/news_controller.dart';
import '../service/api_services.dart';
import 'detailnews.dart';

class SelectedCategoryNews extends StatefulWidget {
  SelectedCategoryNews({super.key});

  @override
  State<SelectedCategoryNews> createState() => _SelectedCategoryNewsState();
}

class _SelectedCategoryNewsState extends State<SelectedCategoryNews> {
  String title = Get.arguments;
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "$title News Articles",
          style: const TextStyle(
            color: Colors.white,
            letterSpacing: 1,
            fontWeight: FontWeight.w600,
          ),
        ),
        // centerTitle: true,
        // backgroundColor: Colors.blue.shade900,
        // foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: ApiService.fetchCategoryNewsArticles(title),
          builder: (context, AsyncSnapshot<List<Article>> dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (dataSnapShot.data == null || dataSnapShot.data!.isEmpty) {
              return const Center(
                child: Text(
                  "No news found",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: dataSnapShot.data!.length,
              itemBuilder: (context, index) {
                Article eachArticleData = dataSnapShot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detailnews(
                          title: eachArticleData.title,
                          imageUrl: eachArticleData.imageUrl.toString(),
                          description: eachArticleData.description.toString(),
                          sourceName: eachArticleData.sourceName.toString(),
                          sourceIcon: eachArticleData.sourceIcon.toString(),
                          pubDate: eachArticleData.pubDate.toString(),
                          category: eachArticleData.category!.join(', ').toString(), link: eachArticleData.link,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    // color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    elevation: 5,
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
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    eachArticleData.imageUrl!.isNotEmpty
                                        ? eachArticleData.imageUrl.toString()
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
                                      if (newsController.savedArticles.contains(eachArticleData)) {
                                        newsController.removeArticle(eachArticleData);
                                      } else {
                                        newsController.saveArticle(eachArticleData);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.bookmark,
                                      color: newsController.savedArticles.contains(eachArticleData)
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
                                eachArticleData.title ?? "No Title",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,

                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.bold
                                ),



                              ),
                              const SizedBox(height: 6),
                              Text(
                                eachArticleData.description ?? '',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,

                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontSize: 16,
                                ),

                              ),
                              const SizedBox(height: 10),
                              if (eachArticleData.category != null && eachArticleData.category!.isNotEmpty)
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
                                        eachArticleData.category!.join(', ').toString(),
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
                                          eachArticleData.pubDate ?? '',
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
              },
            );
          },
        ),
      ),
    );
  }
}
