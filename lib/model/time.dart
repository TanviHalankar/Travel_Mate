import 'package:intl/intl.dart';

class Times{
  final int postId;
  final int dayNum;
  final String place;
  final String uid;
  Times({ required this.dayNum, required this.place,required this.uid,required this.postId});

  factory Times.fromJson(Map<String, dynamic> json) {
    return Times(
      postId: json["postId"],
      dayNum: json["dayNum"],
      place: json["place"],
      uid:json["uid"],
    );
  }
//

}
