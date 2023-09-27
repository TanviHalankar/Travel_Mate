import 'package:ttravel_mate/model/places.dart';
import 'package:ttravel_mate/model/seasons.dart';
import 'package:ttravel_mate/model/time.dart';

import 'itinerary.dart';

class Post {
  final int id;
  final String location;
  final String description;
  final String duration;
  final String category;
  final double budget;
  bool showSeasons;
  List<Seasons> seasons;
  List<Itinerary> itinerary;
  List<Places> places;
  List<Times> times;

  Post({
    required this.id,
    required this.location,
    required this.description,
    required this.duration,
    required this.category,
    required this.budget,
    this.showSeasons = false,
    this.seasons = const [],
    this.itinerary = const [],
    this.places= const [],
    this.times= const [],
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id:json['postId'],
      location: json['location'],
      description: json['description'],
      duration: json['duration'],
      category: json['category'],
      budget: json['budget'].toDouble(),
    );
  }
}