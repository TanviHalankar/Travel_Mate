// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'package:flutter/material.dart';
//
//
//
// // class Build4 extends StatefulWidget {
// //   @override
// //   _Build4State createState() => _Build4State();
// // }
// //
// // class _Build4State extends State<Build4> {
// //   String destination = '';
// //   int duration = 1;
// //   double budget = 1000;
// //
// //   // Simulated data for suggested destinations (replace with real data)
// //   List<Destination> destinations = [
// //     Destination('India', 'Taj Mahal, Agra', 2, 1000, 2000),
// //     Destination('India', 'Jaipur, Rajasthan', 3, 1200, 2500),
// //     Destination('India', 'Goa Beaches', 4, 1500, 3000),
// //     Destination('India', 'Kerala Backwaters', 5, 1800, 3500),
// //     Destination('India', 'Varanasi, Uttar Pradesh', 2, 900, 1800),
// //     Destination('India', 'Leh-Ladakh, Jammu & Kashmir', 7, 2500, 5000),
// //     Destination('India', 'Mysore, Karnataka', 2, 800, 1600),
// //     Destination('India', 'Darjeeling, West Bengal', 3, 1000, 2000),
// //     Destination('India', 'Rann of Kutch, Gujarat', 2, 900, 1800),
// //     Destination('India', 'Hampi, Karnataka', 3, 1100, 2200),
// //   ];
// //
// //
// //   List<Destination> suggestedItinerary = [];
// //
// //   void suggestItinerary() {
// //     // Simple suggestion algorithm: Filter destinations based on duration and budget
// //     suggestedItinerary = destinations
// //         .where((d) => d.duration <= duration && d.minBudget <= budget && budget>=d.maxBudget && d.country=='India')
// //         .toList();
// //     setState(() {});
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       height: 534,
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text('Where do you want to go?'),
// //             TextField(
// //               onChanged: (value) {
// //                 destination = value;
// //               },
// //               decoration: InputDecoration(
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             SizedBox(height: 16),
// //             Text('How many days do you have?'),
// //             Slider(
// //               value: duration.toDouble(),
// //               onChanged: (value) {
// //                 setState(() {
// //                   duration = value.toInt();
// //                 });
// //               },
// //               min: 1,
// //               max: 10,
// //               divisions: 9,
// //               label: '$duration days',
// //             ),
// //             SizedBox(height: 16),
// //             Text('What is your budget?'),
// //             Slider(
// //               value: budget,
// //               onChanged: (value) {
// //                 setState(() {
// //                   budget = value;
// //                 });
// //               },
// //               min: 100,
// //               max: 1000,
// //               divisions: 9,
// //               label: '\$$budget',
// //             ),
// //             SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: suggestItinerary,
// //               child: Text('Suggest Itinerary'),
// //             ),
// //             SizedBox(height: 16),
// //             Text('Suggested Itinerary:'),
// //             Expanded(
// //               child: ListView.builder(
// //                 itemCount: suggestedItinerary.length,
// //                 itemBuilder: (context, index) {
// //                   final destination = suggestedItinerary[index];
// //                   return ListTile(
// //                     title: Text(destination.name),
// //                     subtitle: Text(
// //                       'Duration: ${destination.duration} days, Budget: \$${destination.minBudget}-\$${destination.maxBudget}',
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// // class Destination {
// //   final String country;
// //   final String name;
// //   final int duration;
// //   final double minBudget;
// //   final double maxBudget;
// //
// //
// //   Destination(this.country,this.name, this.duration,this.minBudget, this.maxBudget);
// // }
//
// class Build4 extends StatefulWidget {
//   final String destination;
//   final int duration;
//   final double budget;
//   Build4({required this.destination,required this.duration,required this.budget});
//   @override
//   State<Build4> createState() => _Build4State();
// }
//
// class _Build4State extends State<Build4> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 534,
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             Text(widget.destination),
//             Image.asset(
//               'assets/beach.png', // Place your Goa image in the assets folder
//               width: double.infinity,
//               height: 250,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: 20),
//             ListTile(
//               leading: Icon(Icons.date_range),
//               title: Text('Day 1: Explore Beaches',style: GoogleFonts.montserrat(fontSize: 15)),
//               subtitle: Text('Visit beautiful beaches in North Goa like Baga and Calangute.'),
//             ),
//             Divider(),
//             ListTile(
//               leading: Icon(Icons.date_range),
//               title: Text('Day 2: Historical Sites',style: GoogleFonts.montserrat(fontSize: 15)),
//               subtitle: Text('Explore historical sites like Fort Aguada and Basilica of Bom Jesus.'),
//             ),
//             Divider(),
//             ListTile(
//               leading: Icon(Icons.date_range),
//               title: Text('Day 3: Water Sports',style: GoogleFonts.montserrat(fontSize: 15)),
//               subtitle: Text('Enjoy water sports activities in South Goa at Palolem and Colva beaches.'),
//             ),
//             Divider(),
//             ListTile(
//               leading: Icon(Icons.date_range),
//               title: Text('Day 4: Nightlife',style: GoogleFonts.montserrat(fontSize: 15)),
//               subtitle: Text('Experience the vibrant nightlife at Tito\'s Lane and Club Cubana.'),
//             ),
//             Divider(),
//             ListTile(
//               leading: Icon(Icons.date_range),
//               title: Text('Day 5: Relaxation',style: GoogleFonts.montserrat(fontSize: 15)),
//               subtitle: Text('Relax on the beach, get a massage, and savor Goan cuisine.'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttravel_mate/map/map.dart';
import 'package:ttravel_mate/screens/search2.dart';

class Build4 extends StatelessWidget {
  final String destination;
  final int duration;
  final double budget;

  Build4({
    required this.destination,
    required this.duration,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 534,
      child: SingleChildScrollView(
        child: Column(
          children: [
            //Text(widget.destination),
            Container(
              width: double.maxFinite,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.orange.withOpacity(0.4))),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage(name: 'Mumbai'),));
                }, child: Text('View Map',style: GoogleFonts.montserrat(color: Colors.white)),),
            ),
            SizedBox(height: 5,),
            Image.asset(
              'assets/Mumbai.png', // Place your Mumbai image in the assets folder
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Day 1: Explore Mumbai', style: GoogleFonts.montserrat(fontSize: 15)),
              subtitle: Text('Discover the vibrant city of Mumbai.'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Day 2: Historical Sites', style: GoogleFonts.montserrat(fontSize: 15)),
              subtitle: Text('Visit historical landmarks like Gateway of India and Chhatrapati Shivaji Terminus.'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Day 3: Beaches', style: GoogleFonts.montserrat(fontSize: 15)),
              subtitle: Text('Relax on the beautiful beaches of Mumbai, such as Juhu Beach and Versova Beach.'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Day 4: Culinary Delights', style: GoogleFonts.montserrat(fontSize: 15)),
              subtitle: Text('Savor the diverse culinary offerings of Mumbai, including street food and fine dining.'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.date_range),
              title: Text('Day 5: Shopping', style: GoogleFonts.montserrat(fontSize: 15)),
              subtitle: Text('Shop for souvenirs and fashion at popular markets like Colaba Causeway and Linking Road.'),
            ),
          ],
        ),
      ),
    );
  }
}
