import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/news_controller.dart';
import '../model/article_model.dart';
import '../service/api_services.dart';
import 'detailnews.dart';

class ViewAllBreakingNewsScreen extends StatefulWidget {
  const ViewAllBreakingNewsScreen({super.key});

  @override
  State<ViewAllBreakingNewsScreen> createState() => _ViewAllBreakingNewsScreenState();
}

class _ViewAllBreakingNewsScreenState extends State<ViewAllBreakingNewsScreen> {
  final NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        // backgroundColor: Colors.blue.shade900,
        title: Text(
          "Breaking News",
          style: TextStyle(color: Colors.white, letterSpacing: 1),
        ),
        // centerTitle: true,
        // foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: ApiService.fetchBreakingNewsArticles(),
          builder: (context, AsyncSnapshot<List<Article>> dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        
            if (dataSnapShot.hasError || dataSnapShot.data == null || dataSnapShot.data!.isEmpty) {
              return const Center(
                child: Text("No breaking news found"),
              );
            }
        
            return ListView.builder(
              itemCount: dataSnapShot.data!.length,
              itemBuilder: (context, index) {
                Article? eachArticleData = dataSnapShot.data?[index];
        
                if (eachArticleData == null) {
                  return const SizedBox.shrink(); // In case the article is null
                }
        
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Detailnews(
                          title: eachArticleData.title ?? "No Title",
                          imageUrl: eachArticleData.imageUrl ?? 'https://via.placeholder.com/400',
                          description: eachArticleData.description ?? "No Description",
                          sourceName: eachArticleData.sourceName ?? "Unknown Source",
                          sourceIcon: eachArticleData.sourceIcon ?? "",
                          pubDate: eachArticleData.pubDate ?? "",
                          category: eachArticleData.category?.join(', ') ?? "Unknown Category",
                          link: eachArticleData.link,
                        ),
                      ),
                    );
                  },
                  child: Card(
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
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    eachArticleData.imageUrl != null && eachArticleData.imageUrl!.isNotEmpty
                                        ? eachArticleData.imageUrl!
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
                              child: Obx(
                                    () => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
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
                                        size: 20,
                                        color: newsController.savedArticles.contains(eachArticleData)
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
