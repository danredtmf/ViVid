import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vivid/components/auth/auth_provider.dart';
import 'package:vivid/components/auth/auth_services.dart';
import 'package:vivid/components/ui/screens/edit_name.dart';
import 'package:vivid/components/ui/screens/edit_nickname.dart';
import 'package:vivid/components/ui/screens/enter_nickname.dart';
import 'package:vivid/components/ui/screens/login.dart';
import 'package:vivid/components/ui/screens/main.dart';
import 'package:vivid/components/ui/screens/search.dart';
import 'package:vivid/components/ui/screens/settings.dart';
import 'package:vivid/components/ui/screens/sign_up.dart';
import 'package:vivid/components/ui/screens/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.black12, // status bar color
    statusBarBrightness: Brightness.dark, //status bar brigtness
    statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
    systemNavigationBarDividerColor:
        Colors.greenAccent, //Navigation bar divider color
    systemNavigationBarIconBrightness: Brightness.light, //navigation bar icon
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: 'ViVid',
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/welcome': (BuildContext context) => new WelcomeScreen(),
          '/sign_up': (BuildContext context) => new SignUpScreen(),
          '/login': (BuildContext context) => new LoginScreen(),
          '/enter_nickname': (BuildContext context) => new EnterNicknameScreen(),
          '/main': (BuildContext context) => new MainScreen(),
          '/search': (BuildContext context) => new SearchScreen(),
          '/settings': (BuildContext context) => new SettingsScreen(),
          '/edit_nickname': (BuildContext context) => new EditNicknameScreen(),
          '/edit_name': (BuildContext context) => new EditNameScreen(),
        },
        home: HomeController(),
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  const HomeController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;

    return StreamBuilder<User>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData; 
          return signedIn ? MainScreen() : WelcomeScreen();
        }
        return Container(
          color: Colors.white,
        );
      },
    );
  }
}