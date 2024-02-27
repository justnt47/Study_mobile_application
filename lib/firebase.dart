import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> userSetup(String displayname) async {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  FirebaseAuth auth = FirebaseAuth.instance;
  final uid = auth.currentUser?.uid.toString();
  // print(uid);
  // print(displayname);
  var result = await users.add({"displayName": displayname, "uid": uid});

  return print(
      "added username: ${displayname} Uid: ${uid} DocID: ${result.id}");
}

String getDocId() {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  FirebaseAuth auth = FirebaseAuth.instance;
  DocumentReference docRef = users.doc();
  String result = docRef.id;

  return result;
}

// Future<void> saveBookmark(String id,title,desription) async {
//   CollectionReference user = FirebaseFirestore.instance.collection("Users");
//   user.doc(id).collection("MyBookMark").add("title" : title,"desription":desription,"isBooked":true);

//   return;
// }
