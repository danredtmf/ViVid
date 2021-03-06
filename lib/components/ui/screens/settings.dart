import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vivid/components/theme/AppStateNotifier.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, appState, child) => Scaffold(
        backgroundColor: appState.isDarkModeOn ? Colors.black : Colors.white,
        appBar: AppBar(
          title: Text('Settings'),
          backgroundColor: appState.isDarkModeOn ? Colors.white12 : Colors.blueAccent,
          elevation: 0,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                      child: Text('Account',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'BloggerSans',
                          fontWeight: FontWeight.w800,
                          color: appState.isDarkModeOn ? Colors.grey : Colors.grey[800],
                        ))),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    height: 200,
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: appState.isDarkModeOn ? Colors.grey[800] : Colors.blueAccent,
                      borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/edit_nickname');
                            },
                            splashColor: Colors.white10,
                            child: Text('Edit Nickname',
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'BloggerSans',
                                color: Colors.white,
                                fontWeight: FontWeight.w800)),
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/edit_name');
                            },
                            splashColor: Colors.white10,
                            child: Text('Edit Name',
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'BloggerSans',
                                color: Colors.white,
                                fontWeight: FontWeight.w800)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text('Appearance',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'BloggerSans',
                          fontWeight: FontWeight.w800,
                          color: appState.isDarkModeOn ? Colors.grey : Colors.grey[800],
                        ))),
                  Container(
                    margin:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    height: 70,
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: appState.isDarkModeOn ? Colors.grey[800] : Colors.blueAccent,
                      borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Dark Mode',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'BloggerSans',
                                fontWeight: FontWeight.w800,
                                color: Colors.white)),
                              Consumer<AppStateNotifier>(
                          builder: (context, appState, child) => Switch(
                                inactiveThumbColor: Colors.white,
                                activeColor: Colors.white,
                                value: appState.isDarkModeOn,
                                onChanged: (boolVal) {
                                  appState.toogleTheme();
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text('About ViVid',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'BloggerSans',
                        fontWeight: FontWeight.w800,
                        color: appState.isDarkModeOn ? Colors.grey : Colors.grey[800],
                      ))),
                  Container(
                    margin:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    height: 185,
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: appState.isDarkModeOn ? Colors.grey[800] : Colors.blueAccent,
                      borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: <Widget>[
                          Text('Developer',
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'BloggerSans',
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://sun9-37.userapi.com/impg/V1m76-P2AjkZbjqPFOqUejmrR1MFL9HzKJjhhg/mW1SzsVICBo.jpg?size=1024x1024&quality=96&proxy=1&sign=ca242670dd251e074ac400de5ff4519e&type=album'))),
                            ),
                            onTap: () => launch("https://danredtmf.github.io"),
                          ),
                          Text('DanRedTMF',
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'BloggerSans',
                              fontWeight: FontWeight.w800,
                              color: Colors.white)
                          ),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}
