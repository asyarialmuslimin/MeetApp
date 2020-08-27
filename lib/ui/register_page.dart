import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _nameNode = FocusNode();
  FocusNode _emailNode = FocusNode();
  FocusNode _passwordNode = FocusNode();

  bool _agreeTos = false;
  bool _hidePassword = true;
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
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameNode.dispose();
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

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
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
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Sign Up',
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
                          'Name',
                          style: _textStyleLabel,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          controller: _nameController,
                          focusNode: _nameNode,
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
                            hintText: 'Your Name',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 10.0, left: 10.0),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
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
                            hintText: 'Your Email',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 10.0, left: 10.0),
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
                          controller: _passwordController,
                          focusNode: _passwordNode,
                          obscureText: _hidePassword,
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
                            hintText: 'Your Password',
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 10.0, left: 10.0),
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
                          height: 8.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Theme(
                              data: ThemeData(
                                  unselectedWidgetColor: Colors.white),
                              child: Checkbox(
                                value: _agreeTos,
                                onChanged: _agreeTosOnChange,
                              ),
                            ),
                            Text(
                              'I Agree with ',
                              style: _textStyle,
                            ),
                            InkWell(
                                child: Text(
                              'Term of Service',
                              style: _textStyleLink,
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        SizedBox(
                          height: 56.0,
                          width: double.infinity,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            onPressed: () {
                              if (_agreeTos) {
                                if (_nameController.text.isEmpty ||
                                    _emailController.text.isEmpty ||
                                    _passwordController.text.isEmpty) {
                                  final snackbar = SnackBar(
                                    content: Text('Invalid Data'),
                                  );
                                  _scaffoldKey.currentState
                                      .showSnackBar(snackbar);
                                } else {
                                  _onSignUp(
                                      _nameController.text,
                                      _emailController.text,
                                      _passwordController.text,
                                      _scaffoldKey);
                                }
                              } else {
                                final snackbar = SnackBar(
                                  content: Text(
                                      'You Must Agree the Term of Service'),
                                );
                                _scaffoldKey.currentState
                                    .showSnackBar(snackbar);
                              }
                            },
                            color: Colors.white,
                            textColor: Color(0XFF3742FF),
                            child: Text(
                              "REGISTER",
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
                              'Already Member ? ',
                              style: _textStyle,
                            ),
                            InkWell(
                              child: Text(
                                'Sign In Here',
                                style: _textStyleLink,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }

  _agreeTosOnChange(bool value) {
    setState(() {
      _agreeTos = value;
    });
  }

  _setPasswordVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  Future<void> _onSignUp(String name, String email, String password,
      GlobalKey<ScaffoldState> _scaffoldKey) async {
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential != null) {
        final User user = credential.user;
        print(user.uid);
        final DatabaseReference root = FirebaseDatabase.instance.reference();
        root.update({
          '/user/${user?.uid}/data': {
            'email': user?.email,
            'name': name,
            'photo':
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
          }
        });

        final snackbar = SnackBar(
          content: Text('Sign Up Success, now you can login'),
        );
        _scaffoldKey.currentState.showSnackBar(snackbar);
      } else {
        final snackbar = SnackBar(
          content: Text('Sign Up Error'),
        );
        _scaffoldKey.currentState.showSnackBar(snackbar);
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
