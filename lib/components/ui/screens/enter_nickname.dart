import 'package:flutter/material.dart';
import 'package:vivid/components/ui/screens/main_screen.dart';

class EnterNicknameScreen extends StatefulWidget {
  EnterNicknameScreen({Key key}) : super(key: key);

  @override
  _EnterNicknameScreenState createState() => _EnterNicknameScreenState();
}

class _EnterNicknameScreenState extends State<EnterNicknameScreen> {
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            },
            child: Icon(Icons.check)
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text('Enter Nickname', style: TextStyle(
                  fontSize: 30, fontFamily: 'BloggerSans',
                  fontWeight: FontWeight.w800
                ), textAlign: TextAlign.center),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.text,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}