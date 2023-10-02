import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../db_info.dart';
import '../../model/members.dart';
import '../../model/trips.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/users.dart';


class ViewDetails extends StatefulWidget {
  Trips trip;
  String ownerPhn;
  ViewDetails({Key? key, required this.trip, required this.ownerPhn})
      : super(key: key);

  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  late Future<List<Members>> members;
  List<Users> users=[];
  void initState() {
    // TODO: implement initState
    super.initState();
    members = fetchMembersById(widget.trip.tripId);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    String? uid=user?.uid;
    fetchUsers(uid);
  }
  Future<void> fetchUsers(String? uid) async {
    try {
      final response = await http.get(Uri.parse('http://$ip:9000/users/$uid')); // Pass uid as a query parameter
      print(uid);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          // Parse the JSON data and create a list of Post objects
          users = (data as List).map((model) => Users.fromJson(model)).toList();
        });
      } else {
        print('HTTP Request Error: ${response.statusCode}');
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Error: $e');
      // Handle the error, e.g., show an error message to the user
    }
  }

  Future<List<Members>> fetchMembersById(int tripId) async {
    final response =
        await http.get(Uri.parse('http://$ip:9000/members/$tripId'));
    if (response.statusCode == 200) {
      final List<dynamic> memDataList = json.decode(response.body);
      return memDataList.map((memData) => Members.fromJson(memData)).toList();
    } else {
      throw Exception('Failed to load members with ID: $tripId');
    }
  }


  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunch(phoneUri.toString())) {
        await launch(phoneUri.toString());
      } else {
        throw Exception('Could not launch $phoneUri');
      }
    } catch (e) {
      print('Error launching phone call: $e');
      // Handle the error (e.g., show a message to the user)
    }
  }



  // void _launchWhatsApp(String phoneNumber) async {
  //   final whatsappUrl = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent('Hello, I am interested in your service!')}";
  //
  //   try {
  //     if (await canLaunch(whatsappUrl)) {
  //       await launch(whatsappUrl);
  //     } else {
  //       throw Exception('Could not launch WhatsApp');
  //     }
  //   } catch (e) {
  //     print('Error launching WhatsApp: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error launching WhatsApp. Please try again.'),
  //       ),
  //     );
  //   }
  // }

  // void _launchWhatsApp(String phoneNumber) async {
  //   final whatsappUrl = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent('Hello, I am interested in this trip!')}";
  //
  //   try {
  //     if (await canLaunch(whatsappUrl)) {
  //       await launch(whatsappUrl);
  //     } else {
  //       throw Exception('Could not launch WhatsApp');
  //     }
  //   } catch (e) {
  //     print('Error launching WhatsApp: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error launching WhatsApp. Please try again.'),
  //       ),
  //     );
  //   }
  // }

  // Future<void> _launchWhatsApp(String phoneNumber) async {
  //   final link = WhatsAppUnilink(
  //     phoneNumber: phoneNumber,
  //     text: 'Hello, I am interested in your service!',
  //   );
  //
  //   try {
  //     if (await canLaunch(link.toString())) {
  //       await launch(link.toString());
  //     } else {
  //       throw Exception('Could not launch WhatsApp');
  //     }
  //   } catch (e) {
  //     print('Error launching WhatsApp: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error launching WhatsApp. Please try again.'),
  //       ),
  //     );
  //   }
  // }
  Future<void> _launchWhatsApp(String phoneNumber) async {
    final whatsappUrl = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent('Hello, I am interested in your service!')}";

    try {
      if (await canLaunch(whatsappUrl)) {
        await launch(whatsappUrl);
      } else {
        throw Exception('Could not launch WhatsApp');
      }
    } catch (e) {
      print('Error launching WhatsApp: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error launching WhatsApp. Please try again.'),
        ),
      );
    }
  }


  // Future<void> _launchWhatsApp(String phoneNumber) async {
  //   final Uri whatsappUri = Uri.parse('https://wa.me/$phoneNumber');
  //   try {
  //     if (await canLaunch(whatsappUri.toString())) {
  //       await launch(whatsappUri.toString());
  //     } else {
  //       throw Exception('Could not launch $whatsappUri');
  //     }
  //   } catch (e) {
  //     print('Error launching WhatsApp: $e');
  //     // Handle the error (e.g., show a message to the user)
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Error launching WhatsApp. Please try again.'),
  //           ),
  //         );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Members>>(
          future: members,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No data available'));
            } else {
              List<Members> membersList = snapshot.data!;
              return membersList.isEmpty
                  ? SizedBox.expand(
                      child:
                          Center(child: Text('No member registrations found!')))
                  : SingleChildScrollView(
                    child: Column(
                      children: [
                        //Text(widget.ownerPhn),
                        //Text('members ${membersList.length}'),
                        Container(height: 200,width: double.maxFinite,decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage('http://$ip:9000/${widget.trip.coverPhoto}'),fit: BoxFit.cover)
                        )),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 50, top: 20, right: 50),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () => _launchWhatsApp(widget.ownerPhn),
                                  child: Image(
                                      image: NetworkImage(
                                          'https://cdn-icons-png.flaticon.com/128/2504/2504957.png?ga=GA1.1.2014633652.1690347742&track=ais'),
                                      height: 40)),
                              GestureDetector(
                                  onTap: () => _launchPhone(widget.ownerPhn),
                                  child: Image(
                                      image: NetworkImage(
                                          'https://cdn-icons-png.flaticon.com/128/3059/3059590.png?ga=GA1.1.2014633652.1690347742&track=ais'),
                                      height: 40)),
                            ],
                          ),
                        ),
                        Container(
                          height: 600,
                          child: ListView.builder(
                              itemCount: membersList.length,
                              itemBuilder: (context, index) {
                                Members member = membersList[index];
                                return Column(
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.all(16),
                                      title: Text('${member.userName}'),
                                      subtitle: Text('${member.residence}'),
                                      leading: CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage('http://$ip:9000/${users[0].profilePic}'),
                                      ),
                                      trailing: Text(member.phnum),
                                    ),
                                    Divider(
                                      color: Colors.white,
                                    )
                                  ],
                                );
                              },
                            ),
                        ),
                      ],
                    ),
                  );
            }
          }),
    );
  }
}
