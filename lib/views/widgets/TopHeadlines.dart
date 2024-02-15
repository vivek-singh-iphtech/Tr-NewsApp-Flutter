import 'dart:ui';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/topheadlines_providers.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TopHeadlines extends ConsumerWidget {
  const TopHeadlines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Topheadlines = ref.watch(ArticleProvider);
    return Topheadlines.when(
        data: (articles) {
          return Container(
            height: 205,
            
            child: ListView.builder(
                itemCount: articles.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final article = articles[index];
            
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 300,
                      height: 190,
                      
                      child: Card(
                        elevation: 2,
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Stack(
                            children: [
                              // Image
                              if (article != null && article.urlToImage != null)
                                Opacity(
                                  opacity: 0.55,
                                  child: CachedNetworkImage(
                                    imageUrl: article.urlToImage!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                )
                              else
                                Opacity(
                                  opacity: 0.55,
                                  child: Image.asset(
                                    'assets/images/headlineImage.jpeg', // Provide a placeholder image asset
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              // Overlay text
                             Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                              
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                 article?.title ?? 'No Title',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 237, 237, 237),
                                  fontSize: 15,
                                  
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
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
    return Container(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5, // Adjust the number of shimmer placeholders as needed
        itemBuilder: (context, index) {
          return SizedBox(
            width: 300,
            height: 205,
            child: Card(
               elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
