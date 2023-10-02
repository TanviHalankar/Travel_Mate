class Users {
  final String username;
  final String uid;
  final String email;
  final String phone_num;
  final String country;
  final String profilePic;
  // final List followers;
  // final List following;

  Users({
    required this.username,
    required this.uid,
    required this.email,
    required this.phone_num,
    required this.country,
    required this.profilePic,
    // required this.followers,
    // required this.following,
  });


  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      username: json["username"],
      uid: json["uid"],
      email: json["email"],
      phone_num: json["phone_num"],
      country: json["country"],
      profilePic: json["profilePic"],
      // followers: List.of(json["followers"])
      //     .map((i) => i /* can't generate it properly yet */)
      //     .toList(),
      // following: List.of(json["following"])
      //     .map((i) => i /* can't generate it properly yet */)
      //     .toList(),
    );
  }

//

}

