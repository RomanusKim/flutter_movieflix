import 'package:flutter/material.dart';
import 'package:flutter_movieflix/models/movie_model.dart';
import 'package:flutter_movieflix/services/api_services.dart';
import 'package:flutter_movieflix/widgets/movie_widgets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> popularMovies = ApiServices.getPopularMovies();
  final Future<List<MovieModel>> nowInCinMovies = ApiServices.getNowInCinMovies();
  final Future<List<MovieModel>> cmSoMovies = ApiServices.getcmSoMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Section(sectionTitle: 'Popular Movies', future: popularMovies, visible: false),
            Section(sectionTitle: 'Now In Cinemas', future: nowInCinMovies, visible: true),
            Section(sectionTitle: 'Coming Soon', future: cmSoMovies, visible: true),
          ],
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String sectionTitle;
  final bool visible;
  final Future<List<MovieModel>> future;

  const Section({super.key, required this.sectionTitle, required this.future, required this.visible});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(sectionTitle, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          SizedBox(
            height: visible ? 250 : 300,
            child: FutureBuilder(
              key: ValueKey(sectionTitle),
              future: future,
              builder: (context, snapshot) {
                print("state=${snapshot.connectionState} hasData=${snapshot.hasData} hasError=${snapshot.hasError}");

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('에러: ${snapshot.error}'));
                }

                final data = snapshot.data;

                if (data == null || data.isEmpty) {
                  return const Center(child: Text('데이터가 없어요.'));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: makeList(data, visible)), // snapshot 말고 리스트 그대로 넘기기
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView makeList(List<MovieModel> movies, bool visible) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: movies.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return Movie(title: movie.title, poster: movie.posterPath, id: movie.id, visible: visible);
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }
}
