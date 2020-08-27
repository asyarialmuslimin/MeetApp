import 'package:MeetApp/ui/login_page.dart';
import 'package:MeetApp/ui/meet_setting_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _name = "";
  String _photoUrl =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

  Widget _logo = SvgPicture.asset('assets/meetapp_logo_inv.svg');
  Widget _header = SvgPicture.asset(
    'assets/header.svg',
    fit: BoxFit.fill,
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0XFF3742FF)));
    getData();
  }

  Future<void> getData() async {
    final uid = _auth.currentUser.uid;
    final root = FirebaseDatabase.instance.reference();
    String name;
    String photo;
    await root.child('/user/$uid/data/name').once().then((DataSnapshot data) {
      name = data.value;
    });
    await root.child('/user/$uid/data/photo').once().then((DataSnapshot data) {
      photo = data.value;
    });
    setState(() {
      this._name = name;
      this._photoUrl = photo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                child: _header,
                width: double.infinity,
                height: 185.0,
              ),
              Container(
                color: Color(0XFF3742FF),
                padding: EdgeInsets.all(10.0),
                height: 68,
                width: double.infinity,
                child: Stack(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 35.0,
                            width: 35.0,
                            child: _logo,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'MeetApp',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton.icon(
                          onPressed: () {
                            _onUserLogout();
                          },
                          icon: Icon(Icons.exit_to_app, color: Colors.white),
                          label: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: -65,
                child: CircleAvatar(
                  radius: 85,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                      radius: 80, backgroundImage: NetworkImage(_photoUrl)),
                ),
              ),
            ],
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.only(top: 85.0, left: 32.0, right: 32.0),
              child: Column(
                children: [
                  Text(
                    'Hello',
                    style: TextStyle(fontSize: 28.0),
                  ),
                  Text(
                    _name,
                    style:
                        TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 73,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return MeetSettingPage(
                                isCreate: true,
                                nameUser: _name,
                                photo: _photoUrl);
                          }),
                        );
                      },
                      color: Color(0XFF3742FA),
                      child: Text(
                        "START MEETING",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.0,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 73,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return MeetSettingPage(
                              isCreate: false,
                              nameUser: _name,
                              photo: _photoUrl);
                        }));
                      },
                      color: Color(0XFF3742FA),
                      child: Text(
                        "JOIN MEETING",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.0,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 36.0,
          ),
        ],
      ),
    ));
  }

  Future<void> _onUserLogout() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return LoginPage();
    }), (route) => false);
  }
}
