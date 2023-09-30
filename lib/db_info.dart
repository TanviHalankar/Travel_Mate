import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

String ip='192.168.160.125';
//String ip='192.168.1.9';

// Future<void> createPost(String title,String desc,String duration,String category,double budget) async {
//   final response = await http.post(
//     Uri.parse('http://'+ip+':9000/posts'),
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode({'location':title,'description':desc,'duration':duration,'category':category,'budget':budget}),
//   );
// }


Future<int> createUser(String username,String password,String email,String phone_num,String country,String uid) async {
  final response = await http.post(
    Uri.parse('http://'+ip+':9000/users'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'username': username,'password':password,'email': email, 'phone_num': phone_num, 'country': country,'uid':uid}),
  );

  final Map<String, dynamic> responseData = json.decode(response.body);
  final int userId = responseData['id'];
  return userId;
}

Future<int> createPost(String title, String desc, String duration, String category, double budget,String uid) async {
  final response = await http.post(
    Uri.parse('http://'+ip+':9000/posts'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'location': title, 'description': desc, 'duration': duration, 'category': category, 'budget': budget,'uid':uid}),
  );

  // Assuming the response contains the newly created postId
  final Map<String, dynamic> responseData = json.decode(response.body);
  final int postId = responseData['id'];

  return postId;
}

// Future<void> createTrips(String title, String desc, String startDate, String endDate, String age1,String age2,String ownerId) async {
//   final response = await http.post(
//     Uri.parse('http://'+ip+':9000/trips'),
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode({'title':title,'desc':desc,'startDate':startDate, 'endDate':endDate,'age1':age1,'age2':age2,'ownerId':ownerId}),
//   );
// }

Future<void> createTrips(String title, String desc, String startDate, String endDate, String age1, String age2, String ownerId, Uint8List? image) async {
  // Create a Map with the fields
  var data = {
    'title': title,
    'desc': desc,
    'startDate': startDate,
    'endDate': endDate,
    'age1': age1,
    'age2': age2,
    'ownerId': ownerId,
  };

  // Create a multipart request
  var request = http.MultipartRequest('POST', Uri.parse('http://' + ip + ':9000/trips'));

  // Add text fields to the request
  request.fields.addAll(data);

  // Add the image file to the request, if available
  if (image != null) {
    var imageField = http.MultipartFile.fromBytes('coverPhoto', image, filename: 'image.jpg');
    request.files.add(imageField);
  }

  // Send the request and handle the response
  try {
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Trip created successfully');
    } else {
      print('Failed to create trip. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error sending request: $error');
  }
}



Future<void> createSeason(String season_name, int postId) async {
  final response = await http.post(
    Uri.parse('http://$ip:9000/seasons'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'season_name': season_name, 'postId': postId}),
  );
}

Future<int> createItinerary(int postId,String duration,String location,String uid) async {
  final response = await http.post(
    Uri.parse('http://$ip:9000/itinerary'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'postId': postId,'duration':duration,'location':location,'uid':uid}),
  );

  // Assuming the response contains the newly created itiId
  final Map<String, dynamic> responseData = json.decode(response.body);
  final int itiId = responseData['id'];

  return itiId;
}

Future<void> createTimes(int postId,int dayNum,String time) async {
  final response = await http.post(
    Uri.parse('http://$ip:9000/times'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'postId':postId,'dayNum':dayNum,'time':time}),
  );
}

Future<void> createPlaces(int postId,int dayNum,String place) async {
  final response = await http.post(
    Uri.parse('http://$ip:9000/places'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'postId':postId,'dayNum':dayNum,'place':place}),
  );
}


// Future<void> followUser(int id, String followerUid, String followingUid) async {
//   final response = await http.post(
//     Uri.parse('http://$ip:9000/follow'),
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode({'id': id, 'follower_uid': followerUid, 'following_uid': followingUid}),
//   );
//
//   // Handle the response here
// }
//
Future<void> unfollow(int id, String followerUid, String followingUid) async {
  final response = await http.post(
    Uri.parse('http://$ip:9000/unfollow'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'id': id, 'follower_uid': followerUid, 'following_uid': followingUid}),
  );

  // Handle the response here
}
//
// Future<void> getFollowersByUid(String uid) async {
//   final response = await http.post(
//     Uri.parse('http://$ip:9000/followers/$uid'),
//     headers: {'Content-Type': 'application/json'},
//   );
//
//   // Handle the response here
// }
//
// Future<void> getFollowingByUid(String uid) async {
//   final response = await http.post(
//     Uri.parse('http://$ip:9000/following/$uid'),
//     headers: {'Content-Type': 'application/json'},
//   );
//
//   // Handle the response here
// }

// Future<void> followers(int id,String follower_uid,String following_uid) async {
//   final response = await http.post(
//     Uri.parse('http://$ip:9000/follow'),
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode({'id':id,'follower_uid':follower_uid,'following_uid':following_uid}),
//   );
// }
//
// Future<void> unfollow(int id,String follower_uid,String following_uid) async {
//   final response = await http.post(
//     Uri.parse('http://$ip:9000/unfollow'),
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode({'id':id,'follower_uid':follower_uid,'following_uid':following_uid}),
//   );
// }
//
// Future<void> followersByUid(int id,String follower_uid,String following_uid) async {
//   final response = await http.post(
//     Uri.parse('http://$ip:9000/followers/:uid'),
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode({'id':id,'follower_uid':follower_uid,'following_uid':following_uid}),
//   );
// }
//
//
// Future<void> followingByUid(int id,String follower_uid,String following_uid) async {
//   final response = await http.post(
//     Uri.parse('http://$ip:9000/following/:uid'),
//     headers: {'Content-Type': 'application/json'},
//     body: json.encode({'id':id,'follower_uid':follower_uid,'following_uid':following_uid}),
//   );
// }