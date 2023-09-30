class Trips{
  final int tripId;
  final String title;
  final String desc;
  final String startDate;
  final String endDate;
  final String age1;
  final String age2;
  final String ownerId;
  final String coverPhoto;

  Trips(
      {
        required this.tripId,
        required this.title,
      required this.desc,
        required this.startDate,
        required this.endDate,
        required this.age1,
        required this.age2,
        required this.ownerId,
        required this.coverPhoto});

  factory Trips.fromJson(Map<String, dynamic> json) {
    return Trips(
     tripId: json["tripId"],
      title: json["title"],
      desc: json["desc"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      age1: json["age1"],
      age2: json["age2"],
      ownerId: json["ownerId"],
      coverPhoto: json["coverPhoto"],
    );
  }
}