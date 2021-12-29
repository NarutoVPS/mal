import 'package:flutter/cupertino.dart';

class AnimeDetails {
  int id;
  String title;
  String imgUrl;
  double? score;
  int? rank;
  String trailerUrl;
  String type;
  String? status;
  String duration;
  int? episodes;
  String source;
  bool airing;
  String aired;
  String? rating;
  int? popularity;
  int? members;
  int? favourites;
  String synopsis;
  List<String>? licensors;
  String studio;

  AnimeDetails({
    this.id = 0,
    this.title = '',
    this.imgUrl = '',
    this.score = 0,
    this.rank = 0,
    this.trailerUrl = '',
    this.type = '',
    this.status = '',
    this.duration = '',
    this.episodes = 0,
    this.source = '',
    this.airing = false,
    this.aired = '',
    this.rating,
    this.popularity,
    this.members,
    this.favourites,
    this.synopsis = '',
    this.licensors,
    this.studio = '',
  });
}
