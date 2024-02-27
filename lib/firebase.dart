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
  users.add({"DocID": result.id});
  return print(
      "added username: ${displayname} Uid: ${uid} DocID: ${result.id}");
}

String getDocId() {
  CollectionReference users = FirebaseFirestore.instance.collection("Users");
  FirebaseAuth auth = FirebaseAuth.instance;
  print(auth.currentUser?.uid);
  DocumentReference docRef = users.doc();
  String result = docRef.id;

  return result;
}

getid() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  var collection = FirebaseFirestore.instance
      .collection("Users")
      .where("uid", isEqualTo: auth.currentUser?.uid);

  var doc = await collection.get();
  var docID = doc.docs.first.id;
  print(docID);

  return docID;
}

// Future<void> saveBookmark(String id,title,desription) async {
//   CollectionReference user = FirebaseFirestore.instance.collection("Users");
//   user.doc(id).collection("MyBookMark").add("title" : title,"desription":desription,"isBooked":true);

//   return;
// }
