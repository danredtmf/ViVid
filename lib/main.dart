import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vivid/components/ui/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.black12, // status bar color
    statusBarBrightness: Brightness.dark,//status bar brigtness
    statusBarIconBrightness:Brightness.dark, //status barIcon Brightness
    systemNavigationBarDividerColor: Colors.greenAccent,//Navigation bar divider color
    systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon 
  ));
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomeScreen(),
    );
  }
}

