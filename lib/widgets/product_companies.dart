import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_movies/models/models.dart';
import 'package:project_movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CompaniesMovieCard extends StatelessWidget {

  final int idMovie;

  const CompaniesMovieCard({Key? key, required this.idMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getDetailMovie(idMovie),
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 130,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<ProductionCompany> companies = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 130,
          child: ListView.builder(
            itemCount: companies.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CompanieCard(companie: companies[index])
          ),
        );
      },
    );
  }
}

class _CompanieCard extends StatelessWidget {

  final ProductionCompany companie;

  const _CompanieCard({Key? key, required this.companie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 200,
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'similar', arguments: companie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(companie.logoImg),
                width: 220,
                height: 90,
                fit: BoxFit.contain,
              ),
            ),
          ),

          SizedBox(height: 5),

          Text(
            companie.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center
          )
        ],
      ),
    );
  }
}