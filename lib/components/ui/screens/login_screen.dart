import 'package:flutter/material.dart';
import 'package:vivid/components/ui/screens/main_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

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
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'BloggerSans',
                    fontWeight: FontWeight.w800
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  maxLengthEnforced: true,
                  maxLength: 32,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                ),
                SizedBox(height: 10),
                FlatButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text('Login', style: TextStyle(
                      fontSize: 24, fontFamily: 'BloggerSans',
                      fontWeight: FontWeight.w800, color: Colors.white
                    ),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}