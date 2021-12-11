import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_movies/models/models.dart';
import 'package:project_movies/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class LogosCompaniesCarrusel extends StatelessWidget {

  final int idCompanie;

  const LogosCompaniesCarrusel({Key? key, required this.idCompanie}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getimagesCompanie(idCompanie),
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Container(
            constraints: BoxConstraints(maxWidth: 150),
            height: 130,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Logo> logos = snapshot.data!;

        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 210,
          child: ListView.builder(
            itemCount: logos.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, int index) => _CompanieCard(logo: logos[index])
          ),
        );
      },
    );
  }
}

class _CompanieCard extends StatelessWidget {

  final Logo logo;

  const _CompanieCard({Key? key, required this.logo}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 220,
      height: 200,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage(logo.logosCompanie),
              width: 220,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),

          SizedBox(height: 5),
        ],
      ),
    );
  }
}