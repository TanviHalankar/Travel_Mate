import 'package:intl/intl.dart';

class Places {
  final int postId;
  final int dayNum;
  final String place;
  final String uid;
  Places({ required this.dayNum, required this.place,required this.uid,required this.postId});

  factory Places.fromJson(Map<String, dynamic> json) {
    return Places(
      postId: json["postId"],
      dayNum: json["dayNum"],
      place: json["place"],
      uid:json["uid"],
    );
  }
//

}
