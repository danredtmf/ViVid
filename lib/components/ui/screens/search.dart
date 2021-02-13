import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vivid/components/ui/widgets/card_profile.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }  

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var currentUserNickname = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid)
    .get().then((DocumentSnapshot documentSnapshot) => {
      documentSnapshot.data()['nickname']
    });

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
                  decoration: InputDecoration(
                      contentPadding:
                        EdgeInsets.symmetric(horizontal: 25),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: GestureDetector(child: Icon(Icons.search, color: Colors.black),
                      onTap: () { setState(() {});}),
                      border: OutlineInputBorder(
                        borderRadius:
                          BorderRadius.all(Radius.circular(15))),
                      hintStyle: new TextStyle(color: Colors.black38),
                      hintText: "Search"),
                )),
            ]),
      ),
        //actions: [
        //  FlatButton(
        //    minWidth: 10,
        //    onPressed: () {},
        //    child: Icon(Icons.check, color: Colors.white)),
        //],
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
                print(_nicknameController.text.toLowerCase());
                print(nickname.matchAsPrefix(_nicknameController.text.toLowerCase()));

                if (nickname != _nicknameController.text.toLowerCase()) {
                  if (nickname.matchAsPrefix(_nicknameController.text.toLowerCase()) != null) {
                    return CardProfile(
                      name: snapshot.data.docs[docIndex]['name'],
                      nickname: snapshot.data.docs[docIndex]['nickname'],
                    );
                  } else {
                    return Container();
                  }
                }
                
                
              },
            );
            //return new ListView(
            //  children: snapshot.data.docs.map((DocumentSnapshot document) {
            //    String nickname = document.data()['nickname'].toString();
            //    print(nickname.startsWith(_nicknameController.text));
            //
            //    if (nickname.startsWith(_nicknameController.text)){
            //      return new CardProfile(
            //        name: document.data()['name'],
            //        nickname: document.data()['nickname'],
            //      );
            //    }
            //  }).toList(),
            //);
          }
          
        }
      ),
    );
  }
}