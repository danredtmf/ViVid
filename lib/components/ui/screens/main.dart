import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vivid/components/theme/AppStateNotifier.dart';
import 'package:vivid/components/ui/screens/chat.dart';
import 'package:vivid/components/ui/widgets/card_chat.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class MainScreen extends StatefulWidget {
  final users = FirebaseFirestore.instance.collection('users');

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String nickname = '', name = '', id = '';
  bool isHideDrawerButtons = false;
  IconData hideDrawerButton = Icons.arrow_drop_down;

  List<DocumentSnapshot> idChatsList = List<DocumentSnapshot>();

  _getData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String prefsNickname = prefs.getString('nickname');
    String prefsName = prefs.getString('name');

    var firebaseUser = _auth.currentUser;
    DocumentSnapshot doc;

    try {
      setState(() {});
      doc = await widget.users.doc(firebaseUser.uid).get();
      if (prefsNickname != doc.data()['nickname'].toString() && prefsName != doc.data()['name'].toString()) {
        await prefs.setString('nickname', doc.data()['nickname'].toString());
        await prefs.setString('name', doc.data()['name'].toString());
        await prefs.setString('id', firebaseUser.uid);

        nickname = prefs.getString('nickname');
        name = prefs.getString('name');
        id = prefs.getString('id');

        setState(() {});
      } else {
        nickname = prefs.getString('nickname');
        name = prefs.getString('name');

        setState(() {});
      }
    } on NoSuchMethodError catch(e) {
      print(e);
      Navigator.of(context)
        .pushNamedAndRemoveUntil('/enter_nickname', (route) => false);
    } on FlutterError catch(e) {
      print("FlutterError: "+e.toString());
    }
  }

  _getDocUser(int index, String id) {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
                if (doc.id == id) {
                  idChatsList.insert(index, doc);
                }
            });
          });
    } on NoSuchMethodError catch(e) {
      print("NoSuchMethodError _getDocUser: "+e.toString());
    }
  }

  @override
  void initState() {
    _getData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference messages = FirebaseFirestore.instance.collection('users').doc(_auth.currentUser.uid)
    .collection('messages');

    return Consumer<AppStateNotifier>(
      builder: (context, appState, child) => Scaffold(
        backgroundColor: appState.isDarkModeOn ? Colors.black : Colors.white,
        appBar: AppBar(
          title: Text('ViVid'),
          backgroundColor: appState.isDarkModeOn ? Colors.white12 : Colors.blueAccent,
          elevation: 0,
          actions: [
            FlatButton(
              minWidth: 10,
              onPressed: () {
                Navigator.of(context).pushNamed('/search');
              },
              child: Icon(Icons.search, color: Colors.white)),
          ]),
        drawer: Drawer(
          child: Container(
            color: appState.isDarkModeOn ? Colors.black87 : Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(color: appState.isDarkModeOn ? Colors.white10 : Colors.blueAccent),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: appState.isDarkModeOn ? Colors.grey : Colors.blueAccent[400],
                        child: Icon(Icons.person, size: 30, color: Colors.white,),
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
                    ? Container(
                      child: Padding(
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
                                    color: appState.isDarkModeOn ? Colors.grey : Colors.white,
                                  )),
                                color: appState.isDarkModeOn ? Colors.grey[800] : Colors.blueAccent,
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/settings');
                                },
                                child: Text('Settings',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: 'BloggerSans',
                                    color: appState.isDarkModeOn ? Colors.grey : Colors.grey[800],
                                    fontWeight: FontWeight.w800)),
                              ),
                            ]),
                        ),
                    )
                    : Container(
                      child: Column(
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
                                  color: appState.isDarkModeOn ? Colors.grey : Colors.grey[800],
                                  fontWeight: FontWeight.w800)),
                            ),
                          ],
                      ),
                    )
              ],
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: messages.snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Ошибка!'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text('Загрузка...'));
            }
            if (!snapshot.hasData) {
              return Center(child: Text('Пусто'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  _getDocUser(index, snapshot.data.docs[index].id);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => 
                      Chat(docs: idChatsList[index])));
                    },
                    child: CardChat(
                      name: snapshot.data.docs[index]['name'],
                      text: snapshot.data.docs[index]['last_msg'],
                    ),
                  );
                },
              );
            }
          },
        ),
      )
    );
  }
}
