import 'package:flutter/material.dart';
import 'package:manga/Widgets/MangaInfoBtn.dart';
import 'package:manga/Widgets/VertDivider.dart';

class MangaInfo extends StatelessWidget {
  final String mangaImg, mangaStatus, mangaAuthor;

  const MangaInfo(
      {required Key key,
      required this.mangaImg,
      required this.mangaStatus,
      required this.mangaAuthor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 160,
                    width: 130,
                    child: Image.network(
                      mangaImg,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text("By $mangaAuthor - $mangaStatus",
                      style: const TextStyle(color: Colors.white))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 50,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MangaInfoBtn(
                  icon: Icons.play_arrow_outlined,
                  title: "Read",
                  key: Key('read_btn'),
                ),
                VertDivider(),
                MangaInfoBtn(
                  icon: Icons.format_list_bulleted_sharp,
                  title: "Chapters",
                  key: Key('chapter_btn'),
                ),
                VertDivider(),
                MangaInfoBtn(
                  icon: Icons.favorite_border_outlined,
                  title: "Favorite",
                  key: Key('fav_btn'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
