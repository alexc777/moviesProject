import 'package:flutter/material.dart';
import 'package:project_movies/models/models.dart';
import 'package:project_movies/widgets/widgets.dart';

class TopRatedDetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final TopRatedMovie movie = ModalRoute.of(context)!.settings.arguments as TopRatedMovie;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _TopRatedAppBar(movie: movie),
          SliverList(
            delegate: SliverChildListDelegate([
              _BannerTitle(movie: movie),
              _DescriptionMovie(movie: movie),
              _TitleSection(title: 'Críticas'),
              CardReviewsMovie(idMovie: movie.id)
            ])
          )
        ],
      ),
    );
  }
}

class _TopRatedAppBar extends StatelessWidget {

  final TopRatedMovie movie;

  const _TopRatedAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 10, left: 15, right: 15),
          color: Colors.black12,
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/count-loading.gif'),
          image: NetworkImage(movie.topBanner),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _BannerTitle extends StatelessWidget {

  final TopRatedMovie movie;

  const _BannerTitle({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextTheme customTextTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              width: 110,
              height: 150,
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.topPoster),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 170),
                child: Text(movie.title, style: customTextTheme.headline5, maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start)
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: size.width - 170),
                child: Text(movie.originalTitle, style: customTextTheme.subtitle1, maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start)
              ),

              Row(
                children: [
                  Icon(Icons.star_outline_rounded, size: 25, color: Colors.yellow),
                  SizedBox(width: 5),
                  Text(movie.voteAverage.toString(), style: customTextTheme.caption)
                ],
              ),
              Row(
                children: [
                  IconButton(
                    tooltip: 'Me Encanta',
                    icon: Icon(Icons.sentiment_satisfied_alt, size: 25),
                    onPressed: () {},
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    tooltip: 'Regular',
                    icon: Icon(Icons.sentiment_satisfied, size: 25),
                    onPressed: () {},
                  ),
                  SizedBox(width: 5),
                  IconButton(
                    tooltip: 'Pésimo',
                    icon: Icon(Icons.sentiment_very_dissatisfied , size: 25),
                    onPressed: () {},
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _DescriptionMovie extends StatelessWidget {

  final TopRatedMovie movie;

  const _DescriptionMovie({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

class _TitleSection extends StatelessWidget {

  final String title;

  const _TitleSection({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
    );
  }
}

