// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../screens/navigation.dart';
//
//
//
// class SignIn extends StatefulWidget {
//   //String phone;
//   //String email;
//   //String uname;
//   //SignIn({Key? key,required this.phone, required this.email,required this.uname}) : super(key: key);
//   const SignIn({Key? key}) : super(key: key);
//
//   @override
//   State<SignIn> createState() => _SignInState();
// }
//
// class _SignInState extends State<SignIn> {
//   TextEditingController uname=TextEditingController();
//   TextEditingController email=TextEditingController();
//   TextEditingController phone=TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 150),
//               child: Center(
//                   child: Text('SIGN-IN',
//                     style: GoogleFonts.aBeeZee(
//                         fontSize: 35,
//                         fontWeight: FontWeight.bold
//                     ),
//                   )
//               ),
//             ),
//
//             Padding(
//               padding: const EdgeInsets.only(top: 100.0,right: 20.0,left: 20.0),
//               child: Column(
//                 children: [
//                   TextFormField(
//                     decoration: InputDecoration(
//                         hintText: 'User Name',
//                         prefixIcon: Icon(Icons.email_outlined,),
//                         enabledBorder:OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey.shade600
//                           ),
//                         ) ,
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey.shade600
//                           ),
//                         )
//                     ),
//                     controller: uname,
//                     validator: (String? value) {
//                       if (value != null && value.isEmpty) {
//                         return "Username can't be empty";
//                       }
//                       return null;
//                     },
//                   ),
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: email,
//                     decoration: InputDecoration(
//                         hintText: 'Email',
//                         prefixIcon: Icon(Icons.email_outlined,),
//                         enabledBorder:OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey.shade600
//                           ),
//                         ) ,
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey.shade600
//                           ),
//                         )
//                     ),
//                     validator: (String? value) {
//                       if (value != null && value.isEmpty) {
//                         return "Username can't be empty";
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 20),
//                   TextFormField(
//                     controller: phone,
//                     decoration: InputDecoration(
//                         hintText: 'Phone Number',
//                         prefixIcon: Icon(Icons.phone),
//                         enabledBorder:OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey.shade600
//                           ),
//                         ) ,
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(
//                               color: Colors.grey.shade600
//                           ),
//                         )
//                     ),
//                     validator: (String? value) {
//                       if (value != null && value.isEmpty) {
//                         return "Username can't be empty";
//                       }
//                       return null;
//                     },
//                   ),
//
//                   SizedBox(height: 20),
//                   SizedBox(
//                       width: 300.0,
//                       child: ElevatedButton(onPressed: (){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => Navigation()),
//                         );
//                       },
//                           child: Text('SIGNIN')
//                       )
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//
//   }
// }
