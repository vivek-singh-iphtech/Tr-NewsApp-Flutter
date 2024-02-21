import 'package:flutter/material.dart';
import 'package:news_app/models/topheadlines_models.dart';
import 'package:news_app/providers/EverythingNews_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/views/common/articleWebView.dart';
import 'package:news_app/views/widgets/filter_popup.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

class Search extends ConsumerWidget {
  Search({Key? key}) : super(key: key);
  String query = 'bitcoin', ToDate = '', FromDate = '', sortBy = '';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: TextField(
          controller: _controller,
          onChanged: (value) {
            query = value; // Update the query on text change
          },
          onSubmitted: (value) {
            // Fetch articles based on the submitted query
            final everydayNews = ref.read(Everythingnewsprovider);
            everydayNews.fetchEveryNews(query, ToDate, FromDate, sortBy);
          },
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FilterPopup(query, ToDate, FromDate,
                        sortBy); // Show the FilterDialog
                  },
                );
              },
              icon: Icon(
                Icons.filter_list,
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Consumer(
                  builder: (context, watch, _) {
                    final articlesAsyncValue = ref.watch(ArticleNewsProvider);
                    return articlesAsyncValue.when(
                      data: (articles) {
                        // Display your articles here

                        return Container(
                          height: MediaQuery.of(context).size.height * 0.88,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemExtent: 250,
                              itemCount: articles.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                final article = articles[index];

                                return GestureDetector(
                                  onTap: () {
                                    navigateToWebView(context, article!);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 300,
                                      height: 205,
                                      child: Card(
                                        elevation: 2,
                                        color: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          child: Stack(
                                            children: [
                                              // Image
                                              if (article != null &&
                                                  article.urlToImage != null &&
                                                  article
                                                      .urlToImage!.isNotEmpty)
                                                Opacity(
                                                  opacity: 0.55,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        article.urlToImage!,
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(15.0),
                                                      bottomRight:
                                                          Radius.circular(15.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 3.0),
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        6),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .transparent,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 0.8),
                                                            ),
                                                            child: Text(
                                                              article?.source
                                                                      ?.name ??
                                                                  'No Source',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 9,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          article?.title ??
                                                              'No Title',
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    237,
                                                                    237,
                                                                    237),
                                                            fontSize: 15,
                                                          ),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      },
                      loading: () => ShimmerLoadingEffect(),
                      error: (error, stackTrace) => Text('Error: $error'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

class ShimmerLoadingEffect extends StatelessWidget {
  const ShimmerLoadingEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.88,
         child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10, // Adjust the number of shimmer placeholders as needed
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
      ),);
  }
}
