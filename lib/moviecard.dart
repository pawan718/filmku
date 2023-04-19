import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:netflix/screens/seemorescreen.dart';

class MovieCard extends StatelessWidget {
  const MovieCard(
      {super.key,
      required this.url,
      required this.movieName,
      required this.movieRating});
  final String url;
  final String movieName;
  final double movieRating;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration:  BoxDecoration(borderRadius: BorderRadius.circular(5),
            boxShadow: const [
            BoxShadow(blurRadius: 10.0, color: Colors.black38,),
          ],
          ),
          width: 143,
          height: 212,
          child: Image.network(url, fit: BoxFit.cover),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          width: 140,
          child: Text(
            movieName ,
            style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                fontFamily: 'Mulish'),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        MovieRating(movieRating: movieRating)
      ],
    );
  }
}

class MovieRating extends StatelessWidget {
  const MovieRating({super.key, required this.movieRating});
  final double movieRating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          'images/Star.svg',
          width: 12,
          height: 12,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          '$movieRating/10 IMDb',
          style: const TextStyle(fontSize: 12, fontFamily: 'Mulish',color: Color(0xFF9C9C9C),fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}

class TwoText extends StatelessWidget {
  const TwoText(
      {super.key,
      required this.topic,
      required this.seeMore,
      required this.padding,
      required this.onPressed});
  final String topic;
  final String seeMore;
  final double padding;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          topic,
          style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16.0,
              fontFamily: 'Merriweather'),
        ),
        GestureDetector(
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.only(right: padding),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0XFFE5E4EA)),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  seeMore,
                  style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFFAAA9B1),
                      fontFamily: 'Mulish'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MovieType extends StatelessWidget {
  const MovieType({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFDBE3FF),
          borderRadius: BorderRadius.circular(100)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        child: Text(
          type,
          style: const TextStyle(
              fontSize: 8,
              color: Color(0xFF88A4E8),
              fontFamily: 'Mulish',
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class DiffernceBetween extends StatelessWidget {
  const DiffernceBetween({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 8,
    );
  }
}

class MovieListItem extends StatelessWidget {
 const MovieListItem({super.key,
    required this.moviename,
    required this.url,
    required this.movierating,
    required this.time,
  });
  final String url;
  final String moviename;
  final double movierating;
 final String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              url,
              width: 85,
              height: 128,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 120,
                  child: Text(
                    moviename,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w700),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const DiffernceBetween(),
                 MovieRating(movieRating: movierating),
                const DiffernceBetween(),
                Row(
                  children: const [
                    MovieType(
                      type: 'HORROR',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    MovieType(
                      type: 'MYSTERY',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    MovieType(
                      type: 'THRILLER',
                    ),
                  ],
                ),
                const DiffernceBetween(),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 10,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w400),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CetegoryWidget extends StatelessWidget {
  const CetegoryWidget({super.key, required this.cetegorycontent, required this.cetegorytype});
 final String cetegorytype;
 final String cetegorycontent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          cetegorytype,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9C9C9C)),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(
          cetegorycontent,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class DiffernceHieght13 extends StatelessWidget {
  const DiffernceHieght13({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 13,
    );
  }
}

class DifferenceWidth16 extends StatelessWidget {
  const DifferenceWidth16({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 16,
    );
  }
}

class DiffernceHieght16 extends StatelessWidget {
  const DiffernceHieght16({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 16.0,
    );
  }
}
