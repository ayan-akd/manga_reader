import 'package:flutter/material.dart';
import 'package:manga/Constants/Constants.dart';





class MangaCard extends StatelessWidget {
  final String mangaImg, mangaTitle, mangaUrlList;

  const MangaCard({
    Key? key,
    required this.mangaImg,
    required this.mangaTitle,
    required this.mangaUrlList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 110,
      child: GestureDetector(
        onTap: () {
          print(mangaUrlList);

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => DetailScreen(
          //       mangaImg: mangaImg,
          //       mangaLink: mangaUrlList,
          //       mangaTitle: mangaTitle,
          //     ),
          //   ),
          // );
        },
        child: Column(
          children: [
            Expanded(
              flex: 75,
              child: Image.network(
                mangaImg,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Expanded(
              flex: 25,
              child: Container(
                alignment: Alignment.centerLeft,
                color: Constants.darkGray,
                child: Text(
                  mangaTitle,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
