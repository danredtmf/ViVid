import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MainScreen extends StatefulWidget {
  final users = FirebaseFirestore.instance.collection('users');

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String nickname = '', name = '';
  bool isHideDrawerButtons = false;
  IconData hideDrawerButton = Icons.arrow_drop_down;

  _getData(BuildContext context) async {
    var firebaseUser = _auth.currentUser;
    DocumentSnapshot doc;

    try {
      doc = await widget.users.doc(firebaseUser.uid).get();
      nickname = doc.data()['nickname'].toString();
      name = doc.data()['name'].toString();
      setState(() {});
    } on NoSuchMethodError catch(e) {
      print(e);
      Navigator.of(context)
        .pushNamedAndRemoveUntil('/enter_nickname', (route) => false);
    } on FlutterError catch(e) {
      print("FlutterError: "+e.toString());
    }
  }

  @override
  void initState() {
    _getData(context);
    super.initState();
  }

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
                fontSize: 18);
            },
            child: Icon(Icons.search, color: Colors.white)),
        ]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    radius: 30,
                    child: Icon(Icons.person, size: 30),
                  ),
                  SizedBox(height: 10),
                  Text(name,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontFamily: 'BloggerSans',
                      fontWeight: FontWeight.w800),
                    softWrap: false),
                  Text(nickname,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'BloggerSans'),
                    softWrap: false),
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
                            final User user = _auth.currentUser; // здесь был await
                            if (user == null) {
                              Fluttertoast.showToast(
                                msg: "No one has signed in",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 18);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/welcome', (route) => false);
                            }
                            await _auth.signOut();
                            Fluttertoast.showToast(
                              msg: (nickname +
                                  ' has successfully signed out.'),
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.yellow,
                              textColor: Colors.black,
                              fontSize: 18);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/welcome', (route) => false);
                          },
                          child: Text('Logout',
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'BloggerSans',
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            )),
                          color: Colors.blue,
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/settings');
                          },
                          child: Text('Settings',
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'BloggerSans',
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w800)),
                        ),
                      ]),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/settings');
                        },
                        child: Text('Settings',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'BloggerSans',
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w800)),
                      ),
                    ],
                )
          ],
        ),
      ),
    );
  }
}
