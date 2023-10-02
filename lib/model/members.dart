class Members{
  final int tripId;
  final String ownerId;
  final String memberId;
  final String status;
  final String userName;
  final String fullName;
  final String age;
  final String phnum;
  final String residence;
  final String gender;

  Members(
      {required this.tripId,
        required this.ownerId,
        required this.memberId,
        required this.status,
        required this.userName,
        required this.fullName,
        required this.age,
        required this.phnum,
        required this.residence,
        required this.gender});

  factory Members.fromJson(Map<String, dynamic> json) {
    return Members(
      tripId: json["tripId"],
      ownerId: json["ownerId"],
      memberId: json["memberId"],
      status: json["status"],
      userName: json["userName"],
      fullName: json["fullName"],
      age: json["age"],
      phnum: json["phnum"],
      residence: json["residence"],
      gender: json["gender"],
    );
  }
//
}