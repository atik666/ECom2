import 'package:flutter/material.dart';
import 'package:flutter_ecom/pages/signUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'homePage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool isLoggedIn = false;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });

    final user = firebaseAuth.currentUser;
    if (user != null) {
      setState(() {
        isLoggedIn = true;
      });
    }

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 6,
        centerTitle: true,
        title: Text(
          'Login',
          style: TextStyle(color: Colors.red[900]),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/others/backL.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/others/logo.jpg",
              width: 150,
              height: 150,
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Center(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 220, 10, 0),
                      child: Material(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Email",
                                icon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                                labelText: "Email *"),
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailTextController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a valid email';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: Material(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Password",
                                icon: Icon(Icons.lock_rounded),
                                border: OutlineInputBorder(),
                                labelText: "Password *"),
                            obscureText: true,
                            controller: _passwordTextController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password cannot be empty';
                              } else if (value.length < 6) {
                                return "Password must be at least 6 characters long";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        minWidth: MediaQuery.of(context).size.width,
                        height: 50,
                        color: Colors.blue.withOpacity(0.8),
                        onPressed: () {},
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Text(
                          'Forgot password?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 5,
                      color: Colors.white,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUP(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red[900]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
