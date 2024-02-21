import 'dart:math';
import 'package:flutter/material.dart';
import 'package:news_app/models/topheadlines_models.dart';
import 'package:news_app/providers/NewsByChannelSources_providers.dart';
import 'package:news_app/providers/channelSources_providers.dart';
import 'package:news_app/views/widgets/story_view.dart';
import 'package:status_view/status_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

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
                        NewschannelWiseController.fetchNewsByChannelArticles(
                            channel_sources?.id);
                        List<Articles?> list = await NewschannelWiseController
                            .fetchNewsByChannelArticles(channel_sources?.id);
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
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ));
                }),
          );
        },
        loading: () => ShimmerLoadingEffect(),
        error: (error, stackTrace) => Text('Error: $error'));
  }
}

class ShimmerLoadingEffect extends StatelessWidget {
  const ShimmerLoadingEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8, // Adjust the number of shimmer placeholders as needed
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 80, // Adjust width as needed
                height: 80, // Adjust height as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45.0),
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
