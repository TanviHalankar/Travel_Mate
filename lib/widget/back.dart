import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  const BackGround({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: Image.asset(
        'assets/back.png',
        fit: BoxFit.cover, // You can adjust the BoxFit as needed
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
