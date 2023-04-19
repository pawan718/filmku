import 'package:flutter/material.dart';

import 'models/apicall.dart';
import 'models/movie.dart';

const String apiBaseUrl = "https://api.themoviedb.org/3";
const String imageBasePath = 'https://image.tmdb.org/t/p/w342';
String getImagePath(String path) {
  return "$imageBasePath$path";
}
