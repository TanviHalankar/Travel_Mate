import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  const BackGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.2,
      child: Image.network(
        //'assets/back.png',
        //'https://img.freepik.com/free-vector/travel-pattern-background_23-2148043439.jpg?size=626&ext=jpg&ga=GA1.2.2014633652.1690347742&semt=ais',
        'https://img.freepik.com/free-photo/one-person-standing-cliff-achieving-success-generated-by-ai_188544-11834.jpg',

        fit: BoxFit.cover, // You can adjust the BoxFit as needed
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
