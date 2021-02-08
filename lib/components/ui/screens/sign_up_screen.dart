import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() async {
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_emailController.text);
    bool passwordValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[()!@#\$&*~]).{8,}$').hasMatch(_passwordController.text);
    if (emailValid & passwordValid) {
      try {
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text
          );
          setState(() {
            Navigator.of(context).pushNamedAndRemoveUntil('/enter_nickname', (route) => false);
            _saveRoute();
          });
          Fluttertoast.showToast(
            msg: "Registration completed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18
          );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else if (!emailValid) {
      Fluttertoast.showToast(
        msg: "It looks like you didn't enter your email or you entered it incorrectly",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18
      );
    } else if (!passwordValid) {
      Fluttertoast.showToast(
        msg: "Password doesn't match",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18
      );
    }
  }

  _saveRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String route = '/enter_nickname';
    await prefs.setString('save_route', route);
    print('Route save!');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'BloggerSans',
                        fontWeight: FontWeight.w800
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
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
                      controller: _passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      maxLengthEnforced: true,
                      maxLength: 32,
                      decoration: const InputDecoration(
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
                      onPressed: () async {
                        _register();
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EnterNicknameScreen()),
                        );*/
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text('Sign Up', style: TextStyle(
                          fontSize: 24, fontFamily: 'BloggerSans',
                          fontWeight: FontWeight.w800, color: Colors.white
                        ),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
"""Password complexity:
    - should contain at least one upper case
    - should contain at least one lower case
    - should contain at least one digit
    - should contain at least one Special character""", style: TextStyle(
      fontSize: 16, fontFamily: 'BloggerSans'
    ))
          ],
        ),
      ),
    );
  }
}