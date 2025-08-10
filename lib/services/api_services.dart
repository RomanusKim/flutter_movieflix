import 'dart:convert';

import 'package:flutter_movieflix/models/movie_detail.dart';
import 'package:flutter_movieflix/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const String baseUrl = "https://movies-api.nomadcoders.workers.dev";

  static Future<List<MovieModel>> getPopularMovies() async {
    print("getPopularMovies");
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$baseUrl/popular");
    print("getPopularMovies url : $url");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("statusCode == 200");
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      final List<dynamic> results = decoded['results'];
      for (var movie in results) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getNowInCinMovies() async {
    print("getNowInCinMovies");
    List<MovieModel> movieInstances = [];
    final url = Uri.parse("$baseUrl/now-playing");
    print("getNowInCinMovies url : $url");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("getNowInCinMovies statusCode == 200");
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      final List<dynamic> results = decoded['results'];
      for (var movie in results) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getcmSoMovies() async {
    print("getcmSoMovies");
    List<MovieModel> movieInstance = [];
    final url = Uri.parse("$baseUrl/coming-soon");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print("getcmSoMovies statusCode == 200");
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      final List<dynamic> results = decoded['results'];
      for (var movie in results) {
        movieInstance.add(MovieModel.fromJson(movie));
      }
      return movieInstance;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getDetailById(String id) async {
    final url = Uri.parse("$baseUrl/movie?id=$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }
}
