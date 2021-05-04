import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_ecom/main.dart';
import 'homePage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences preferences;
  bool loading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    preferences = await SharedPreferences.getInstance();
    isLoggedIn = await googleSignIn.isSignedIn();
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

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuth.idToken,
        accessToken: googleSignInAuth.accessToken);
    final UserCredential authResult =
        await firebaseAuth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        //insert the user to our collection
        FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'id': user.uid,
          'email': user.email,
          'userName': user.displayName,
          'profilePic': user.photoURL,
        });
        await preferences.setString('id', user.uid);
        await preferences.setString('userName', user.displayName);
        await preferences.setString('profilePic', user.photoURL);
      } else {
        await preferences.setString('id', documents[0]['id']);
        await preferences.setString('userName', documents[0]['userName']);
        await preferences.setString('profilePic', documents[0]['profilePic']);
      }
      Fluttertoast.showToast(msg: "Login successful");
      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    } else {
      Fluttertoast.showToast(msg: 'Login failed');
    }
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
            'assets/others/back.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/others/logo.jpg",
              width: 150,
              height: 150,
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
      bottomNavigationBar: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 24),
          child: FlatButton(
            color: Colors.red,
            onPressed: () {
              handleSignIn();
            },
            child: Text(
              'Sign in / Sign up with google',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
