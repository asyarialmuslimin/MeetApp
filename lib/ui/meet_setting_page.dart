import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:random_string/random_string.dart';

class MeetSettingPage extends StatefulWidget {
  final bool isCreate;
  final String nameUser;
  final String photo;

  MeetSettingPage(
      {Key key,
      @required this.isCreate,
      @required this.nameUser,
      @required this.photo})
      : super(key: key);

  @override
  _MeetSettingPageState createState() =>
      _MeetSettingPageState(isCreate, nameUser, photo);
}

class _MeetSettingPageState extends State<MeetSettingPage> {
  TextEditingController _subjectController = TextEditingController();
  TextEditingController _meetidController = TextEditingController();
  FocusNode _subjectNode = FocusNode();
  FocusNode _meetNode = FocusNode();

  String _nameUser = "";
  String _photo = "";
  String _meetid;
  bool _isCreate = true;
  bool _sound = true;
  bool _video = true;

  Widget _logo = SvgPicture.asset('assets/meetapp_logo_inv.svg');
  Widget _header = SvgPicture.asset(
    'assets/header.svg',
    fit: BoxFit.fill,
  );

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _MeetSettingPageState(bool isCreate, String nameUser, String photo) {
    this._isCreate = isCreate;
    this._nameUser = nameUser;
    this._photo = photo;
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0XFF3742FF)));
    this._meetid = randomAlpha(15);
    print(this._meetid);
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() {
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _headerComponent(),
              Padding(
                padding: EdgeInsets.only(top: 72.0, left: 24.0, right: 24.0),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Center(
                      child: Text(
                        _isCreate ? 'Create Meeting' : 'Join Meeting',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 32.0),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    _isCreate ? _createMode(_scaffoldKey) : _joinMode(),
                    SizedBox(
                      height: 24.0,
                    ),
                    _meetSetting(),
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
                          if (_isCreate) {
                            _joinMeeting('metap' + _meetid,
                                _subjectController.text, false);
                          } else {
                            if (_meetidController.text.length == 20) {
                              _joinMeeting(_meetidController.text, '', false);
                            }
                          }
                        },
                        color: Color(0XFF3742FA),
                        child: Text(
                          _isCreate ? 'START MEETING' : 'JOIN MEETING',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.0,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 36.0,
                    ),
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerComponent() {
    return Stack(
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
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: FlatButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    label: Text(
                      'Back',
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
              radius: 80,
              backgroundImage: this._photo.isEmpty
                  ? AssetImage('assets/profile_placeholder.png')
                  : NetworkImage(this._photo),
            ),
          ),
        ),
      ],
    );
  }

  Widget _meetSetting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            RawMaterialButton(
              onPressed: () {
                setState(() {
                  this._sound = !this._sound;
                });
              },
              fillColor: this._sound ? Colors.black54 : Colors.red,
              child: Icon(
                this._sound ? Icons.volume_up : Icons.volume_off,
                size: 48.0,
                color: Colors.white,
              ),
              elevation: 2.0,
              padding: EdgeInsets.all(16.0),
              shape: CircleBorder(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(_sound ? 'Sound On' : 'Sound Off'),
            ),
          ],
        ),
        SizedBox(
          width: 16.0,
        ),
        Column(
          children: [
            RawMaterialButton(
              onPressed: () {
                setState(() {
                  this._video = !this._video;
                });
              },
              fillColor: this._video ? Colors.black54 : Colors.red,
              child: Icon(
                this._video ? Icons.videocam : Icons.videocam_off,
                size: 48.0,
                color: Colors.white,
              ),
              elevation: 2.0,
              padding: EdgeInsets.all(16.0),
              shape: CircleBorder(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(_video ? 'Camera On' : 'Camera Off'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _joinMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Meeting ID'),
        SizedBox(
          height: 8.0,
        ),
        TextField(
          controller: _meetidController,
          focusNode: _meetNode,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Insert Meeting ID',
          ),
        ),
      ],
    );
  }

  Widget _createMode(GlobalKey<ScaffoldState> scaffoldKey) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Meeting ID'),
        Row(
          children: [
            Expanded(
              child: Text(
                'metap' + this._meetid,
                style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              child: Icon(Icons.content_copy),
              onTap: () {
                Clipboard.setData(ClipboardData(text: 'metap' + this._meetid));
                final snackbar =
                    SnackBar(content: Text('ID Copied to Clipboard'));
                scaffoldKey.currentState.showSnackBar(snackbar);
              },
            )
          ],
        ),
        SizedBox(
          height: 24.0,
        ),
        Text('Meeting Subject (Optional)'),
        SizedBox(
          height: 8.0,
        ),
        TextField(
          controller: _subjectController,
          focusNode: _subjectNode,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Insert Meeting Subject',
          ),
        ),
      ],
    );
  }

  void _joinMeeting(String id, String subject, bool join) async {
    try {
      // Enable or disable any feature flag here
      // If feature flag are not provided, default values will be used
      // Full list of feature flags (and defaults) available in the README
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
        FeatureFlagEnum.INVITE_ENABLED: false
      };

      // Here is an example, disabling features for each platform
      if (Platform.isAndroid) {
        // Disable ConnectionService usage on Android to avoid issues (see README)
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        // Disable PIP on iOS as it looks weird
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      // Define meetings options here
      var options;
      if (join) {
        options = JitsiMeetingOptions()
          ..room = id
          ..userDisplayName = _nameUser
          ..audioMuted = !_sound
          ..videoMuted = !_video
          ..featureFlags.addAll(featureFlags);
      } else {
        options = JitsiMeetingOptions()
          ..room = id
          ..subject = subject.isNotEmpty ? subject : 'MeetApp Meeting'
          ..userDisplayName = _nameUser
          ..audioMuted = !_sound
          ..videoMuted = !_video
          ..featureFlags.addAll(featureFlags);
      }

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }),
        // by default, plugin default constraints are used
        //roomNameConstraints: new Map(), // to disable all constraints
        //roomNameConstraints: customContraints, // to use your own constraint(s)
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
