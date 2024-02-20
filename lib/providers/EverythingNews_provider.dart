import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/controllers/everything_controllers.dart';
import 'package:news_app/models/topheadlines_models.dart';

  final Everythingnewsprovider = Provider((ref) => EverthingNews(defaultSearch: 'bitcoin', defaultToDate: '', defaultFromDate: '', defaultsortBy: ''));

final ArticleNewsProvider = StreamProvider<List<Articles?>>((ref) {
  final controller = ref.watch(Everythingnewsprovider);
  return controller.articlesStream;
});
