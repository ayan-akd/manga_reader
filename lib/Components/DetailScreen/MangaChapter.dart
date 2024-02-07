import 'package:flutter/material.dart';
import 'package:manga/Constants/Constants.dart';
import 'package:manga/Screens/ContentScreen.dart';

class MangaChapters extends StatelessWidget {
  final List<Map<String, dynamic>> mangaChapters;

  const MangaChapters({required Key key, required this.mangaChapters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: mangaChapters.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final chapter = mangaChapters[index];
          final chapterNumber = chapter['title'].toString().split(' ')[1];
          final chapterLink = chapter['attributes']!['href'].toString().trim();
          return SizedBox(
            height: 50,
            width: double.infinity,
            child: Material(
              color: Constants.lightGray,
              child: InkWell(
                onTap: () {
                  // Handle onTap, navigate to content screen with chapter link
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ContentScreen(
                              chapterLink: chapterLink,
                              chapterNumber: chapterNumber,
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chapterNumber,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
