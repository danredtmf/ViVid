import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vivid/components/ui/screens/settings_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isHideDrawerButtons = false;
  IconData hideDrawerButton = Icons.arrow_drop_down;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ViVid'),
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
                fontSize: 18
              );
            },
            child: Icon(Icons.search, color: Colors.white)
          ),
        ]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueAccent
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person, size: 30),
                  ),
                  SizedBox(height: 10),
                  Text('Nickname', style: TextStyle(
                    fontSize: 22, color: Colors.white,
                    fontFamily: 'BloggerSans', fontWeight: FontWeight.w800
                  ), softWrap: false),
                  Text('email@mail.ru', style: TextStyle(
                    fontSize: 16, color: Colors.white,
                    fontFamily: 'BloggerSans'
                  ), softWrap: false),
                  Container(
                    padding: const EdgeInsets.only(left: 250),
                    child: GestureDetector(
                      child: Icon(hideDrawerButton, color: Colors.white),
                      onTap: () {
                        if (!isHideDrawerButtons) {
                          setState(() {
                            hideDrawerButton = Icons.arrow_drop_up;
                            isHideDrawerButtons = !isHideDrawerButtons;
                          });
                        } else {
                          setState(() {
                            hideDrawerButton = Icons.arrow_drop_down;
                            isHideDrawerButtons = !isHideDrawerButtons;
                          });
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            isHideDrawerButtons 
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      final User user = await _auth.currentUser;
                      if (user == null) {
                        Fluttertoast.showToast(
                          msg: "No one has signed in",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 18
                        );
                        return;
                      }
                      await _auth.signOut();
                      final String uid = user.uid;
                      Fluttertoast.showToast(
                        msg: (uid.toString() + ' has successfully signed out.'),
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.yellow,
                        textColor: Colors.black,
                        fontSize: 18
                      );
                    },
                    child: Text('Logout', style: TextStyle(
                      fontSize: 22, fontFamily: 'BloggerSans',
                      fontWeight: FontWeight.w800, color: Colors.white,
                    )),
                    color: Colors.blue,
                  )
                ]
              ),
            ) 
            : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                  child: Text('Settings', style: TextStyle(
                    fontSize: 22, fontFamily: 'BloggerSans',
                    color: Colors.grey[800], fontWeight: FontWeight.w800
                  )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}