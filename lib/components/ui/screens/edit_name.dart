import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditNameScreen extends StatefulWidget {
  @override
  _EditNameScreenState createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
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
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "Doesn't work yet",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.yellow,
                      textColor: Colors.black,
                      fontSize: 18);
                },
                child: Icon(Icons.check, color: Colors.white)),
          ]),
      body: Container(
        margin: EdgeInsets.all(20),
        child: TextField(
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
