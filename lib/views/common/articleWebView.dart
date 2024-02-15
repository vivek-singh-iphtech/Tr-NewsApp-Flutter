import 'package:flutter/material.dart';
import 'package:news_app/models/topheadlines_models.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:share_plus/share_plus.dart';

class ArticleWebView extends StatefulWidget {
  final Articles? article;
  const ArticleWebView(this.article);

  @override
  _ArticleWebViewState createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<ArticleWebView> {
  bool isWebViewLoaded = false;
  late WebViewController controller;

  String text = 'Check out this news In News App:'; 

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (String url) {
            if (mounted) { // Check if the widget is still mounted before calling setState
          setState(() {
            isWebViewLoaded = true;
          });
        }
    
        },
      ))
      ..loadRequest(Uri.parse(widget.article?.url ?? 'https://flutter.dev'));

    text = "Check out this news In News App: ${widget.article?.url}";
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255,250, 241, 237),
        title: Text(
          widget.article?.title ?? 'Title only',
          style: const TextStyle(
            fontWeight: FontWeight.normal,
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red, 
        onPressed: () {
          _onShare(context);
        },
         shape: const RoundedRectangleBorder( // <= Change BeveledRectangleBorder to RoundedRectangularBorder
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30.0),
      topRight: Radius.circular(30.0),
      bottomLeft: Radius.circular(30.0),
      bottomRight: Radius.circular(30.0),
    ),
  ),
        child: const Icon(
          Icons.share,
          color: Colors.white,
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            if (!isWebViewLoaded)
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.white, // Adjust as needed
                ),
              ),
          ],
        ),
      ),
    );
  }
  void _onShare(BuildContext context) async { 
    final box = context.findRenderObject() as RenderBox?; 
    await Share.share(text, 
        subject: '', 
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size); 
  } 
    
}
