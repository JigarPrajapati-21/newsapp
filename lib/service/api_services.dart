import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/article_model.dart';
import '../utils/strings.dart';
import 'api_connection.dart';


class ApiService {


  static Future<List<Article>> fetchBreakingNewsArticles() async {
    List<Article> breakingNewsList = [];

    try {
      final response = await http.get(Uri.parse(Api.breakingNews));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData["status"] == "success") {
          final List<dynamic> data = responseData['results'];
          breakingNewsList = data.map((json) => Article.fromJson(json)).toList();
          // print(breakingNewsList);
        } else {
          print("status: false, not success");
        }
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      throw Exception('Error fetching articles: $error');
    }
    return breakingNewsList;
  }



  static Future<List<Article>> fetchCategoryNewsArticles(String selectedCategory) async {
    List<Article> breakingNewsList = [];
    String all= "https://newsdata.io/api/1/news?apikey=${Strings.key}&q=all&language=en,gu,hi ";
    String categoryApi="https://newsdata.io/api/1/news?apikey=${Strings.key}&language=en,gu,hi&category=$selectedCategory";
    String catApi= selectedCategory == "All"? all:categoryApi;

    try {
      final response = await http.get(Uri.parse(catApi));
print("::::::::::::::::: ${response.statusCode}");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData["status"] == "success") {
          final List<dynamic> data = responseData['results'];
          breakingNewsList = data.map((json) => Article.fromJson(json)).toList();
          // print(breakingNewsList);
          print("___________________________");
        } else {
          print("status: false, not success");
        }
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      throw Exception('Error fetching articles: $error');
    }
    return breakingNewsList;
  }



  // static Future<List<Article>> searchNews(searchString) async {
  //   List<Article> searchNewsList = [];
  //
  //   try {
  //     final response = await http.get(Uri.parse("https://newsdata.io/api/1/news?apikey=${Strings.key}&q=$searchString"));
  //
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       if (responseData["status"] == "success") {
  //         final List<dynamic> data = responseData['results'];
  //
  //         searchNewsList = data.map((json) => Article.fromJson(json)).toList();
  //         // print(searchNewsList);
  //       } else {
  //         print("status: false, not success");
  //       }
  //     } else {
  //       throw Exception('Failed to load articles');
  //     }
  //   } catch (error) {
  //     throw Exception('Error fetching articles: $error');
  //   }
  //   return searchNewsList;
  // }



}
