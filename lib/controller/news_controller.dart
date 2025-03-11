import 'dart:convert';
import 'package:get/get.dart';
import '../model/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsController extends GetxController {
  var savedArticles = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSavedArticles();
  }

  Future<void> _loadSavedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? articleList = prefs.getStringList('savedArticles');

    if (articleList != null) {
      savedArticles.value = articleList
          .map((articleJson) => Article.fromJson(jsonDecode(articleJson)))
          .toList();
    }
  }

  void saveArticle(Article article) async {
    savedArticles.add(article);
    await _saveArticlesToPrefs();
  }

  void removeArticle(Article article) async {
    savedArticles.remove(article);
    await _saveArticlesToPrefs();
  }

  Future<void> _saveArticlesToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> articleList = savedArticles
        .map((article) => jsonEncode(article.toJson()))
        .toList();
    await prefs.setStringList('savedArticles', articleList);
  }

  void removeAllArticles() async {
    savedArticles.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('savedArticles');
  }

}