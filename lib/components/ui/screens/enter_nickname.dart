import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EnterNicknameScreen extends StatefulWidget {
  EnterNicknameScreen({Key key}) : super(key: key);

  final users = FirebaseFirestore.instance.collection('users');

  @override
  _EnterNicknameScreenState createState() => _EnterNicknameScreenState();
}

class _EnterNicknameScreenState extends State<EnterNicknameScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void _checkOrEnterNickname() async {
    _nicknameController.text = _nicknameController.text.toLowerCase();
    bool nicknameValid =
        RegExp(r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$').hasMatch(_nicknameController.text);

    if (nicknameValid) {
      print(_nicknameController.text.toString() +
          ' is ' +
          nicknameValid.toString());
      if (_nameController.text.isNotEmpty) {
        print(_nameController.text.isNotEmpty.toString());
        _createUser();
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/main', (route) => false);
      } else {
        Fluttertoast.showToast(
          msg: "Name is required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18);
      }
    } else {
      print(_nicknameController.text.toString() +
          ' is ' +
          nicknameValid.toString());
      Fluttertoast.showToast(
        msg: "Nickname does not meet requirements",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18);
    }
  }

  void _createUser() async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    await widget.users
        .doc(firebaseUser.uid)
        .set({
          'id': firebaseUser.uid,
          'nickname': _nicknameController.text,
          'name': _nameController.text,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(),
        actions: [
          FlatButton(
            minWidth: 10,
            onPressed: () => _checkOrEnterNickname(),
            child: Icon(Icons.check)),
        ],
      ),
      body: Container(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Enter Nickname',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'BloggerSans',
                    fontWeight: FontWeight.w800,
                    color: Colors.grey[800]
                  ),
                  textAlign: TextAlign.center),
                SizedBox(height: 10),
                TextField(
                  controller: _nicknameController,
                  keyboardType: TextInputType.visiblePassword,
                  maxLengthEnforced: true,
                  maxLength: 32,
                  decoration: const InputDecoration(
                    hintText: 'Your Nickname',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
                Text("""Nickname requirements:
    - Requires minimum 3 character
    - Allowing "_" and "." in middle of name""",
    style: TextStyle(fontSize: 16, fontFamily: 'BloggerSans', color: Colors.grey[800])),
                SizedBox(height: 10),
                Text('Enter Name',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'BloggerSans',
                    fontWeight: FontWeight.w800,
                    color: Colors.grey[800]
                  ),
                  textAlign: TextAlign.center),
                SizedBox(height: 10),
                TextField(
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Your Name (necessarily)',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                        BorderSide(color: Colors.blueAccent, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
