import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/constants/api.dart';
import 'package:news_app/models/topheadlines_models.dart';

class CategoryWiseTopHeadlinesController {
  final StreamController<List<Articles?>> _articlesController =
      StreamController<List<Articles?>>();

  final String defaultCategory;

  CategoryWiseTopHeadlinesController({required this.defaultCategory}) {
    fetchCategoryWiseTopHeadlinesArticles(defaultCategory);
  }

  Stream<List<Articles?>> get articlesStream => _articlesController.stream;

  // Method to fetch category-wise top headlines articles
  void fetchCategoryWiseTopHeadlinesArticles(String? category) {
    _fetchArticles(category).then((articles) {
      _articlesController.add(articles);
    }).catchError((error) {
      log('Error fetching articles: $error');
      _articlesController.addError(error);
    });
  }

  // Helper method to fetch articles from the API
  Future<List<Articles?>> _fetchArticles(String? category) async {
    try {
      final url =
          Uri.parse('${ApiUrl.Base_URL}${ApiUrl.categoryHeadline}$category');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['articles'];
        List<Articles?> topCategoryWiseArticles =
            data.map((article) => Articles.fromJson(article)).toList();
        return topCategoryWiseArticles;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      log(e.toString());
      throw e;
    }
  }

  void dispose() {
    _articlesController.close();
  }
}
