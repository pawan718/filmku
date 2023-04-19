import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflix/models/movie.dart';

import '../contants.dart';

class NetworkHelper {
  NetworkHelper();
  String baseParams = "?api_key=db9fe57c5d3d6da757709bf78ac0337e&language=en-US";
int totalPages = 1;

  Future<List<Movie>> getOngoingMovies({int page = 1,required String playing}) async {
    final url = Uri
        .parse("$apiBaseUrl/movie/$playing$baseParams&page=$page");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      List<Movie> movies = [];
      final data = jsonDecode(response.body);
      for (var movie in data['results']) {
        movies.add(Movie.fromJson(movie));
      }
      totalPages = data['total_pages'];

      return movies;
    } else {
      print(response.statusCode);
    }
    return [];
  }

}
