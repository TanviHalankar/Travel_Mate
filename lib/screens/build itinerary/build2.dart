import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'build3.dart';


class Build2 extends StatefulWidget {
  const Build2({Key? key}) : super(key: key);

  @override
  _Build2State createState() => _Build2State();
}

class _Build2State extends State<Build2> {
  int selectedIndex = -1;

  void selectCard(int index) {
    setState(() {
      if (selectedIndex == index) {
        selectedIndex = -1; // Deselect if already selected
      } else {
        selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 534,
      width: MediaQuery.of(context).size.width,
      child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Choose  ',
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
                'TravelMate.....',
                style:
                GoogleFonts.montserrat(color: Colors.white.withOpacity(0.8), fontSize: 25,fontWeight: FontWeight.w200),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10,top: 10),
            //   child: Container(height: 150,width: 150,child: Image(image: AssetImage('assets/companion.png'),)),
            // ),
            SizedBox(height: 70,),
            Container(
              //color: Colors.white.withOpacity(0.2),
              height: 320,
              width: 320,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return MyCard(
                    text: cardData[index]['text'],
                    icon: cardData[index]['icon'],
                    image: cardData[index]['image'],
                    isSelected: selectedIndex == index,
                    onTap: () => selectCard(index),
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
            // if (selectedIndex != -1)
            //   InkWell(
            //     onTap: () {
            //       Navigator.push(context, MaterialPageRoute(builder: (context) => Build3(),));
            //     },
            //     child: Container(
            //       width: 40,
            //       height: 40,
            //       decoration: BoxDecoration(
            //           color: Colors.orangeAccent[300],
            //           shape: BoxShape.circle,
            //           boxShadow: [
            //             BoxShadow(
            //                 color: Colors.deepOrangeAccent,
            //                 blurRadius: 2,
            //                 spreadRadius: 5)
            //           ]),
            //       child: Icon(Icons.double_arrow),
            //     ),
            //   )
          ],
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final text;
  final icon;
  final image;
  final bool isSelected;
  final VoidCallback onTap;

  MyCard({Key? key, required this.text, this.icon, this.image, required this.isSelected, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? Colors.blueGrey.shade100 : Colors.white.withOpacity(0.2),
        elevation: 4,
        //shadowColor: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null ? Icon(icon, color: Colors.black) : Image(image: image, height: 30),
            SizedBox(height: 10),
            Text(text, style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}

final cardData = [
  {'text': 'SOLO', 'icon': Icons.person_outline, 'image': null},
  {'text': 'PARTNER', 'icon': Icons.favorite_border, 'image': null},
  {'text': 'FRIENDS', 'icon': null, 'image': AssetImage('assets/friend.png')},
  {'text': 'FAMILY', 'icon': null, 'image': AssetImage('assets/fam.png')},
];
