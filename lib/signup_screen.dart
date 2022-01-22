import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//code for designing the UI of our text field where the user writes his email id or password

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.grey),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

bool _saving = false;

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your email')),
                SizedBox(
                  height: 8.0,
                ),
                TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                      //Do something with the user input.
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your Password')),
                SizedBox(
                  height: 24.0,
                ),
                TextButton(
                  child: Text('Sign Up'),
                  onPressed: () async {
                    setState(() {});
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                                var user = newUser.user;
                      if (newUser != null) {
                        Future<void> newUser() async {
                          Map<String, Object?> userData = {
                            'UserName': "",
                            'Email': email,
                            'Password': password,
                            'Role': 1,
                            'Profile':
                                "https://www.pexels.com/photo/man-in-black-jacket-771742/",
                            'CNI': "CE2020ks839",
                          };
                          FirebaseFirestore.instance
                              .collection('Users').doc(user!.uid)
                              .set(userData)
                              .catchError((e) {
                            print(e);
                          });

                          Map<String, Object?> transData = {
                            'from': _auth.currentUser!.uid,
                            'by': _auth.currentUser!.uid,
                            'amount':1,
                            'solde': 0000.5,
                            'type': 1,
                            'time': DateTime.now()
                          };
                          FirebaseFirestore.instance
                              .collection('Transactions')
                              .add(transData)
                              .catchError((e) {
                            print(e);
                          });
                        }
                        newUser();
                        // Navigator.pushNamed(context, 'home_screen');
                      }
                    } catch (e) {
                      print(e);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  },
                )
              ],
            ),
          ),
          isLoading: _saving),
    );
  }
}
