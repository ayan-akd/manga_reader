import 'package:flutter/material.dart';
import 'package:manga/Screens/ContentScreen.dart';
import 'package:manga/Screens/DetailScreen.dart';
import 'package:manga/Screens/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Manga Reader',
      // home: HomeScreen()
      home: DetailScreen(
          key: Key('info_screen'),
          mangaImg:
              "https://readermc.org/images/thumbnails/Reincarnator%20(Manhwa).webp",
          mangaTitle: "Reincarnator (Manhwa)",
          mangaLink: "/manga/Reincarnator-%2528Manhwa%2529-VA48"),
      // home: ContentScreen()
    );
  }
}
