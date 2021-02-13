import 'package:flutter/material.dart';

class CardProfile extends StatefulWidget {
  final String nickname, name;

  CardProfile({Key key, this.nickname, this.name});

  @override
  _CardProfileState createState() => _CardProfileState();
}

class _CardProfileState extends State<CardProfile> {
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
                Text(widget.name, style: TextStyle(
                  fontSize: 22, fontFamily: 'BloggerSans',
                  fontWeight: FontWeight.w800, color: Colors.grey[800]
                ),),
                Text(widget.nickname, style: TextStyle(
                  fontSize: 16, fontFamily: 'BloggerSans',
                  color: Colors.grey[800] 
                ),),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: Colors.grey[800]),
            ),
          ],
        ),
      ),
    );
  }
}