import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/lists.dart';
import '../search2.dart';
class NewSearch2 extends StatefulWidget {
  const NewSearch2({Key? key}) : super(key: key);

  @override
  State<NewSearch2> createState() => _NewSearch2State();
}

class _NewSearch2State extends State<NewSearch2> {
  bool showHints=true;
  TextEditingController placesController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: TextField(
                  style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 20),
                  controller: placesController,
                  onChanged: (value) {
                    // Filter the list of places based on user input
                    filteredPlaces = places
                        .where((place) =>
                        place.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                    setState(() {
                      showHints= true;
                    });
                  },
                  onSubmitted: (value) {
                    setState(() {
                      showHints = false;
                    });
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Search2(name: placesController.text.trim()),));
                  },
                  onTap: () {
                    setState(() {
                      showHints = false;
                    });

                  },
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.zero,borderSide: BorderSide(color: Colors.white)),
                      prefixIcon: Icon(Icons.search,color: Colors.grey,),
                      hintText: 'e.g. Mumbai',
                      //labelText: 'Title',
                      hintStyle: GoogleFonts.montserrat(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.grey), // Change this color
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              if(showHints==true)
                Container(
                  height: 600,
                  child: Stack(
                    fit: StackFit.loose,
                    children:[
                      Positioned(
                        left:100,
                        child: Image.network('https://img.freepik.com/free-photo/nature-beauty-revealed-coastline-turquoise-waters-generative-ai_188544-12614.jpg?size=626&ext=jpg&ga=GA1.1.2014633652.1690347742&semt=sph',
                            fit: BoxFit.cover),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.5),
                              Colors.black,
                            ],
                          ),
                        ),
                      ),
                      Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        constraints: BoxConstraints(maxHeight: 600), // Set a maximum height for the suggestions
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredPlaces.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.only(bottom: 30),
                              title: Text(filteredPlaces[index],style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 40,fontWeight: FontWeight.bold)),
                              onTap: () {
                                placesController.text = filteredPlaces[index];
                                // Set showSuggestions to false when a suggestion is selected
                                setState(() {
                                  showHints = false;
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Search2(name: placesController.text.trim()),));
                              },
                            );
                          },

                        ),
                      ),
                    ),]
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
