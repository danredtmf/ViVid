import 'package:flutter/material.dart';
import 'package:vivid/components/ui/screens/login_screen.dart';
import 'package:vivid/components/ui/screens/sign_up_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
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
                  onPressed: () {},
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