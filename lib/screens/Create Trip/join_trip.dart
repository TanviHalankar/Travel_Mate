import 'package:flutter/material.dart';
class JoinTrip extends StatelessWidget {
  const JoinTrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
         children: [
           Text('Join Trip'),
           Text('Username'),
           Text('Full name '),
           Text('Age'),
           Text('Gender'),
           Text('WhatsApp Number'),
           Text('Where do you live?'),
           Text('Describe Yourself'),
           ElevatedButton(onPressed: (){}, child: Text('Send Request'))
         ],
      ),
    );
  }
}
