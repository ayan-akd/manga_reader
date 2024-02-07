import 'package:flutter/material.dart';
import 'package:manga/Screens/HomeScreen.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:http/http.dart' as http;

class ContentScreen extends StatefulWidget {
  const ContentScreen({super.key});

  @override
  State<ContentScreen> createState() => _ContentScreenState();
}

class _ContentScreenState extends State<ContentScreen> {
  late List<Map<String, dynamic>> contentPages;
  bool dataFetched = false;
  void getContent() async {
    // final webScraper = WebScraper("https://demoncomics.org");
    // String tempRoute =
    //     "/manga/The-Heavenly-Demon-Can%2527t-Live-a-Normal-Life/chapter/1-VA48";

    // if (await webScraper.loadWebPage(tempRoute)) {
    //   contentPages = webScraper.getElement(
    //     'section.page-in.content-wrap > center > div > img',
    //     ['src'],
    //   );
    //   print(contentPages);
    //   setState(() {
    //     dataFetched = true;
    //   });
    // }
    final webScraper = WebScraper("https://chapmanganelo.com");
    String tempRoute = "/manga-tw133916/chapter-28";

    // Make an HTTP request with custom headers
    http.Response response = await http.get(
      Uri.parse("https://chapmanganelo.com$tempRoute"),
      headers: {
        'Referer': 'https://chapmanganelo.com',
      },
    );

    if (response.statusCode == 200) {
      // Load the HTML content into WebScraper
      if (webScraper.loadFromString(response.body)) {
        contentPages = webScraper.getElement(
          '.container-chapter-reader img',
          ['src'],
        );

        print(contentPages);
        setState(() {
          dataFetched = true;
        });
      }
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
        title: const Text("Content"),
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
