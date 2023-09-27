import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ttravel_mate/db_info.dart';
import 'package:ttravel_mate/model/users.dart' as model;


class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //sign up
  Future<String> signUpUser({
    required String uname,
    required String password,
    required String email,
    required String phnum,
    required String country,
    //required Uint8List file,
  }) async {
    String res = "Some Error occured";
    try {
      if (uname.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          phnum.isNotEmpty ||
          country.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String uid=cred.user!.uid;
        print(cred.user!.uid);


        //add user to database
        createUser(uname,password,email,phnum,country,uid);
        res = "Success";
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted';
      } else if (err.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      } else if (err.code == 'email-already-in-use') {
        res = 'Email already in Use!';
      } else {
        res = err.code;
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //logging in user

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'User not found!';
      } else if (e.code == 'wrong-password') {
        res = 'Your password is incorrect';
      } else {
        res = e.code;
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }


  //log out
  Future<void> signOut() async {
    print('Signing out...');
    await _auth.signOut();
    print('Sign out completed');
  }
}
