import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String name;
  final LatLng location;
  final String imageUrl;
  final String description;

  Place({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.description,
  });
}

class MapPage extends StatefulWidget {
  final String name;
  const MapPage({Key? key, required this.name}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(19.0760, 72.8777), // Mumbai's coordinates
    zoom: 12.0,
  );

  Set<Marker> _markers = Set<Marker>();
  Place? _selectedPlace; // Variable to store the selected place
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _addPopularPlaceMarkers();
  }

  void _showPlaceDetails(Place place) {
    // Update the selected place
    setState(() {
      _selectedPlace = place;
    });

    // Scroll to the bottom sheet to focus on the selected place's data
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _addPopularPlaceMarkers() {
    List<Place> popularPlaces = [
      Place(
        name: 'Gateway of India',
        location: LatLng(18.9220, 72.8347),
        imageUrl:
        'https://images.unsplash.com/photo-1598434192043-71111c1b3f41?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Z2F0ZXdheSUyMG9mJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60',
        description: 'Historic monument and tourist attraction.',
      ),
    Place(
        name: 'Chhatrapati Shivaji Terminus',
        location: LatLng(18.9401, 72.8357),
        imageUrl: 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSi556ab59IbLFw8fNg57E5VONI66KBXQBY_wXYt4cxb9gEZYDshkr0I3ZEO8Nlg8bC_YxYikHVVZw52LO2knKRZw',
        description: 'Historic railway station.',
      ),
      Place(
        name: 'Marine Drive',
        location: LatLng(18.9438, 72.8235),
        imageUrl: 'https://images.unsplash.com/photo-1567870374047-3f9db5c06b16?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8TWFyaW5lJTIwRHJpdmV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60',
        description: 'Iconic promenade by the Arabian Sea.',
      ),
      Place(
        name: 'Siddhivinayak Temple',
        location: LatLng(19.0265, 72.8487),
        imageUrl: 'https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcQ7YY7AkRzQ1xyUu1fphuUNdbW9D1Jrdy7B-i_mGZlzz0m3wUrX7xgEbq1WbTI22faEFIxCH4cKIwpjmWC0_VgDgg',
        description: 'Famous Hindu temple dedicated to Lord Ganesha.',
      ),
      Place(
        name: 'Haji Ali Dargah',
        location: LatLng(18.9770, 72.8104),
        imageUrl: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRec9w0b_bRFJRYmoq02Ku1R6aCW5jJmwDM-6sDKWEu9Ere4U5px3ijqDHquHEFW5bAcCvFil30lHfc0yReKIUhNQ',
        description: 'Historic mosque and tomb located in the Arabian Sea.',
      ),
      Place(
        name: 'Juhu Beach',
        location: LatLng(19.0882, 72.8265),
        imageUrl: 'https://images.unsplash.com/photo-1580742092409-ef70c2ce0d89?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8anVodSUyMGJlYWNofGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60',
        description: 'Popular beach destination in Mumbai.',
      ),
      Place(
        name: 'Elephanta Caves',
        location: LatLng(18.9647, 72.9303),
        imageUrl: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcT6g2guinXc9yYmkOttBeiuezG4HuoOSjQg6UwZ3zGbo88QX_d6TOy2VzS6DUjRuTJz7IXUC7qzln68hAweb_notw',
        description: 'Ancient rock-cut cave temples.',
      ),
      Place(
        name: 'Chowpatty Beach',
        location: LatLng(18.9542, 72.8135),
        imageUrl: 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQZTJafhIJ7b5JAOGNT8e9gXnrM9q9uar4CwsSXDR_Tp4UqSVNp2813CtIQfuyrVKCRPK_gvkfkpAWeMD0Olg3S8g',
        description: 'Famous beach known for street food.',
      ),
      Place(
        name: 'Sanjay Gandhi National Park',
        location: LatLng(19.2146, 72.9106),
        imageUrl: 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQIlBioYQxvLjdqz16ldi0YCO5CJVD4tx5HW3eaf1baXF_LoJp-Q1x3cfI-vVYGgTt5lzLkLtg2W8xB7YXLAwA9_w',
        description: 'Large protected area with diverse flora and fauna.',
      ),
      Place(
        name: 'Colaba Causeway',
        location: LatLng(18.9159, 72.8262),
        imageUrl: 'https://images.unsplash.com/photo-1647266284234-9e441bd53a8d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Q29sYWJhJTIwQ2F1c2V3YXl8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60',
        description: 'Shopping and culinary street in Mumbai.',
      ),
      Place(
        name: 'Nehru Science Centre',
        location: LatLng(19.0089, 72.8152),
        imageUrl: 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQMyL9aqBBlPn9LmYL27DFgm2Bf4P9e2VzxRQwuTQKsDr2kXfhNOvS7S-9GLx1vlbVFUXI0EOcaTOny-rasli1zbw',
        description: 'Interactive science museum.',
      ),
      // Add more places here...
    ];

    for (int i = 0; i < popularPlaces.length; i++) {
      Place place = popularPlaces[i];

      Marker marker = Marker(
        markerId: MarkerId('PopularPlace$i'),
        position: place.location,
        infoWindow: InfoWindow(
          title: place.name,
          snippet: place.description,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        onTap: () {
          _showPlaceDetails(place);
        },
      );

      _markers.add(marker);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.maxFinite,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers,
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.05, // Initial size of the bottom sheet
            minChildSize: 0.05, // Minimum size when fully collapsed
            maxChildSize: 0.4,
            builder: (context, scrollController) {
              return Stack(
                  alignment: AlignmentDirectional.topCenter,
                  clipBehavior: Clip.none,
                children:[
                  Positioned(
                      top: -15,
                      child: Container(
                        width: 60,
                        height: 7,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black.withOpacity(0.8)),
                      )),
                  Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      if (_selectedPlace != null) // Check if a place is selected
                        Container(
                          padding: EdgeInsets.only(left: 16,right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _selectedPlace!.name,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  textStyle: GoogleFonts.montserrat(color: Colors.white)
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Image.network(
                                    _selectedPlace!.imageUrl,
                                    height: 170,
                                    width: 170,
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _selectedPlace!.description,
                                      style: GoogleFonts.montserrat(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w200),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              // ElevatedButton(
                              //   onPressed: () {
                              //     setState(() {
                              //       _selectedPlace = null; // Clear the selected place
                              //     });
                              //   },
                              //   child: Text('Close'),
                              // ),
                            ],
                          ),
                        ),
                      // ... Other content in the bottom sheet
                    ],
                  ),
                ),]
              );
            },
          ),
        ],
      ),
    );
  }
}


// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class Place {
//   final String name;
//   final LatLng location;
//   final String imageUrl;
//   final String description;
//
//   Place({
//     required this.name,
//     required this.location,
//     required this.imageUrl,
//     required this.description,
//   });
// }
//
// class MapPage extends StatefulWidget {
//   final String name;
//   const MapPage({Key? key, required this.name}) : super(key: key);
//
//   @override
//   State<MapPage> createState() => _MapPageState();
// }
//
// class _MapPageState extends State<MapPage> {
//   final Completer<GoogleMapController> _controller =
//   Completer<GoogleMapController>();
//
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(19.0760, 72.8777), // Mumbai's coordinates
//     zoom: 12.0,
//   );
//
//   Set<Marker> _markers = Set<Marker>();
//
//   @override
//   void initState() {
//     super.initState();
//     _addPopularPlaceMarkers();
//   }
//
//   void _showPlaceDetails(Place place) {
//     showModalBottomSheet(
//       context: context,
//       builder: (context) {
//         return Container(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 place.name,
//                 style: GoogleFonts.montserrat(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 8),
//               Row(
//                 children: [
//                   Image.network(place.imageUrl,height: 150,width: 150),
//                   SizedBox(width: 8),
//                   Container(width: 170,child: Text(place.description)),
//                 ],
//               ),
//               // SizedBox(height: 16),
//               // ElevatedButton(
//               //   onPressed: () {
//               //     Navigator.of(context).pop();
//               //   },
//               //   child: Text('Close'),
//               // ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   void _addPopularPlaceMarkers() {
//     List<Place> popularPlaces = [
//       Place(
//         name: 'Gateway of India',
//         location: LatLng(18.9220, 72.8347),
//         imageUrl:
//         'https://images.unsplash.com/photo-1598434192043-71111c1b3f41?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Z2F0ZXdheSUyMG9mJTIwaW5kaWF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60', // Replace with actual image URL
//         description: 'Historic monument and tourist attraction.',
//       ),
//       Place(
//         name: 'Chhatrapati Shivaji Terminus',
//         location: LatLng(18.9401, 72.8357),
//         imageUrl: 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSi556ab59IbLFw8fNg57E5VONI66KBXQBY_wXYt4cxb9gEZYDshkr0I3ZEO8Nlg8bC_YxYikHVVZw52LO2knKRZw',
//         description: 'Historic railway station.',
//       ),
//       Place(
//         name: 'Marine Drive',
//         location: LatLng(18.9438, 72.8235),
//         imageUrl: 'https://images.unsplash.com/photo-1567870374047-3f9db5c06b16?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8TWFyaW5lJTIwRHJpdmV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=600&q=60',
//         description: 'Iconic promenade by the Arabian Sea.',
//       ),
//       Place(
//         name: 'Siddhivinayak Temple',
//         location: LatLng(19.0265, 72.8487),
//         imageUrl: 'https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcQ7YY7AkRzQ1xyUu1fphuUNdbW9D1Jrdy7B-i_mGZlzz0m3wUrX7xgEbq1WbTI22faEFIxCH4cKIwpjmWC0_VgDgg',
//         description: 'Famous Hindu temple dedicated to Lord Ganesha.',
//       ),
//       Place(
//         name: 'Haji Ali Dargah',
//         location: LatLng(18.9770, 72.8104),
//         imageUrl: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcRec9w0b_bRFJRYmoq02Ku1R6aCW5jJmwDM-6sDKWEu9Ere4U5px3ijqDHquHEFW5bAcCvFil30lHfc0yReKIUhNQ',
//         description: 'Historic mosque and tomb located in the Arabian Sea.',
//       ),
//       Place(
//         name: 'Juhu Beach',
//         location: LatLng(19.0882, 72.8265),
//         imageUrl: 'https://images.unsplash.com/photo-1580742092409-ef70c2ce0d89?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8anVodSUyMGJlYWNofGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60',
//         description: 'Popular beach destination in Mumbai.',
//       ),
//       Place(
//         name: 'Elephanta Caves',
//         location: LatLng(18.9647, 72.9303),
//         imageUrl: 'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcT6g2guinXc9yYmkOttBeiuezG4HuoOSjQg6UwZ3zGbo88QX_d6TOy2VzS6DUjRuTJz7IXUC7qzln68hAweb_notw',
//         description: 'Ancient rock-cut cave temples.',
//       ),
//       Place(
//         name: 'Chowpatty Beach',
//         location: LatLng(18.9542, 72.8135),
//         imageUrl: 'assets/chowpatty_beach.png',
//         description: 'Famous beach known for street food.',
//       ),
//       Place(
//         name: 'Sanjay Gandhi National Park',
//         location: LatLng(19.2146, 72.9106),
//         imageUrl: 'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQIlBioYQxvLjdqz16ldi0YCO5CJVD4tx5HW3eaf1baXF_LoJp-Q1x3cfI-vVYGgTt5lzLkLtg2W8xB7YXLAwA9_w',
//         description: 'Large protected area with diverse flora and fauna.',
//       ),
//       Place(
//         name: 'Colaba Causeway',
//         location: LatLng(18.9159, 72.8262),
//         imageUrl: 'assets/colaba_causeway.png',
//         description: 'Shopping and culinary street in Mumbai.',
//       ),
//       Place(
//         name: 'Nehru Science Centre',
//         location: LatLng(19.0089, 72.8152),
//         imageUrl: 'assets/nehru_science_centre.png',
//         description: 'Interactive science museum.',
//       ),
//       // Add more places here...
//     ];
//
//     for (int i = 0; i < popularPlaces.length; i++) {
//       Place place = popularPlaces[i];
//
//       Marker marker = Marker(
//         markerId: MarkerId('PopularPlace$i'),
//         position: place.location,
//         infoWindow: InfoWindow(
//           title: place.name,
//           snippet: place.description,
//         ),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//         onTap: () {
//           _showPlaceDetails(place);
//         },
//       );
//
//       _markers.add(marker);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [GoogleMap(
//           mapType: MapType.normal,
//           initialCameraPosition: _kGooglePlex,
//           onMapCreated: (GoogleMapController controller) {
//             _controller.complete(controller);
//           },
//           markers: _markers,
//         ),
//           DraggableScrollableSheet(
//             initialChildSize: 0.3, // Initial size of the bottom sheet
//             minChildSize: 0.1, // Minimum size when fully collapsed
//             builder: (context, scrollController) {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                 ),
//                 child: ListView.builder(
//                   controller: scrollController,
//                   itemCount: 10, // Replace with your content
//                   itemBuilder: (BuildContext context, int index) {
//                     return ListTile(
//                       title: Text('Item $index'),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//       ]
//       ),
//
//     );
//   }
// }
