import 'package:ttravel_mate/model/places.dart';
import 'package:ttravel_mate/model/seasons.dart';

class Itinerary {
  final int itiId;
  final int postId;
  final String duration;
  final String location;
  final String uid;
  List<Places> place;

  Itinerary({
    required this.itiId,
    required this.postId,
    required this.duration,
    required this.location,
    required this.uid,
    this.place = const [],
  });

  factory Itinerary.fromJson(Map<String, dynamic> json) {
    return Itinerary(
      itiId: json["itiId"],
      postId: json["postId"],
      duration: json["duration"],
      location: json["location"],
      uid: json["uid"],);
  }

}
