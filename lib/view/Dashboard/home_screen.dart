import 'package:flutter/material.dart';
import 'package:newsapp/view/view_all_breaking_news_screen.dart';
import '../../model/article_model.dart';
import '../../controller/news_controller.dart';
import '../../service/api_services.dart';
import '../category_list_screen.dart';
import '../detailnews.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final NewsController newsController = Get.put(NewsController());

  List category = [
    'All',
    'Business',
    'Crime',
    'Domestic',
    'Education',
    'Entertainment',
    'Environment',
    'Food',
    'Health',
    'Lifestyle',
    'Other',
    'Politics',
    'Science',
    'Sports',
    'Technology',
    'Top',
    'Tourism',
    'World'
  ];


  int selectedCategoryIndex = 0; // Default selected index
  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue.shade50,
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Newsify",
          style: TextStyle(letterSpacing: 2),
        ),

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child:
        Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height >
                          MediaQuery.of(context).size.width
                      ? MediaQuery.of(context).size.height / 3
                      : MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade900,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(0)),
                  ),
                ),

              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Welcome! Jigar 👋",

                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16
                      ),


                    ),
                  ),

                  const SizedBox(height: 6),
                   Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      "Discover Breaking News",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),


                  // Breaking news section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text(
                          "Breaking News 🔥",
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ViewAllBreakingNewsScreen(),
                                ));
                          },
                          child:  Text("View All",style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 16,
                          ),
                              ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 5, bottom: 5, right: 0),
                    child: breakingNewsWidget(context),
                  ),
                  const SizedBox(height: 10),

                  //catagory
                  // Category section

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Category News",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(CategoryScreen());
                          },
                          child: Text("View All",
                              style: TextStyle(
                                  // color: Colors.blue.shade900
                                  color: Colors.blue,
                                fontSize: 16
                              )),
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, top: 5, right: 0, bottom: 5),
                    child: SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: category.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategoryIndex =
                                    index; // Update selected index
                                selectedCategory = category[index];
                              });
                            },
                            child: Card(
                              color: selectedCategoryIndex == index
                                  ? Colors
                                      .blue.shade900 // Selected category background color
                                  : Colors.blue
                                      .shade500, // Default background color
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Text(
                                  category[index],
                                  style: const TextStyle(
                                      fontSize: 16, ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListNewsCardWidget(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //---------breakingnewsCardWidget start----------------------------

  Widget breakingNewsWidget(context) {
    return FutureBuilder(
      future: ApiService.fetchBreakingNewsArticles(),
      builder: (context, AsyncSnapshot<List<Article>> dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (dataSnapShot.data == null) {
          return const Center(
            child: Text("no breaking news found"),
          );
        }
        if (dataSnapShot.data!.isNotEmpty) {
          return SizedBox(
            height: MediaQuery.of(context).size.height >
                MediaQuery.of(context).size.width
                ? MediaQuery.of(context).size.width / 1.3
                : MediaQuery.of(context).size.height / 1.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
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
                            category: eachArticleData.category!
                                .join(', ')
                                .toString(),
                            link: eachArticleData.link
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.only(right: 16, bottom: 5),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.height >
                          MediaQuery.of(context).size.width
                          ? MediaQuery.of(context).size.height / 3.3
                          : MediaQuery.of(context).size.width / 3.5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 140,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(eachArticleData
                                            .imageUrl
                                            .toString() !=
                                            ""
                                            ? eachArticleData.imageUrl
                                            .toString()
                                            : "https://images.app.goo.gl/UJ2U9tR2mj1k6sH96"),
                                        fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  ),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Obx(
                                        () => CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: IconButton(
                                        onPressed: () {
                                          if (newsController.savedArticles
                                              .contains(eachArticleData)) {
                                            newsController
                                                .removeArticle(eachArticleData);
                                          } else {
                                            newsController
                                                .saveArticle(eachArticleData);
                                          }
                                        },
                                        icon: Icon(
                                          Icons.bookmark,
                                          color: newsController.savedArticles
                                              .contains(eachArticleData)
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
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                eachArticleData.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold
                                ),
                              ),
                            ),

                            // Responsive source name section
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        eachArticleData.sourceIcon.toString()),
                                    radius: 12,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      // "aaaaaaaaaaaaa sssssssss dddddddddd eeeeeeee fffffffffffaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                                      eachArticleData.sourceName.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                          fontSize: 14, fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 6),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Responsive category section
                                  Card(
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    color: Colors.blue.shade900,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 6),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          eachArticleData.category!
                                              .join(', ')
                                              .toString(),
                                          style: const TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
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
                                      const SizedBox(width: 4),
                                      Flexible(
                                        child: Text(
                                          eachArticleData.pubDate.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
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
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(
            child: Text("Empty, no data"),
          );
        }
      },
    );
  }

//---------breakingnewsCardWidget end----------------------------

//-----------------------------------------------------------------------

  //---------ListNewsCardWidget start----------------------------

   Widget ListNewsCardWidget(context) {
    print("SSSSSSSSSSSSSSSSSSSS");
    return FutureBuilder(
      future: ApiService.fetchCategoryNewsArticles(selectedCategory),
      builder: (context, AsyncSnapshot<List<Article>> dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          print("AAAAAAAAAAAAA");
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (dataSnapShot.data == null) {
          print("EEEEEEEEEEEEEEE");
          print(dataSnapShot.data);
          print(dataSnapShot.error);
          return const Center(
            child: Text("no  news found"),
          );
        }
        if (dataSnapShot.data!.isNotEmpty) {
          print("WWWWWWWWWW");
          return SizedBox(
            height: 800,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 5,
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
                          category: eachArticleData.category!
                              .join(', ')
                              .toString(), link: eachArticleData.link,
                        ),
                      ),
                    );

                  },
                  child: Card(
                    // color: Colors.white,
                    elevation: 5,
                    // borderOnForeground: true,
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
                                image: NetworkImage(eachArticleData.imageUrl
                                            .toString() !=
                                        ""
                                    ? eachArticleData.imageUrl.toString()
                                    : "https://images.app.goo.gl/UJ2U9tR2mj1k6sH96"),
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
                                          // "Bring Me The Horizon talk headlining Reading and Leading...",
                                          // "Elon Musk's team may access US Education Department systems, judge rules",
                                          eachArticleData.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                              fontSize: 16, fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),


                                    Positioned(
                                      top: 5,
                                      right: 5,
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
                                    const Icon(
                                      Icons.watch_later,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6),
                                      child: Text(
                                          // "2 Hours ago",
                                          eachArticleData.pubDate.toString(),
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(),
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
            ),
          );
        } else {
          return const Center(
            child: Text("Empty, no data"),
          );
        }
      },
    );
  }

//---------ListNewsCardWidget end----------------------------
}







