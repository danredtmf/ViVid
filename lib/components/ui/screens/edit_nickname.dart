import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditNicknameScreen extends StatefulWidget {
  @override
  _EditNicknameScreenState createState() => _EditNicknameScreenState();
}

class _EditNicknameScreenState extends State<EditNicknameScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  var user;

  _getNickname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String prefsNickname = prefs.getString('nickname');

    print('GetSaveNickname');
    _nicknameController.text = prefsNickname;
    
  }

  _setNickname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int nicknameCounter = 0;
    user = FirebaseAuth.instance.currentUser.uid;
    _nicknameController.text = _nicknameController.text.toLowerCase();
    bool nicknameValid = RegExp(r'^[a-z0-9_]\w{3,31}').hasMatch(_nicknameController.text);
    
    bool isUnique = await FirebaseFirestore.instance.collection('users')
    .where('nickname', isEqualTo: _nicknameController.text).get()
    .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (doc['nickname'].toString() == _nicknameController.text) nicknameCounter++;
        print('${nicknameCounter.toString()}: ${doc['nickname']}');
      });
    }).then((_) {
      if (nicknameCounter == 0) return true;
      else return false;
    });
    
    if (nicknameValid && isUnique) {
      await FirebaseFirestore.instance.collection('users')
      .doc(user).update({'nickname':_nicknameController.text})
      .then((value) { print("User Updated"); })
      .catchError((error) { print("Failed to update user: $error"); });
      prefs.setString('nickname', _nicknameController.text);
      Navigator.of(context)
      .pushNamedAndRemoveUntil('/main', (route) => false);
    } else if (!nicknameValid) {
      Fluttertoast.showToast(
        msg: "Nickname does not meet requirements",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18);
    } else if (!isUnique) {
      Fluttertoast.showToast(
        msg: "Nickname is not unique",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 18);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _getNickname();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Nickname'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        actions: [
          FlatButton(
            minWidth: 10,
            onPressed: () => _setNickname(),
            child: Icon(Icons.check, color: Colors.white)
          ),
        ]
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nicknameController,
              keyboardType: TextInputType.visiblePassword,
              maxLengthEnforced: true,
              maxLength: 32,
              decoration: InputDecoration(
                hintText: 'Your Nickname',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(5))
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
"""Nickname requirements:
    - a-z, 0-9, and underscore ( _ ) are allowed
    - minimum 4 characters""",
    style: TextStyle(fontSize: 16, fontFamily: 'BloggerSans', color: Colors.grey[800])),
          ],
        ),
      ),
    );
  }
}