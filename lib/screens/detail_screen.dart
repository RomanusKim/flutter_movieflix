import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_movieflix/models/movie_detail.dart';
import 'package:flutter_movieflix/services/api_services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String posterUrl; // ex) "/abc.jpg"

  const DetailScreen({super.key, required this.id, required this.posterUrl});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;
  static const String imgBaseUrl = "https://image.tmdb.org/t/p/w500";

  @override
  void initState() {
    super.initState();
    movie = ApiServices.getDetailById(widget.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final bgUrl = '$imgBaseUrl${widget.posterUrl}';

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1) 배경 이미지
          Positioned.fill(
            child: Image.network(bgUrl, fit: BoxFit.cover, alignment: Alignment.topCenter),
          ),
          // 2) 가독성 그라디언트
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.65),
                    Colors.black.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: FutureBuilder<MovieDetailModel>(
                future: movie,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 300),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (snapshot.hasError) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 220),
                      child: Text('오류: ${snapshot.error}', style: const TextStyle(color: Colors.white)),
                    );
                  }
                  final data = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 380),
                      Text(
                        data.title,
                        style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      RatingBarIndicator(
                        rating: (data.voteAverage / 2).clamp(0, 5),
                        itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 20,
                        unratedColor: Colors.white24,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data.genres.isEmpty ? '-' : data.genres.join(', '),
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.85),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Storyline',
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data.overview,
                        style: TextStyle(fontSize: 16, height: 1.4, color: Colors.white.withOpacity(0.95)),
                      ),
                      const SizedBox(height: 32),
                    ],
                  );
                },
              ),
            ),
          ),
          // 4) 맨 위 레이어: Back to list (터치 항상 가능)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.arrow_back, color: Colors.white, size: 20),
                        SizedBox(width: 6),
                        Text(
                          'Back to list',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
