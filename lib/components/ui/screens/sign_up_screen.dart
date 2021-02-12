import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool otpIsValid = false;

  void _register() async {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_emailController.text);
    bool passwordValid = RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[()!@#\$&*~]).{8,}$')
        .hasMatch(_passwordController.text);
    if (emailValid & passwordValid) {
      try {
        if (otpIsValid) {
          UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text).then((_) {
              Navigator.of(context)
              .pushNamedAndRemoveUntil('/main', (route) => false);
            });
        Fluttertoast.showToast(
            msg: "Registration completed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 18);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
          Fluttertoast.showToast(
            msg: "The password is too weak.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18);
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
          Fluttertoast.showToast(
            msg: "The account already exists for that email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 18);
        }
      } catch (e) {
        print(e);
      }
    } else if (!emailValid) {
      Fluttertoast.showToast(
          msg:
              "It looks like you didn't enter your email or you entered it incorrectly",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18);
    } else if (!passwordValid) {
      Fluttertoast.showToast(
          msg: "Password doesn't match",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18);
    }
  }

  void sendOTP() async {
    EmailAuth.sessionName = "ViVid";
    var res = await EmailAuth.sendOtp(receiverMail: _emailController.text);
    if (res) {
      print("OTP Sent");
      Fluttertoast.showToast(
        msg: "OTP code sent to the mail",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.black,
        fontSize: 18);
    } else {
      print("We could not sent the OTP");
      Fluttertoast.showToast(
        msg: "We could not sent the OTP",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18);
    }
  }

  void verifyOTP() async {
    var res = EmailAuth.validate(receiverMail: _emailController.text, userOTP: _otpController.text);
    if (res) {
      print("OTP Verified");
      Fluttertoast.showToast(
        msg: "OTP Verified",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 18);
        otpIsValid = true;
    } else {
      print("Invalid OTP");
      Fluttertoast.showToast(
        msg: "Invalid OTP",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 18);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    otpIsValid = false;
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'BloggerSans',
                          fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        suffixIcon: TextButton(
                          child: Text('Send OTP'),
                          onPressed: () => sendOTP(),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      maxLengthEnforced: true,
                      decoration: InputDecoration(
                        hintText: 'Verify Code',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
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
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                    ),
                    SizedBox(height: 10),
                    FlatButton(
                      color: Colors.blueAccent,
                      onPressed: () {
                        verifyOTP();
                        _register();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'BloggerSans',
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Text("""Password complexity:
    - minimum 8 characters
    - should contain at least one upper case
    - should contain at least one lower case
    - should contain at least one digit
    - should contain at least one Special character""",
                style: TextStyle(fontSize: 16, fontFamily: 'BloggerSans'))
          ],
        ),
      ),
    );
  }
}
