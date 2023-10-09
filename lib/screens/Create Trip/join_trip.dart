import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ttravel_mate/db_info.dart';
import 'package:ttravel_mate/screens/Create%20Trip/create_trip.dart';
import 'package:ttravel_mate/screens/Create%20Trip/view_trip.dart';
import 'package:ttravel_mate/screens/navigation/tripsPage.dart';
import 'package:ttravel_mate/utils/utils.dart';

import '../../model/users.dart';
import '../../providers/join_trip_state.dart';
import '../../providers/user_provider.dart';
import 'package:http/http.dart' as http;
class JoinTrip extends StatefulWidget {
  int tripId;
  String ownerId;
  JoinTrip({Key? key,required this.tripId,required this.ownerId}) : super(key: key);

  @override
  State<JoinTrip> createState() => _JoinTripState();
}

class _JoinTripState extends State<JoinTrip> {
  //TextEditingController userController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController ageController=TextEditingController();
  TextEditingController phNumController=TextEditingController();
  TextEditingController resController=TextEditingController();
  List<Users> users=[];
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    String? uid=user?.uid;
    fetchUsers(uid);
  }
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid=user?.uid;
    String gender='';
    //final joinTripState = context.read<JoinTripState>();
    //final userProvider = context.read<UserProvider>();
    final joinTripState = context.watch<JoinTripState>();
    bool requestStatus = joinTripState.getRequestStatus(widget.tripId);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           children: [
             //Text('Join Trip'),
             // TextFormField(
             //   controller: userController,
             //   cursorColor: Colors.white,
             //   decoration: InputDecoration(
             //       border: OutlineInputBorder(),
             //       suffixIcon: Icon(Icons.edit),
             //       labelText: 'Username',
             //       labelStyle: TextStyle(color: Colors.grey)),
             // ),
             // SizedBox(height: 10,),
             TextFormField(
               controller: nameController,
               cursorColor: Colors.white,
               decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   suffixIcon: Icon(Icons.edit),
                   labelText: 'Full Name',
                   labelStyle: TextStyle(color: Colors.grey)),
             ),
             SizedBox(height: 10,),
             Row(
               children: [
                 Container(
                   width: 165,
                   child: TextFormField(
                     keyboardType: TextInputType.number,
                     controller: ageController,
                     cursorColor: Colors.white,
                     decoration: InputDecoration(
                         border: OutlineInputBorder(),
                         suffixIcon: Icon(Icons.edit),
                         labelText: 'Age',
                         labelStyle: TextStyle(color: Colors.grey)),
                   ),
                 ),
                 SizedBox(width: 10,),
                 Container(
                   width: 165,
                   child: DropdownButtonFormField<String>(
                     hint: Text('Gender'),
                     items: ['Male','Female','Other']
                         .map((ageGroup) => DropdownMenuItem<String>(
                       value: ageGroup,
                       child: Text(ageGroup),
                     ))
                         .toList(),
                     onChanged: (value) {
                       setState(() {
                         gender = value!;
                       });
                     },
                     decoration: InputDecoration(
                       border: OutlineInputBorder(),
                     ),
                   ),
                 ),
               ],
             ),
             SizedBox(height: 10,),
             TextFormField(
               controller: phNumController,
               keyboardType: TextInputType.number,
               cursorColor: Colors.white,
               decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   suffixIcon: Icon(Icons.edit),
                   labelText: 'WhatsApp Number',
                   labelStyle: TextStyle(color: Colors.grey)),
             ),
             SizedBox(height: 10,),
             TextFormField(
               controller: resController,
               cursorColor: Colors.white,
               decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   suffixIcon: Icon(Icons.edit),
                   labelText: 'Residence(City)',
                   labelStyle: TextStyle(color: Colors.grey)),
             ),
             SizedBox(height: 10,),
             Container(width: double.maxFinite,child: ElevatedButton(onPressed: (){
               if(nameController.text.isNotEmpty&&ageController.text.isNotEmpty&&phNumController.text.isNotEmpty &&resController.text.isNotEmpty) {
                 if (!joinTripState.getRequestStatus(widget.tripId)) {
                   createMembers(
                       widget.tripId,
                       widget.ownerId,
                       uid!,
                       'pending',
                       users[0].username,
                       nameController.text,
                       ageController.text,
                       phNumController.text,
                       resController.text,
                       gender);

                   setState(() {
                     joinTripState.updateRequestStatus(widget.tripId, true);
                   });

                   Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context) => TripsPage(),));
                 }
                 else {
                   print('Cant send request again!');
                 }
               }
               else{
                 showSnackBar('Please fill all the details!', context);
               }
             }, child: Text(joinTripState.getRequestStatus(widget.tripId)?'Requested':'Send Request')))
           ],
        ),
      ),
    );
  }
}
