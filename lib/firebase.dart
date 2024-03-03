import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_any_code/bookMarkPage.dart';

CollectionReference users = FirebaseFirestore.instance.collection("Users");
FirebaseAuth auth = FirebaseAuth.instance;

Future<void> userSetup(String displayname) async {
  final uid = auth.currentUser?.uid.toString();
  // print(uid);
  // print(displayname);
  var result = await users.add({"displayName": displayname, "uid": uid});
  users.add({"DocID": result.id});
  return print(
      "added username: ${displayname} Uid: ${uid} DocID: ${result.id}");
}

Future<void> saveBookmark(title, description) async {
  var collection = FirebaseFirestore.instance
      .collection("Users")
      .where("uid", isEqualTo: auth.currentUser?.uid);

  var doc = await collection.get();
  var docID = doc.docs.first.id;
  var result = await FirebaseFirestore.instance
      .collection("Users")
      .doc(docID)
      .collection("MyBookMark")
      .where("title", isEqualTo: title)
      .get();

  var amountofData = result.docs.length;

  print("amountofData: ${result.docs.length}");
  if (amountofData == 0) {
    users
        .doc(docID)
        .collection("MyBookMark")
        .add({"title": title, "description": description, "isBooked": true});

    print("adding successful data \"$title\" at $docID");
  } else {
    print("data \"$title\" already exist ");
  }

  return;
}

Future<void> delBookmark(docID, subDocID) async {
  users.doc(docID).collection("MyBookMark").doc(subDocID).delete().then(
        (value) => print("Document deleted"),
        onError: (e) => print("Error updating document $e"),
      );
}

Future<void> saveLessons(title, description) async {
  var collection = FirebaseFirestore.instance
      .collection("Users")
      .where("uid", isEqualTo: auth.currentUser?.uid);

  var doc = await collection.get();
  var docID = doc.docs.first.id;
  var result = await FirebaseFirestore.instance
      .collection("Users")
      .doc(docID)
      .collection("MyLessons")
      .where("title", isEqualTo: title)
      .get();

  var amountofData = result.docs.length;

  print("amountofData: ${result.docs.length}");
  if (amountofData == 0) {
    users
        .doc(docID)
        .collection("MyLessons")
        .add({"title": title, "description": description, "is": true});

    print("adding data successful data : \"$title\" at $docID");
  } else {
    print("data \"$title\" already exist ");
  }

  return;
}

printDoc() async {
  var collection = FirebaseFirestore.instance
      .collection("Users")
      .where("uid", isEqualTo: auth.currentUser?.uid);

  var doc = await collection.get();
  var docID = doc.docs.first.id;
  var result = await FirebaseFirestore.instance
      .collection("Users")
      .doc(docID)
      .collection("MyBookMark")
      .where("isBooked", isEqualTo: true)
      .get();

  print("result: ${result.docs.length}");
}
