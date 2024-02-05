import 'package:flutter/material.dart';
import 'package:manga/Components/MangaCard.dart';
import 'package:manga/Constants/Constants.dart';
import 'package:manga/Widgets/BotNavItem.dart';
import 'package:web_scraper/web_scraper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedNavIndex = 0;
  bool mangaLoaded = false;
  late List<Map<String, dynamic>> mangaList;

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
      // print(mangaList);
      setState(() {
        mangaLoaded = true;
      });
    }
  }

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
          ? Container(
              height: screenSize.height,
              width: double.infinity,
              color: Constants.black,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Wrap(
                  runSpacing: 10,
                  spacing: 5,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 30,
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${mangaList.length} Mangas Found",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    for (int i = 0; i < mangaList.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MangaCard(
                            mangaImg: mangaList[i]['attributes']['src'],
                            mangaTitle: mangaList[i]['attributes']['alt'],
                            mangaUrlList: mangaList[i]['attributes']['src']),
                      )
                  ],
                ),
              ),
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
