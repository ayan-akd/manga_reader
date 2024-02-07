import 'package:flutter/material.dart';
import 'package:manga/Components/DetailScreen/MangaChapter.dart';
import 'package:manga/Components/DetailScreen/MangaDesc.dart';
import 'package:manga/Components/DetailScreen/MangaInfo.dart';
import 'package:manga/Constants/Constants.dart';
import 'package:manga/Widgets/HorDivider.dart';
import 'package:web_scraper/web_scraper.dart';

class DetailScreen extends StatefulWidget {
  final String mangaImg, mangaTitle, mangaLink;

  const DetailScreen(
      {required Key key,
      required this.mangaImg,
      required this.mangaTitle,
      required this.mangaLink})
      : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late String mangaGenres, mangaStatus, mangaAuthor, mangaDesc;
  // // mangaLink = https://m.manganelo.com/manga-gc121022
  late List<Map<String, dynamic>> mangaDetail;
  late List<Map<String, dynamic>> mangaDescList;
  late List<Map<String, dynamic>> mangaChapters;

  bool dataFetch = false;

  void getMangaInfos() async {
    // String tempBaseUrl = widget.mangaLink.split(".com")[0] + ".com";
    // String tempRoute = widget.mangaLink.split(".com")[1];

    final webScraper = WebScraper(Constants.baseUrl);

    // if (await webScraper.loadWebPage(widget.mangaLink)) {
    //   mangaDetail = webScraper.getElement(
    //     'div.panel-story-info > div.story-info-right > table > tbody > tr > td.table-value',
    //     [],
    //   );

    //   mangaDescList = webScraper.getElement(
    //     'div.panel-story-info > div.panel-story-info-description',
    //     [],
    //   );

    //   mangaChapters = webScraper.getElement(
    //     'div.panel-story-chapter-list > ul > li > a',
    //     ['href'],
    //   );
    // }

    // mangaGenres = mangaDetail[3]['title'].toString().trim();
    // mangaStatus = mangaDetail[2]['title'].toString().trim();
    // mangaAuthor = mangaDetail[1]['title'].toString().trim();
    // mangaDesc = mangaDescList[0]['title'].toString().trim();


    setState(() {
      dataFetch = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getMangaInfos();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mangaTitle),
        centerTitle: true,
        backgroundColor: Constants.darkGray,
      ),
      body: dataFetch
          ? Container(
              height: screenSize.height,
              width: screenSize.width,
              color: Constants.lightGray,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MangaInfo(
                      key: const Key('info_screen'),
                      mangaImg: widget.mangaImg,
                      mangaAuthor: "mangaAuthor",
                      mangaStatus: "mangaStatus",
                    ),
                    // const HorDivider(),
                    // MangaDesc(
                    //   mangaDesc: mangaDesc,
                    //   mangaGenres: mangaGenres,
                    //   key: const Key('manga_des'),
                    // ),
                    // const HorDivider(),
                    // // mangaChapters - chapters
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Padding(
                    //       padding: const EdgeInsets.only(
                    //           top: 16.0, left: 8.0), // Adding margin on top
                    //       child: Text(
                    //         "Chapters - ${mangaChapters.length}",
                    //         style: const TextStyle(
                    //           color: Colors.white,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 17,
                    //         ),
                    //         textAlign:
                    //             TextAlign.start, // Align text to the left
                    //       ),
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(top: 8.0),
                    //       child: MangaChapters(
                    //         mangaChapters: mangaChapters,
                    //         key: const Key('chapter_screen'),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // MangaChapters(
                    //   mangaChapters: mangaChapters,
                    //   key: const Key('chapter_screen'),
                    // )
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
