// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:news_app/constants/api.dart';
import 'package:news_app/models/topheadlines_models.dart';

class EverthingNews {

  final StreamController<List<Articles?>> _articlesController =
      StreamController<List<Articles?>>();

      final String defaultSearch;
      final String defaultToDate;
      final String defaultFromDate;
      final String defaultsortBy;

  EverthingNews({
    required this.defaultSearch,
    required this.defaultToDate,
    required this.defaultFromDate,
    required this.defaultsortBy,
  }) {
    fetchEveryNews(defaultSearch,defaultToDate,defaultFromDate,defaultsortBy);
  }


  Stream<List<Articles?>> get articlesStream => _articlesController.stream;

 
  // Helper method to fetch articles from the API
  Future<List<Articles?>> fetchEveryNews(String? query, String? ToDate, String? FromDate, String? sortBy) async {
    try {
      final url =
          Uri.parse('${ApiUrl.Base_URL}${ApiUrl.EveryNews}$query${ApiUrl.ToDate}$ToDate${ApiUrl.FromDate}$FromDate${ApiUrl.sortBy}$sortBy');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['articles'];
        List<Articles?> EveryNewsArticle =
            data.map((article) => Articles.fromJson(article)).toList();
            _articlesController.add(EveryNewsArticle);
        return EveryNewsArticle;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
       _articlesController.addError(e);
       print('${ApiUrl.Base_URL}${ApiUrl.EveryNews}$query${ApiUrl.ToDate}$ToDate${ApiUrl.FromDate}$FromDate${ApiUrl.sortBy}$sortBy');
      log(e.toString());
      throw e;
    }
  }

  void dispose() {
    _articlesController.close();
  }
}
