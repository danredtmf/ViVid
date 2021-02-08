import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  _checkUserAndRoute(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String saveRoute = prefs.getString('save_route');
    
    FirebaseAuth.instance
    .authStateChanges()
    .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
        //Navigator.of(context).pushNamedAndRemoveUntil('/welcome', (route) => false);
      } else {
        print('User is signed in!');
        if (saveRoute != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(saveRoute, (route) => false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _checkUserAndRoute(context);
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Welcome in ViVid',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'BloggerSans',
                    fontWeight: FontWeight.w800
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/sign_up');
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );*/
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'BloggerSans',
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  color: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/login');
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );*/
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'BloggerSans',
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  color: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
                FlatButton(
                  onPressed: () {}, // TODOGoogle login support
                  child: Text(
                    'Sign In with Google',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'BloggerSans',
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  color: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}