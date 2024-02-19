import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/controllers/newsbychannelsources_controllers.dart';
import 'package:news_app/models/topheadlines_models.dart';

  final ChannelWiseNewsProvider = Provider((ref) => NewsByChannelSources());

final NewsChannelWiseArticleProvider = StreamProvider<List<Articles?>>((ref) {
  final controller = ref.watch(ChannelWiseNewsProvider);
  return controller.articlesStream;
});
