import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ttravel_mate/widget/parallax_flow_delegate.dart';



class ImageCard extends StatelessWidget {
  ImageCard({
    Key? key,
    required this.size,
    required this.location,
    required this.isSelected,
  });

  final Size size;
  final Location location;
  final bool isSelected;
  final GlobalKey _pictureKey =GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: isSelected?size.height * .5:size.height*.47,
        margin: isSelected?const EdgeInsets.all(0):EdgeInsets.only(top: size.height*0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 7),
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10.0,
            )
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Flow(
              delegate: ParallaxFlowDelegate(
                scrollable: Scrollable.of(context)!,
                listItemContext: context,
                 backgroundImageKey: _pictureKey),
              children: [Image.asset(
                location.image,
                fit: BoxFit.cover, // Set BoxFit to cover the entire container
                key: _pictureKey,
              ),]
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              bottom: isSelected?0:-(size.height*.15),
              left: 0,
              right: 0,
              child: Container(
                height: size.height * .15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(location.country,style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 28,color: Colors.white)),
                      Text(location.town,style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.grey),)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Location {
  Location({
    required this.country,
    required this.town,
    required this.image,
  });
  String country, town, image;
}

List locations = [
  Location(country: 'India', town: 'treking', image: 'assets/trek.png'),
  Location(country: 'Goa', town: 'beach', image: 'assets/beach.png'),
  Location(country: 'India', town: 'culture', image: 'assets/cultural.png'),
  Location(country: 'USA', town: 'fall', image: 'assets/fall.png'),
];
