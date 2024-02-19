import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/controllers/channelSources_controllers.dart';
import 'package:news_app/models/topheadlines_models.dart';

// creating top headline controller instance by the provider newsprovider with ref
final sourceprovider = Provider((ref) => channelSourceController());


// ArticleProvider is stream Provider which gives stream of values with ref.watch to get instance of top headline controller
final ChannelSource = StreamProvider<List<Source?>>((ref) {
  final sources = ref.watch(sourceprovider);
  return sources.fetchChannelSources(); // use to get the controller data via stream provider
});
