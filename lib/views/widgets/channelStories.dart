import 'package:flutter/material.dart';
import  'package:stories_for_flutter/stories_for_flutter.dart';

class ChannelStories extends StatefulWidget {
  
  const ChannelStories({ Key? key}) : super(key: key);

  @override
  _ChannelStoriesState createState() => _ChannelStoriesState();
}

class _ChannelStoriesState extends State<ChannelStories> {
 
  @override
  Widget build(BuildContext context) {
    return Stories(
      autoPlayDuration: Duration(seconds: 3),
    displayProgress: true,
    storyItemList: [
      // First group of stories
      StoryItem(
          name: "First Story",
          thumbnail: NetworkImage(
            "https://assets.materialup.com/uploads/82eae29e-33b7-4ff7-be10-df432402b2b6/preview",
          ),
          stories: [
            // First story
            Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "https://wallpaperaccess.com/full/16568.png",
                    ),
                  ),
                ),
              ),
            ),
            // Second story in first group
            Scaffold(
              body: Center(
                child: Text(
                  "Second story in first group !",
                  style: TextStyle(
                    color: Color(0xff777777),
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ]),
      // Second story group
      StoryItem(
        name: "2nd",
        thumbnail: NetworkImage(
          "https://www.shareicon.net/data/512x512/2017/03/29/881758_cup_512x512.png",
        ),
        stories: [
          Scaffold(
            body: Center(
              child: Text(
                "That's it, Folks !",
                style: TextStyle(
                  color: Color(0xff777777),
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
  }
}