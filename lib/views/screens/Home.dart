import 'package:flutter/material.dart';
import 'package:news_app/controllers/CategoryHeadlines.dart';
import 'package:news_app/controllers/topheadlines_controllers.dart';
import 'package:news_app/views/screens/search.dart';
import 'package:news_app/views/widgets/TopHeadlines.dart';
import 'package:news_app/views/widgets/categoryHeadlines.dart';
import 'package:news_app/views/widgets/categoryList.dart';
import 'package:news_app/views/widgets/channelStories.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final CategoryWiseTopHeadlinesController cat = CategoryWiseTopHeadlinesController();

  // @override
  // void initState()
  // {
  //   cat.fetchCategoryWiseTopHeadlinesArticles('business');
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'News Today',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Quick Reads',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: ChannelStories()),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 12.0, top: 10.0),
                child: Row(
                  children: [
                    Text(
                      'Top News',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Search()));
                      },
                      child: Text(
                        'See All',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 121, 121, 121)),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: TopHeadlines(),
              ),
              CategoryHeadlines()
            ],
          ),
        ),
      ),
    );
  }
}
