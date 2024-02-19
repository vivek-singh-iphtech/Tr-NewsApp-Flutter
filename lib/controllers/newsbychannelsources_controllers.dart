import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/api.dart';
import 'package:news_app/models/topheadlines_models.dart';

class NewsByChannelSources {

  final StreamController<List<Articles?>> _articlesController =
      StreamController<List<Articles?>>();

  Stream<List<Articles?>> get articlesStream => _articlesController.stream;

  // Method to fetch Channel Wise top headlines articles
  bool fetchNewsByChannelArticles(String? id) {
    fetchArticles(id).then((articles) {
      _articlesController.add(articles);
      return true;
    }).catchError((error) {
      log('Error fetching articles: $error');
      _articlesController.addError(error);
      return false;
    });
      return false;
  }

   Future<List<Articles?>> fetchArticles(String? id) async {
    try {
      final url =
          Uri.parse('${ApiUrl.Base_URL}${ApiUrl.NewsByChannelSources}$id');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['articles'];
        List<Articles?> topChannelWiseArticles =
            data.map((article) => Articles.fromJson(article)).toList();
        return topChannelWiseArticles;
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