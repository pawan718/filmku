import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netflix/models/apicall.dart';
import 'package:netflix/models/movie.dart';
import 'package:netflix/screens/movie_details.dart';
import 'package:netflix/screens/seemorescreen.dart';
import '../contants.dart';
import '../moviecard.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {

  List<Movie> movies = [];
  List<Movie> movies2  = [];
  NetworkHelper helper = NetworkHelper();
  @override
  void initState() {
    super.initState();

      getMovies();

  }

  Future<void> getMovies() async {
    movies = await helper.getOngoingMovies(playing: 'now_playing');
    movies2 = await helper.getOngoingMovies(playing: 'popular');
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const DiffernceHieght16(),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: TwoText(
                topic: 'Now Showing',
                seeMore: 'See more',
                padding: 24.0,
                onPressed: (){
             Navigator.push(context, MaterialPageRoute(builder: (context) => Seemore(playing: 'now_playing')));
                },
              ),
            ),
            const DiffernceHieght16(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: movies.map((movie) {
                  return Padding(
                    padding: EdgeInsets.only(
                        right: 24, left: movies.indexOf(movie) == 0 ? 24 : 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MovieDetails(
                                      movie: movie,
                                    )));
                      },
                      child: MovieCard(
                        url: getImagePath(movie.posterPath!),
                        movieName: movie.title ?? "N/A",
                        movieRating: movie.voteAverage ?? 0.0,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Builder(
                  builder: (context) {
                    return TwoText(
                      topic: 'Popular',
                      seeMore: 'See more',
                      padding: 24.0,
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Seemore(playing: 'popular',)));
                      },
                    );
                  }
                )),
            const DiffernceHieght16(),
            Column(
              children: movies2.map((movie) {
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
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Ink(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Optional
            mainAxisAlignment:
                MainAxisAlignment.spaceAround, // Change to your own spacing
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "images/Bookmark.svg",
                  width: 24,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "images/Bookmark Copy.svg",
                  width: 24,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: SvgPicture.asset(
                  "images/Bookmark Copy 2.svg",
                  width: 24,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
