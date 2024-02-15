import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/controllers/topheadlines_controllers.dart';
import 'package:news_app/models/topheadlines_models.dart';

// creating top headline controller instance by the provider newsprovider with ref
final newsprovider = Provider((ref) => TopHeadlinesController());


// ArticleProvider is stream Provider which gives stream of values with ref.watch to get instance of top headline controller
final ArticleProvider = StreamProvider<List<Articles?>>((ref) {
  final Topheadlines = ref.watch(newsprovider);
  return Topheadlines
      .fetchTopHeadlinesArticles(); // use to get the controller data via stream provider
});
