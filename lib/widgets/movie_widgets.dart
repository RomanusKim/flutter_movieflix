import 'package:flutter/material.dart';
import 'package:flutter_movieflix/screens/detail_screen.dart';

class Movie extends StatelessWidget {
  final String title, poster;
  final int id;
  final bool visible;

  static const String imgBaseUrl = "https://image.tmdb.org/t/p/w500/";

  const Movie({super.key, required this.title, required this.poster, required this.id, required this.visible});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(id: id, posterUrl: poster),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: visible ? 150 : 300,
            height: visible ? 125 : 250,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(blurRadius: 15, offset: Offset(10, 10), color: Colors.black.withOpacity(0.5))],
            ),
            child: Image.network(
              imgBaseUrl + poster,
              fit: BoxFit.cover,
              headers: const {
                "User-Agent":
                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
              },
            ),
          ),
          SizedBox(height: 10),
          Visibility(
            visible: visible,
            child: SizedBox(
              width: 125,
              child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ),
          ),
        ],
      ),
    );
  }
}
