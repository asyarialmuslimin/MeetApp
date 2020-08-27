import 'package:MeetApp/ui/home_page.dart';
import 'package:MeetApp/ui/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _hidePassword = true;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FocusNode _emailNode = FocusNode();
  FocusNode _passwordNode = FocusNode();

  final Widget _fbIcon = SvgPicture.asset(
    'assets/facebook.svg',
  );
  final Widget _googleIcon = SvgPicture.asset(
    'assets/google.svg',
  );

  final Widget _header = SvgPicture.asset(
    'assets/header1.svg',
    fit: BoxFit.fill,
  );
  final Widget _logo = SvgPicture.asset(
    'assets/meetapp_logo.svg',
  );

  final InputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      width: 0.0,
      color: Color(0XFF3385FF),
    ),
  );

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final User user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return HomePage();
          }),
          (route) => false,
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle _textStyleLabel = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w500, letterSpacing: 1.0);

    TextStyle _textStyle = TextStyle(color: Colors.white, letterSpacing: 1.0);

    TextStyle _textStyleLink = TextStyle(
        color: Colors.white, fontWeight: FontWeight.w700, letterSpacing: 1.0);

    return Scaffold(
        backgroundColor: Color(0XFF3742FA),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 95.0,
                      child: _header,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 58,
                          height: 58,
                          child: _logo,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'MeetApp',
                          style: TextStyle(
                            fontSize: 42.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0XFF3742FF),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 36,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: _textStyleLabel,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextField(
                            controller: _emailController,
                            focusNode: _emailNode,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0XFF3385FF),
                              border: _inputBorder,
                              focusedBorder: _inputBorder,
                              enabledBorder: _inputBorder,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Insert Email',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Text(
                            'Password',
                            style: _textStyleLabel,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          TextField(
                            obscureText: _hidePassword,
                            controller: _passwordController,
                            focusNode: _passwordNode,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0XFF3385FF),
                              border: _inputBorder,
                              focusedBorder: _inputBorder,
                              enabledBorder: _inputBorder,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Insert Password',
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
                                child: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  _setPasswordVisibility();
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: 10.0, left: 10.0),
                                  child: Icon(
                                    _hidePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'Forgot Password ?',
                                style: _textStyleLink,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          SizedBox(
                            height: 56.0,
                            width: double.infinity,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              onPressed: () {
                                if (_emailController.text.isNotEmpty &&
                                    _passwordController.text.isNotEmpty) {
                                  _onSignIn(_emailController.text,
                                      _passwordController.text);
                                }
                              },
                              color: Colors.white,
                              textColor: Color(0XFF3742FF),
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Don't Have Account ?  ",
                                style: _textStyle,
                              ),
                              InkWell(
                                child: Text(
                                  'Sign Up Here',
                                  style: _textStyleLink,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: RegisterPage(),
                                          type: PageTransitionType
                                              .rightToLeftWithFade));
                                },
                              )
                            ],
                          ),
                          Divider(
                            height: 32.0,
                            color: Colors.white38,
                            thickness: 1.0,
                          ),
                          Center(
                            child: Text(
                              '- OR -',
                              style: _textStyle,
                            ),
                          ),
                          Center(
                            child: Text(
                              'sign in with',
                              style: _textStyle,
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _roundedButton(_googleIcon, 'google'),
                              SizedBox(
                                width: 12.0,
                              ),
                              _roundedButton(_fbIcon, 'facebook')
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _setPasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  RawMaterialButton _roundedButton(Widget svgIcon, String mode) {
    return RawMaterialButton(
      onPressed: () {
        if (mode == 'google') {
          _onGoogleSignIn(context);
        }
      },
      fillColor: Colors.white,
      child: Container(
        height: 36.0,
        width: 36.0,
        child: svgIcon,
      ),
      elevation: 2.0,
      padding: EdgeInsets.all(16.0),
      shape: CircleBorder(),
    );
  }

  Future<User> _googleSignInHandler() async {
    User user;
    try {
      bool isSigned = await _googleSignIn.isSignedIn();
      if (isSigned) {
        user = await _auth.currentUser;
      } else {
        final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        user = (await _auth.signInWithCredential(credential)).user;
        print(user.displayName);
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  void _onGoogleSignIn(BuildContext context) async {
    User _user = await _googleSignInHandler();
    if (_user != null) {
      final DatabaseReference root = FirebaseDatabase.instance.reference();
      root.update({
        '/user/${_user?.uid}/data': {
          'email': _user?.email,
          'name': _user?.displayName,
          'photo': _user?.photoURL
        }
      });
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return HomePage();
      }), (route) => false);
    }
  }

  Future<void> _onSignIn(email, password) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (credential != null) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return HomePage();
        }), (route) => false);
      }
    } catch (e) {
      print(e);
    }
  }
}
