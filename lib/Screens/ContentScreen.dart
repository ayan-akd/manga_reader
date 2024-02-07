import 'package:flutter/material.dart';
import 'package:manga/Constants/Constants.dart';
import 'package:manga/Screens/HomeScreen.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:http/http.dart' as http;

class ContentScreen extends StatefulWidget {
  final String chapterLink;
  final String chapterNumber;
  const ContentScreen(
      {super.key, required this.chapterLink, required this.chapterNumber});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late List<Map<String, dynamic>> contentPages;
  bool dataFetched = false;
  void getContent() async {
    final webScraper = WebScraper(Constants.baseUrl);
    // String tempRoute =
    //     "/manga/The-Heavenly-Demon-Can%2527t-Live-a-Normal-Life/chapter/1-VA48";

    if (await webScraper.loadWebPage(widget.chapterLink)) {
      contentPages = webScraper.getElement(
        'section.page-in.content-wrap > center > div > img',
        ['src'],
      );
      setState(() {
        dataFetched = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chapter ${widget.chapterNumber}'),
        centerTitle: true,
        backgroundColor: Constants.darkGray,
      ),
      body: dataFetched
          ? ListView.builder(
              itemCount: contentPages.length,
              itemBuilder: (context, index) {
                return Image.network(contentPages[index]['attributes']['src']);
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
