import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news_app/models/topheadlines_models.dart';
import 'package:news_app/providers/NewsByChannelSources_providers.dart';
import 'package:news_app/providers/channelSources_providers.dart';
import 'package:news_app/views/widgets/story_view.dart';
import 'package:status_view/status_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChannelStories extends ConsumerWidget {
  const ChannelStories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sources = ref.watch(ChannelSource);

    return sources.when(
        data: (source) {
          return Container(
            height: 120,
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: source.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final channel_sources = source[index];

                  return GestureDetector(
                      onTap: () async {
                        final NewschannelWiseController =
                            ref.read(ChannelWiseNewsProvider);
                        bool data = NewschannelWiseController
                            .fetchNewsByChannelArticles(channel_sources?.id);
                        List<Articles?> list =
                            await NewschannelWiseController.fetchArticles(
                                'abc-news');
                        if (list.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  StoryViewPage(channelSource: channel_sources),
                            ),
                          );
                        }
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: StatusView(
                              radius: 40,
                              spacing: 15,
                              strokeWidth: 2,
                              indexOfSeenStatus: 2,
                              numberOfStatus: 5,
                              padding: 4,
                              centerImageUrl: "https://picsum.photos/200/300",
                              seenColor: Colors.grey,
                              unSeenColor: Colors.red,
                            ),
                          ),
                          Text(
                            channel_sources?.name ?? 'No Title',
                            style: TextStyle(
                              color: const Color.fromARGB(255, 23, 19, 19),
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ));
                }),
          );
        },
        loading: () => CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'));
  }
}
