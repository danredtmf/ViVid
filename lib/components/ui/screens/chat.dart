import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vivid/components/ui/widgets/message_form.dart';
import 'package:vivid/components/ui/widgets/message_wall.dart';

class Chat extends StatefulWidget {
  final docs;

  Chat({Key key, this.docs});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String groupChatId;
  String userId;
  
  String senderName;

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
    senderName = prefs.getString('name');
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

  notifyUsers(String msg) {
    var userSender = FirebaseFirestore.instance.collection('users')
    .doc(userId).collection('messages').doc(widget.docs['id']);

    var userListener = FirebaseFirestore.instance.collection('users')
    .doc(widget.docs['id']).collection('messages').doc(userId);

    userSender.set({
      'name': widget.docs['name'],
      'last_msg': msg,
    })
    .then((value) => print("userSender Notified"))
    .catchError((error) => print("Failed userSender Notified: $error"));

    userListener.set({
      'name': senderName,
      'last_msg': msg,
    })
    .then((value) => print("userListener Notified"))
    .catchError((error) => print("Failed userListener Notified: $error"));

  }

  sendMsg(String msg) async {
    notifyUsers(msg);

    if (msg.isNotEmpty) {
      var ref = FirebaseFirestore.instance.collection('messages')
      .doc(groupChatId).collection(groupChatId).doc(DateTime.now().millisecondsSinceEpoch.toString());

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(ref, {
          'senderId': userId,
          'anotherUserId': widget.docs['id'],
          'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
          'content': msg,
          'type': 'text',
        });
      });
    } else {
      print('Enter text!');
    }
  }

  void _deleteMessage(String docId) async {
    await FirebaseFirestore.instance.collection('messages')
          .doc(groupChatId).collection(groupChatId).doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('${widget.docs['name']}', softWrap: false),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('messages')
              .doc(groupChatId).collection(groupChatId)
              .orderBy('timestamp').snapshots(),
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  if (snapshots.data.docs.isEmpty) {
                    return Center(child: Text('Пусто... Заполните эту пустоту первым!'));
                  }
                  return MessageWall(
                    messages: snapshots.data.docs,
                    onDelete: _deleteMessage,
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
                //if (snapshots.hasData && snapshots.data != null) {
                //  return Column(
                //    children: [
                //      Expanded(
                //        child: ListView.builder(
                //          controller: scrollController,
                //          itemBuilder: (listContext, index) => buildItem(snapshots.data.docs[index]),
                //          itemCount: snapshots.data.docs.length, reverse: true,
                //        ),
                //      ),
                //      MessageForm(
                //        onSubmit: sendMsg,
                //      ),
                //    ],
                //  );
                //} else {
                //  return Center(
                //    child: SizedBox(
                //      height: 36,
                //      width: 36,
                //      child: CircularProgressIndicator(
                //        valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                //      ),
                //    ),
                //  );
                //}
              },
            ),
          ),
          MessageForm(onSubmit: sendMsg)
        ],
      ),
    );
  }
}