import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/lists.dart';



class BuildItinerary extends StatefulWidget {
  String place;
  BuildItinerary({Key? key,required this.place}) : super(key: key);

  @override
  State<BuildItinerary> createState() => _BuildItineraryState();
}

class _BuildItineraryState extends State<BuildItinerary> {
  TextEditingController placeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 540,
      width: MediaQuery.of(context).size.width,
      child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Crafting  ',
                  style:
                      GoogleFonts.montserrat(color: Colors.white.withOpacity(0.8), fontSize: 25,fontWeight: FontWeight.w200),
                ),
                Text(
                  'Your',
                  style:
                      GoogleFonts.montserrat(color: Colors.orange.shade300, fontSize: 25,fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 100),
              child: Text(
                'Adventure.....',
                style:
                    GoogleFonts.montserrat(color: Colors.white.withOpacity(0.8), fontSize: 25,fontWeight: FontWeight.w200),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Opacity(
            //   opacity: 0.7,
            //   child: Image.asset(
            //       'assets/build_iti.png',
            //       width: 200,
            //       height: 200),
            // ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  widget.place=placeController.text;
                });
              },
              controller: placeController,
              cursorColor: Colors.white,
              style: GoogleFonts.montserrat(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.map_rounded,
                  color: Colors.grey,
                ),
                hintText: 'Where do you want to go?',
                hintStyle: GoogleFonts.montserrat(color: Colors.grey,fontSize: 15),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 335,
              color: Colors.white.withOpacity(0.1),
              child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded,color: Colors.white.withOpacity(0.5)),
                            SizedBox(
                              width: 10,
                            ),
                            Text(places[index],
                                style: GoogleFonts.montserrat(
                                    color: Colors.white.withOpacity(0.5), fontSize: 20,fontWeight: FontWeight.w400)),
                          ],
                        ),
                        //SizedBox(height: 5,),
                        Divider(color: Colors.black.withOpacity(0.2),height: 15,thickness: 1,)
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => Build2(),));
            //   },
            //   child: Container(
            //     width: 50,
            //     height: 50,
            //     decoration: BoxDecoration(
            //         color: Colors.green[300],
            //         shape: BoxShape.circle,
            //         boxShadow: [
            //           BoxShadow(
            //               color: Colors.greenAccent,
            //               blurRadius: 2,
            //               spreadRadius: 5)
            //         ]),
            //     child: Icon(Icons.double_arrow),
            //   ),
            // )
            /*Container(
              height: 400,
              child: FlutterLocationPicker(
                initPosition: LatLong(23, 89),
                selectLocationButtonStyle: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                selectLocationButtonText: 'Set Current Location',
                initZoom: 11,
                minZoomLevel: 5,
                maxZoomLevel: 16,
                trackMyPosition: true,
                onError: (e) => print(e),
                onPicked: (pickedData) {
                  print(pickedData.latLong.latitude);
                  print(pickedData.latLong.longitude);
                  print(pickedData.address);
                  print(pickedData.addressData['country']);
                },
              ),
            ),*/
          ],
      ),
    );
  }
}
