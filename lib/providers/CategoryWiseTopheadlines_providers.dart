import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/controllers/CategoryHeadlines.dart';
import 'package:news_app/models/topheadlines_models.dart';

  final categorynewsprovider = Provider((ref) => CategoryWiseTopHeadlinesController(defaultCategory: 'business'));

final CategoryArticleProvider = StreamProvider<List<Articles?>>((ref) {
  final controller = ref.watch(categorynewsprovider);
  return controller.articlesStream;
});
