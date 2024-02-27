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

/* Future<void> saveBookmark(String displayname) async {
  CollectionReference user = FirebaseFirestore.instance.collection("Users");
  DocumentReference BookRef = user.collection("Users").document
  FirebaseAuth auth = FirebaseAuth.instance;
  final uid = auth.currentUser?.uid.toString();
  // print(uid);
  // print(displayname);
  bookmarkRef.add({"displayName": displayname, "uid": uid});

  return;
} */
