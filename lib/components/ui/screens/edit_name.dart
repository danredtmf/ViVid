import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditNameScreen extends StatefulWidget {
  @override
  _EditNameScreenState createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  final TextEditingController _nameController = TextEditingController();
  var user;

  _getName() async {
    user = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance.collection('users').doc(user).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        _nameController.text = documentSnapshot.data()['name'].toString();
      }
    });
  }

  _setName() async {
    user = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance.collection('users')
      .doc(user).update({'name':_nameController.text})
      .then((value) { print("User Updated"); })
      .catchError((error) { print("Failed to update user: $error"); });
      Navigator.of(context)
      .pushNamedAndRemoveUntil('/main', (route) => false);
  }

  @override
  void initState() {
    _getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Name'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          FlatButton(
            minWidth: 10,
            onPressed: () => _setName(),
            child: Icon(Icons.check, color: Colors.white)),
        ]),
      body: Container(
        margin: EdgeInsets.all(20),
        child: TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Your Name',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
              borderRadius: BorderRadius.all(Radius.circular(5))),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
        ),
      ),
    );
  }
}
