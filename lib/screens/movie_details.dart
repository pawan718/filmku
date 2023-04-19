import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:netflix/contants.dart';
import 'package:netflix/models/movie.dart';
import 'package:netflix/moviecard.dart';

class MovieDetails extends StatelessWidget {
   MovieDetails({Key? key, required this.movie}) : super(key: key);
Movie movie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * .35,
              width: double.infinity,
              decoration:  BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(getImagePath(movie.posterPath!),),
                    fit: BoxFit.cover),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('images/Button Play.svg'),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text(
                      'Play Trailer',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 34,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: DraggableScrollableSheet(
              initialChildSize: .7,
              minChildSize: .7,
              maxChildSize: 1,
              snap: true,
              snapSizes: const [.7, .85, 1],
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                SizedBox(
                                    width: 250,
                                    child: Text(
                                      movie.title ?? "N/a",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Mulish'),
                                    )),
                                const Icon(
                                  Icons.bookmark_border,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                             MovieRating(movieRating: movie.voteAverage?? 0.0),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: const [
                                MovieType(type: 'ACTION'),
                                SizedBox(
                                  width: 8,
                                ),
                                MovieType(type: 'ADVENTURE'),
                                SizedBox(
                                  width: 8,
                                ),
                                MovieType(type: 'FANTSAY'),
                              ],
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CetegoryWidget(
                                    cetegorycontent: '2h 4min',
                                    cetegorytype: 'Length'),
                                CetegoryWidget(
                                    cetegorycontent: 'English',
                                    cetegorytype: 'Language'),
                                CetegoryWidget(
                                    cetegorycontent: 'PG-13',
                                    cetegorytype: 'Rating'),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            const Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Merriweather'),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                             Text(movie.overview?? "N/a",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF9C9C9C),
                                  fontFamily: 'Mulish',
                                  letterSpacing: 1.0,
                                  height: 1.5),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                             TwoText(
                              topic: 'Cast',
                              seeMore: 'see more',
                              padding: 0.0,
                              onPressed: (){},
                            ),
                            const SizedBox(
                              height: 17,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 72,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Image.network(
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Karan_Aujla_in_studio.jpg/800px-Karan_Aujla_in_studio.jpg',
                                          width: 72,
                                          height: 76,
                                          fit: BoxFit.cover,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        clipBehavior: Clip.antiAlias,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'karan aujla' * 10,
                                        style: TextStyle(
                                          color: Color(0xff110E47),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          fontFamily: 'Mulish'
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              // child:
            ),
          ),
        ],
      ),
    );
  }
}
