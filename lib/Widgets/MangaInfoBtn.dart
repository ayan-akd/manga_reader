import 'package:flutter/material.dart';
import 'package:manga/Constants/Constants.dart';

class MangaInfoBtn extends StatelessWidget {
  final IconData icon;
  final String title;

  const MangaInfoBtn(
      {required Key key, required this.icon, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
          color: Constants.lightblue,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
