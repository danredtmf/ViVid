import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vivid/components/ui/screens/chat.dart';
import 'package:vivid/components/ui/widgets/card_profile.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  String currentUserNickname;

  _getNickname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    currentUserNickname = prefs.getString('nickname');
  }

  @override
  void initState() {
    _getNickname();
    super.initState();
  }  

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        //title: Text('Search'),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        leading: Container(),
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 35),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(width: 15),
              GestureDetector(child: Icon(Icons.arrow_back, color: Colors.white),
              onTap: () {
                Navigator.of(context).pop();
              }),
              SizedBox(width: 10),
              Container(
                height: 40,
                width: 300,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _nicknameController,
                  onTap: () {
                    _nicknameController.selection = TextSelection.fromPosition(TextPosition(offset: _nicknameController.text.length));
                  },
                  onChanged: (_) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    contentPadding:
                      EdgeInsets.symmetric(horizontal: 25),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: GestureDetector(child: Icon(Icons.search, color: Colors.black),
                    onTap: () {
                      
                    }),
                    border: OutlineInputBorder(
                      borderRadius:
                        BorderRadius.all(Radius.circular(15))),
                    hintStyle: new TextStyle(color: Colors.black38),
                    hintText: "Search"),
                )),
            ]),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
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
              itemBuilder: (context, docIndex) {
                String nickname = snapshot.data.docs[docIndex]['nickname'];
                //print(nickname.startsWith(_nicknameController.text.toLowerCase()));
                //print(nickname != currentUserNickname);
                //print(currentUserNickname);
                //print(_nicknameController.text != '');
                if (nickname.startsWith(_nicknameController.text.toLowerCase()) 
                  && _nicknameController.text != '' && nickname != currentUserNickname) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Chat(docs: snapshot.data.docs[docIndex])));
                      },
                      child: CardProfile(
                        name: snapshot.data.docs[docIndex]['name'],
                        nickname: snapshot.data.docs[docIndex]['nickname'],
                      ),
                    );
                  } if (_nicknameController.text == '@all') {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Chat(docs: snapshot.data.docs[docIndex])));
                      },
                      child: CardProfile(
                        name: snapshot.data.docs[docIndex]['name'],
                        nickname: snapshot.data.docs[docIndex]['nickname'],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }
            );
          }
        }
      ),
    );
  }
}