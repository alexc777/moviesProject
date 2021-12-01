import 'package:flutter/material.dart';
import 'package:project_movies/widgets/widgets.dart';

class DetailScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Overview(),
              _Overview(),
              _Overview(),
              _Overview(),
              _TitleCasting(),
              CastingCards()
            ])
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {

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
          padding: EdgeInsets.only(bottom: 10),
          color: Colors.black12,
          child: Text(
            'movie.title',
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final TextTheme customTextTheme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 150,
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 20),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('movie.title', style: customTextTheme.headline5, overflow: TextOverflow.ellipsis, maxLines: 2),
              Text('movie.originalTitle', style: customTextTheme.subtitle1, overflow: TextOverflow.ellipsis, maxLines: 1),
              Row(
                children: [
                  Icon(Icons.star_outline_rounded, size: 25, color: Colors.yellow),
                  SizedBox(width: 5),
                  Text('movie.voteAverage', style: customTextTheme.caption)
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

class _Overview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis quis sapien eget ipsum efficitur venenatis. Etiam sodales, massa sed efficitur dictum, tortor ante fermentum nibh, laoreet sagittis ligula turpis a erat. In vel ligula nec tortor finibus suscipit.',
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}

class _TitleCasting extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text('Reparto', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
    );
  }
}
