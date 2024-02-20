import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/providers/NewsByChannelSources_providers.dart';
import 'package:news_app/views/common/articleWebView.dart';
import 'package:news_app/views/widgets/channelStories.dart';
import 'package:story_view/story_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/models/topheadlines_models.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryViewPage extends StatefulWidget {
  final Source? channelSource;

  StoryViewPage({
    Key? key,
    this.channelSource,
  }) : super(key: key);

  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final storyController = StoryController();
  List<StoryItem> storyItems = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryViewPageContent(
        channelSource: widget.channelSource,
        storyItems: storyItems,
        storyController: storyController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class StoryViewPageContent extends ConsumerWidget {
  final Source? channelSource;
  final StoryController storyController;
  final List<StoryItem> storyItems;

  StoryViewPageContent({
    Key? key,
    required this.channelSource,
    required this.storyController,
    required this.storyItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, watch, _) {
      final articlesAsyncValue = ref.watch(NewsChannelWiseArticleProvider);

      return articlesAsyncValue.when(
        data: (articles) {
          if (storyItems.isEmpty) {
            storyItems.addAll(
              articles.map((article) {
                return StoryItem.inlineImage(
                    url: article?.urlToImage ?? 'No resposne',
                    controller: storyController,
                    caption: Text(
                      article?.title ?? 'no',
                      style: TextStyle(
                          fontSize: 45,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ));
                    
                    
              }),
            );
          }
           return StoryView(
                progressPosition: ProgressPosition.top,
                controller: storyController,
                storyItems: storyItems,
                onVerticalSwipeComplete: (direction) {
                  if (direction == Direction.up) {
                    Navigator.pop(context);
                  }
                });
        
        },
        loading: () => CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
      );
    });
  }

  void navigateToWebView(BuildContext context, Articles article) {
    if (kIsWeb) {
      launch(article.url!);
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ArticleWebView(article)));
    }
  }
}
