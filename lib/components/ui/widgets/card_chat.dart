import 'package:flutter/material.dart';

class CardChat extends StatefulWidget {
  final String text, name;

  CardChat({Key key, this.text, this.name});

  @override
  _CardChatState createState() => _CardChatState();
}

class _CardChatState extends State<CardChat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(width: 3, color: Colors.grey[200]),
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 363,
                  child: Text(widget.name, style: TextStyle(
                    fontSize: 22, fontFamily: 'BloggerSans',
                    fontWeight: FontWeight.w800, color: Colors.grey[800]
                  ), softWrap: false, overflow: TextOverflow.fade),
                ),
                SizedBox(
                  width: 363,
                  child: Text(widget.text, style: TextStyle(
                    fontSize: 16, fontFamily: 'BloggerSans',
                    color: Colors.grey[800]
                  ), softWrap: false, overflow: TextOverflow.fade),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}