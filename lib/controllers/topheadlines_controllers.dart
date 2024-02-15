
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app/constants/api.dart';
import 'package:news_app/models/topheadlines_models.dart';

class TopHeadlinesController{

   Stream<List<Articles?>> fetchTopHeadlinesArticles() async* {
          try {
            final url = Uri.parse(ApiUrl.Base_URL+ApiUrl.Top_headLines);
            final response = await http.get(url);
            
            if(response.statusCode == 200)
            {
              List <dynamic> data = json.decode(response.body)['articles'];
              List <Articles> TopArticles = data.map((article) => Articles.fromJson(article)).toList();
              yield TopArticles;

            }
            else
            {
              throw Exception("Fail To Load Data");
            }
          } catch (e) {
            log(e.toString());
            yield [];
          }
   }
}