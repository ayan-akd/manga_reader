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
          return SizedBox(
            height: 50,
            width: double.infinity,
            child: Material(
              color: Constants.lightGray,
              child: InkWell(
                onTap: () => const ContentScreen(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      mangaChapters[index]['title'],
                      style: const TextStyle(color: Colors.white),
                    ),
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
