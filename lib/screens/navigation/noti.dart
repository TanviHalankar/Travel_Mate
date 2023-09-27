import 'package:flutter/material.dart';
class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// import 'package:flutter/material.dart';
//
// class TripCategory {
//   final String name;
//   final String imageAsset;
//   final String logoAsset;
//
//   TripCategory({
//     required this.name,
//     required this.imageAsset,
//     required this.logoAsset,
//   });
// }
//
//
//
//
// class NotificationPage extends StatelessWidget {
//   final List<TripCategory> tripCategories = [
//     TripCategory(
//       name: 'Beaches',
//       imageAsset: 'assets/beach.jpg',
//       logoAsset: 'assets/beach_logo.png',
//     ),
//     TripCategory(
//       name: 'Mountains',
//       imageAsset: 'assets/mountain.jpg',
//       logoAsset: 'assets/mountain_logo.png',
//     ),
//     TripCategory(
//       name: 'City Tours',
//       imageAsset: 'assets/city.jpg',
//       logoAsset: 'assets/city_logo.png',
//     ),
//     // Add more trip categories here
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       scrollDirection: Axis.horizontal,
//       itemCount: tripCategories.length,
//       itemBuilder: (context, index) {
//         final tripCategory = tripCategories[index];
//         return TripCategoryCard(tripCategory: tripCategory);
//       },
//     );
//   }
// }
//
// class TripCategoryCard extends StatelessWidget {
//   final TripCategory tripCategory;
//
//   TripCategoryCard({required this.tripCategory});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 160.0, // Adjust the width as needed
//       margin: EdgeInsets.all(8.0),
//       child: Card(
//         elevation: 4.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               tripCategory.imageAsset,
//               width: 80.0,
//               height: 80.0,
//               fit: BoxFit.cover,
//             ),
//             SizedBox(height: 8.0),
//             Image.asset(
//               tripCategory.logoAsset,
//               width: 40.0,
//               height: 20.0,
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               tripCategory.name,
//               style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
