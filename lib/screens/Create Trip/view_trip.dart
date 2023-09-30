import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ttravel_mate/screens/Create%20Trip/join_trip.dart';
import 'package:http/http.dart' as http;

import '../../db_info.dart';
import '../../model/trips.dart';
class ViewTrip extends StatefulWidget {
  int tripId;
  ViewTrip({Key? key,required this.tripId}) : super(key: key);

  @override
  State<ViewTrip> createState() => _ViewTripState();
}
class _ViewTripState extends State<ViewTrip> {
  late Future <Trips> futureTrip;

  Future<Trips> fetchTripById(String tripId) async {
    final response = await http.get(Uri.parse('http://$ip:9000/trips/$tripId'));
    if (response.statusCode == 200) {
      final dynamic tripData = json.decode(response.body);
      return Trips.fromJson(tripData);
    } else {
      throw Exception('Failed to load trip with ID: $tripId');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureTrip = fetchTripById('${widget.tripId}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<Trips>(
        future: futureTrip,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            Trips trip = snapshot.data!;
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('http://$ip:9000/${trip.coverPhoto}'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                // Display other details about the trip here using Text widgets or other UI components
                // For example:
                // Text('Trip Title: ${trip.title}'),
                // Text('Trip Description: ${trip.desc}'),
                // Text('Trip Start Date: ${trip.startDate}'),
                // ...
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => JoinTrip(),));
                  },
                  child: Text('Join Trip'),
                ),
              ],
            );
          }
        },
      ),
      // Column(
      //   children: [
      //     Text('Cover photo'),
      //     Text('Trip Title'),
      //     Text('Trip Desc'),
      //     Text('Trip start and end date'),
      //     Text('Total Members'),
      //     Text('Trip itinerary'),
      //     Text('Age Group'),
      //     ElevatedButton(onPressed: (){
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => JoinTrip(),));
      //     }, child: Text('Join Trip'))
      //   ],
      // ),
    );
  }
}
