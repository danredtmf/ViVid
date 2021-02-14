import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chat extends StatefulWidget {
  final docs;

  Chat({Key key, this.docs});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String groupChatId;
  String userId;

  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getGroupChatId();
    super.initState();
  }

  getGroupChatId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String anotherUserId;

    userId = prefs.getString('id');
    try {
      anotherUserId = widget.docs['id'];
      if (userId.compareTo(anotherUserId) > 0) {
        groupChatId = '$userId - $anotherUserId';
      } else {
        groupChatId = '$anotherUserId - $userId';
      }
    setState(() {});
    } on NoSuchMethodError catch(e) {
      print("NoSuchMethodError anotherUserId: ${e.toString()}");
    }
  }

  notifyUsers(msg) {

    var userSender = FirebaseFirestore.instance.collection('users')
    .doc(userId).collection('messages').doc(groupChatId);

    var userListener = FirebaseFirestore.instance.collection('users')
    .doc(widget.docs['id']).collection('messages').doc(groupChatId);

    userSender.set({
      'last_msg': msg,
      'id': widget.docs['id'],
      'name': widget.docs['name'],
    })
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));

    userListener.set({
      'last_msg': msg,
      'id': widget.docs['id'],
      'name': widget.docs['name'],
    })
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));

  }

  sendMsg() {
    String msg = textEditingController.text.trim();

    notifyUsers(msg);

    if (msg.isNotEmpty) {
      var ref = FirebaseFirestore.instance.collection('messages')
      .doc(groupChatId).collection(groupChatId).doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(ref, {
          'senderId': userId,
          'anotherUserId': widget.docs['id'],
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'content': msg,
          'type': 'text',
        });
      });

      textEditingController.clear();
      scrollController.animateTo(0, duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
    } else {
      print('Enter text!');
    }
  }

  buildItem(doc) {
    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        left: ((doc['senderId'] == userId) ? 64 : 0),
        right: ((doc['senderId'] == userId) ? 0 : 64),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ((doc['senderId'] == userId) ? Colors.grey : Colors.greenAccent),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text('${doc['content']}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('${widget.docs['name']}', softWrap: false),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('messages')
        .doc(groupChatId).collection(groupChatId)
        .orderBy('timestamp', descending: true).snapshots(),
        builder: (context, snapshots) {
          if (snapshots.hasData && snapshots.data != null) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemBuilder: (listContext, index) => buildItem(snapshots.data.docs[index]),
                    itemCount: snapshots.data.docs.length, reverse: true,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () => sendMsg(),
                    )
                  ],
                ),
              ],
            );
          } else {
            return Center(
              child: SizedBox(
                height: 36,
                width: 36,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}