import 'dart:convert';

class CompanieResponse {
  CompanieResponse({
    this.description,
    required this.headquarters,
    required this.homepage,
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
    this.parentCompany,
  });

  String? description;
  String headquarters;
  String homepage;
  int id;
  String? logoPath;
  String name;
  dynamic originCountry;
  dynamic parentCompany;

  factory CompanieResponse.fromJson(String str) => CompanieResponse.fromMap(json.decode(str));

  factory CompanieResponse.fromMap(Map<String, dynamic> json) => CompanieResponse(
    description: json["description"] ?? 'no tiene descripción',
    headquarters: json["headquarters"],
    homepage: json["homepage"],
    id: json["id"],
    logoPath: json["logo_path"],
    name: json["name"],
    originCountry: json["origin_country"],
    parentCompany: json["parent_company"],
  );
}
