import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class addForm extends StatefulWidget {
  @override
  State<addForm> createState() => _addFormState();
}

class _addFormState extends State<addForm> {
  final titleController = TextEditingController();
  final descriptController = TextEditingController();

  //create "collection" for store data
  CollectionReference lesssonCollection =
      FirebaseFirestore.instance.collection("lessons");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(150, 182, 197, 1),
        title: Center(
          child: Text(
            'Example',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Column(
              children: [
                Text(
                  'New conversation',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: titleController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Add a title',
                    icon: Icon(Icons.title),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: descriptController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Start a new conversation',
                    icon: Icon(Icons.description),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    lesssonCollection.add({
                      "title": titleController.text,
                      "description": descriptController.text
                    });
                    titleController.clear();
                    descriptController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Post'),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    "Log out",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      letterSpacing: 0,
                    ),
                  ),
                  onTap: () {
                    // signUserOut();
                    Navigator.pop(context);
                  },
                  // onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
