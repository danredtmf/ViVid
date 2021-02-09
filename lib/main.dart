import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vivid/components/auth/android_auth_provider.dart';
import 'package:vivid/components/ui/screens/edit_name.dart';
import 'package:vivid/components/ui/screens/edit_nickname.dart';
import 'package:vivid/components/ui/screens/enter_nickname.dart';
import 'package:vivid/components/ui/screens/login_screen.dart';
import 'package:vivid/components/ui/screens/main_screen.dart';
import 'package:vivid/components/ui/screens/settings_screen.dart';
import 'package:vivid/components/ui/screens/sign_up_screen.dart';
import 'package:vivid/components/ui/screens/welcome_screen.dart';

void main() async {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.black12, // status bar color
    statusBarBrightness: Brightness.dark, //status bar brigtness
    statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
    systemNavigationBarDividerColor:
        Colors.greenAccent, //Navigation bar divider color
    systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));
  await AuthProvider().initialize();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ViVid',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/welcome': (BuildContext context) => new WelcomeScreen(),
        '/sign_up': (BuildContext context) => new SignUpScreen(),
        '/login': (BuildContext context) => new LoginScreen(),
        '/enter_nickname': (BuildContext context) => new EnterNicknameScreen(),
        '/main': (BuildContext context) => new MainScreen(),
        '/settings': (BuildContext context) => new SettingsScreen(),
        '/edit_nickname': (BuildContext context) => new EditNicknameScreen(),
        '/edit_name': (BuildContext context) => new EditNameScreen(),
      },
      home: WelcomeScreen(),
    );
  }
}
