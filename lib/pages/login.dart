import 'package:flutter/material.dart';
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
  final GoogleSignIn googleSignIn = GoogleSignIn();
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
    preferences = await SharedPreferences.getInstance();
    isLoggedIn = await googleSignIn.isSignedIn();
    if (!isLoggedIn) {
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
            color: Colors.black.withOpacity(0.2),
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
                child: Column(
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
                    Expanded(
                      child: Container(),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Other login options',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        minWidth: MediaQuery.of(context).size.width,
                        height: 50,
                        color: Colors.red.withOpacity(0.8),
                        onPressed: () {},
                        child: Text(
                          'Sign in / Sign up with google',
                          style: TextStyle(color: Colors.white),
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
