import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:news_app/constants/api.dart';
import 'package:news_app/models/topheadlines_models.dart';

class channelSourceController{

   Stream<List<Source?>> fetchChannelSources() async* {
          try {
            final url = Uri.parse(ApiUrl.Base_URL+ApiUrl.channelSources);
            final response = await http.get(url);
            
            
            if(response.statusCode == 200)
            {
              List <dynamic> data = json.decode(response.body)['sources'];
              List <Source> channel_Sources = data.map((sources) => Source.fromJson(sources)).toList();
              yield channel_Sources;

            }
            else
            {
              log("Failed LoL");
              throw Exception("Fail To Load Data");
            }
          } catch (e) {
            log(e.toString());
            yield [];
          }
   }
}