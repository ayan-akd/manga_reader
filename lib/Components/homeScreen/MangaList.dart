import 'package:flutter/material.dart';
import 'package:manga/Components/MangaCard.dart';
import 'package:manga/Constants/Constants.dart';

class MangaList extends StatelessWidget {
  final List<Map<String, dynamic>> mangaList;
  final List<Map<String, dynamic>> mangaUrlList;

  const MangaList(
      {required Key key, required this.mangaList, required this.mangaUrlList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height,
      width: double.infinity,
      color: Constants.black,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Wrap(
            alignment: WrapAlignment.center,
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
                  padding: const EdgeInsets.all(3.3),
                  child: MangaCard(
                      mangaImg: mangaList[i]['attributes']['src'],
                      mangaTitle: mangaList[i]['attributes']['alt'],
                      mangaUrlList: mangaUrlList[i]['attributes']['href']),
                )
            ],
          ),
        ),
      ),
    );
  }
}
