import 'package:evergreen_app/models/user_model.dart';
import 'package:evergreen_app/screens/upload_photo.dart';
import 'package:evergreen_app/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
    print(loggedInUser.firstName);
    print(loggedInUser.scores);
    print(loggedInUser.placeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                height: 110,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?auto=compress&cs=tinysrgb&h=650&w=940"),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "${loggedInUser.firstName} ${loggedInUser.lastName}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                ),
              ),
              SizedBox(height: 15),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 28),
              //   alignment: Alignment.center,
              //   child: Text(
              //     "${loggedInUser.placeName}",
              //     textAlign: TextAlign.center,
              //   ),
              // ),

              // The Horizontal Row for CITY and SCORE
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Column(
                      children: <Widget>[
                        Text(
                          "${loggedInUser.placeName}",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        Text('City', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          // "${loggedInUser.scores}",
                          "85",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        Text('Total Score', style: TextStyle(fontSize: 16))
                      ],
                    ),
                  ],
                ),
              ),

              //Buttons code
              //SizedBox(height: 35),
              Spacer(),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                color: kSendPhoto,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ModelScreen()));
                  },
                  child: Text(
                    "Upload Photo",
                    style: TextStyle(color: kLoginButtonText),
                  ),
                  minWidth: MediaQuery.of(context).size.width * 0.7,
                ),
              ),

              SizedBox(height: 15),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                color: kViewHistory,
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    "View History",
                    style: TextStyle(color: kLoginButtonText),
                  ),
                  minWidth: MediaQuery.of(context).size.width * 0.7,
                ),
              ),

              Spacer(),

              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                color: kLoginButton,
                child: MaterialButton(
                  onPressed: () {
                    logout(context);
                  },
                  child: Text(
                    "Log Out",
                    style: TextStyle(color: kLoginButtonText),
                  ),
                  minWidth: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
