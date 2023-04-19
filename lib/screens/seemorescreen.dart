import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:netflix/contants.dart';
import 'package:netflix/models/apicall.dart';
import 'package:netflix/models/movie.dart';
import '../moviecard.dart';
import 'movie_details.dart';
import 'package:http/http.dart' as http;

class Seemore extends StatefulWidget {
  Seemore({required this.playing});
String playing;
  @override
  State<Seemore> createState() => _SeemoreState();
}

class _SeemoreState extends State<Seemore> {

  List<Movie> movies = [];

  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  final NetworkHelper helper = NetworkHelper();

  @override
  void initState() {
 WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
   getMovies();
   _scrollController.addListener(() {
     if (_scrollController.position.pixels ==
         _scrollController.position.maxScrollExtent) {
       currentPage++;
       getMovies();
     }
   });
 });
    super.initState();
  }

  Future<void> getMovies() async {
    final fetchedMovies = await helper.getOngoingMovies(page: currentPage, playing: widget.playing);
      movies.addAll(fetchedMovies);
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "images/Union.svg",
            width: 24,
            height: 24,
          ),
        ),
        title: SvgPicture.asset("images/FilmKu.svg"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "images/Path.svg",
              width: 16,
            ),
          )
        ],
      ),
      body: Builder(
        builder: (context) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
              itemCount: movies.length + 1,
              controller: _scrollController,
              itemBuilder: (context, index) {
                if (index == movies.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final Movie movie = movies[index];
                if (index < helper.totalPages) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 13),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieDetails(
                                      movie: movie,
                                    )));
                      },
                      child: MovieListItem(
                          moviename: movie.title ?? "N/A",
                          url: getImagePath(movie.posterPath!),
                          movierating: movie.voteAverage ?? 0.0,
                          time: '2h 3m'),
                    ),
                  );
                }
              });
        },
      ),
    );
  }
}
