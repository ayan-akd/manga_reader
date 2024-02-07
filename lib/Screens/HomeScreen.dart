import 'package:flutter/material.dart';
import 'package:manga/Components/MangaCard.dart';
import 'package:manga/Components/homeScreen/MangaList.dart';
import 'package:manga/Constants/Constants.dart';
import 'package:manga/Widgets/BotNavItem.dart';
import 'package:web_scraper/web_scraper.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedNavIndex = 0;
  bool mangaLoaded = false;
  late List<Map<String, dynamic>> mangaList;
  late List<Map<String, dynamic>> mangaUrlList;

  void navBarTap(int index) {
    setState(() {
      selectedNavIndex = index;
    });
  }

  void fetchManga() async {
    final webScraper = WebScraper(Constants.baseUrl);
    if (await webScraper.loadWebPage('/wwww')) {
      mangaList = webScraper.getElement(
        'div.container-main-left > div.panel-content-homepage > div > a > img',
        ['src', 'alt'],
      );
      mangaUrlList = webScraper.getElement(
        'div.container-main-left > div.panel-content-homepage > div > a',
        ['href'],
      );
      setState(() {
        mangaLoaded = true;
      });
    }
  }

  // void fetchManga() async {
  //   try {
  //     // Make a GET request to your backend API endpoint
  //     final response = await http.get(Uri.parse('${Constants.baseUrl}/manga'));

  //     if (response.statusCode == 200) {
  //       // If the server returns a 200 OK response, parse the JSON data
  //       final jsonData = json.decode(response.body);
  //       setState(() {
  //         mangaList = List<Map<String, dynamic>>.from(
  //           (jsonData as List<dynamic>).map((item) => {
  //                 'title': item['title'],
  //                 'attributes': item['attributes'] as Map<String, dynamic>,
  //               }),
  //         );
  //         // print(mangaList);
  //         mangaLoaded = true;
  //       });
  //     } else {
  //       // If the server did not return a 200 OK response, throw an exception.
  //       throw Exception('Failed to load manga');
  //     }
  //   } catch (error) {
  //     // Handle errors
  //     print('Error during manga fetch: $error');
  //     setState(() {
  //       mangaLoaded = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    fetchManga();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manga Reader'),
        backgroundColor: Constants.darkGray,
      ),
      body: mangaLoaded
          ? MangaList(
              key: UniqueKey(),
              mangaList: mangaList,
              mangaUrlList: mangaUrlList,
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Constants.darkGray,
          selectedItemColor: Constants.lightblue,
          unselectedItemColor: Colors.white,
          currentIndex: selectedNavIndex,
          onTap: navBarTap,
          items: [
            botNavItem(Icons.home, "Home"),
            botNavItem(Icons.favorite, "Favorites"),
            botNavItem(Icons.watch_later, "Recent"),
          ]),
    );
  }
}
