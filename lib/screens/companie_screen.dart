import 'package:flutter/material.dart';
import 'package:project_movies/models/models.dart';
import 'package:project_movies/providers/movies_provider.dart';
import 'package:project_movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CompanieScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final ProductionCompany companie = ModalRoute.of(context)!.settings.arguments as ProductionCompany;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _CompanieAppBar(companie: companie),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterCompanie(companie: companie),
              _TitleSection(title: 'Logos de la compañia'),
              LogosCompaniesCarrusel( idCompanie: companie.id),
            ])
          )
        ],
      ),
    );
  }
}

class _CompanieAppBar extends StatelessWidget {

  final ProductionCompany companie;

  const _CompanieAppBar({Key? key, required this.companie}) : super(key: key);

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
            companie.name,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/count-loading.gif'),
          image: NetworkImage(companie.bannerCompanie),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterCompanie extends StatelessWidget {

  final ProductionCompany companie;

  const _PosterCompanie({Key? key, required this.companie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    final TextTheme customTextTheme = Theme.of(context).textTheme;

    return FutureBuilder(
      future: moviesProvider.getInfoCompanie(companie.id),
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(companie.name, style: customTextTheme.headline5, maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start),
                  Text(companie.name, style: customTextTheme.subtitle1, maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start)
                ],
              )
            ],
          ),
        );
        }

        final CompanieResponse data = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.name, style: customTextTheme.headline5, maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start),
                  Text(data.headquarters, style: customTextTheme.subtitle1, maxLines: 2,overflow: TextOverflow.ellipsis,textAlign: TextAlign.start)
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class _TitleSection extends StatelessWidget {

  final String title;

  const _TitleSection({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
    );
  }
}
