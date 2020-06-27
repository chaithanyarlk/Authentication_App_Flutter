// Importing Packages that contains all widgets we use
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maverick2245/Routes/Route.dart';
import 'package:maverick2245/authentication.dart';
import 'package:maverick2245/screens/LoginPage.dart';
import 'package:maverick2245/screens/OTPPin.dart';
import 'package:maverick2245/screens/SignUp.dart';

// Program Starts from here the Main Function

// MyApp is the main Class in which the whole app runs & it is a stateless widget
// because it does not maintain state in it directly.
class OtpLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner is set to false so that the debug badge from UI is removed
      debugShowCheckedModeBanner: false,
      home: OTPLoginPage(), // OTPLoginPage is the landing page of the app
    );
  }
}

// OTPLoginPage Widget is set to be Stateful but it is also not handling state
// as of now since, its just UI but while implementing features you need to add state variables
class OTPLoginPage extends StatefulWidget {
  @override
  _OTPLoginPageState createState() => _OTPLoginPageState();
}

class _OTPLoginPageState extends State<OTPLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String phoneNo;
  String verificationId;
  String phoneNo1;
  bool codeSent = false;
  String smsCode;

  // Build method runs again and again as the state changes to rebuild the UI
  @override
  Widget build(BuildContext context) {
    var _passwordVisible = false;
    @override
    void initState() {
      _passwordVisible = false;
    }

    return Scaffold(
      // SingleChildScrollView makes the UI not to overflow from bottom when TextField is used or different device is used
      body: SingleChildScrollView(
        child: Container(
          // MediaQuery.of(context).size provides the Dimensions of the parent widget
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            // Adding Linear Gradient to the background of UI
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // Colors are converted to Integer from Hex Codes by replacing # with 0xff
              colors: [Color(0xffFBB034), Color(0xffF8B313)],
            ),
          ),
          child: Column(
            // Column Widget is added to Render the complete UI in vertical direction
            children: <Widget>[
              // App Bar is added in the body parameter of the Scaffold because we need to make it transparent and
              // show the gradient in background. Alternative option will be to use gradient action bar from pub.dev
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                // elevation removes the shadow under the action bar
                title: Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                leading: new IconButton(
                    icon: Icon(Icons.arrow_back),
                    //onPressed: (){Navigator.push(context, new MaterialPageRoute(builder: (context) => new Login()),);}
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Login()),
                      );
                    }),
                // Actions are identified as buttons which are added at the right of App Bar
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/logo.png'),
                  )
                ],
              ),
              ClipPath(
                // ClipPath is used to clip the child in a custom shape
                clipper: BottomClipper(),
                // here is the custom clipper for bottom cut shape
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 40, bottom: 30),
                  margin: EdgeInsets.only(top: 30, left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 2),
                          spreadRadius: 1.0,
                          blurRadius: 5.0)
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            onChanged: (val) {
                              setState(() {
                                this.phoneNo = val;
                                phoneNo1 = val;
                              });
                            },
                            decoration: InputDecoration(
                              prefixIcon: Image.asset('icons/flags/png/in.png',
                                  package: 'country_icons', scale: 3.5),
                              labelText: 'Phone Number',
                            ),
                          ),
                        ),
                        codeSent
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OtpPin(context)))
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "We will send you an ne Time Password on this Mobile Number",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: InkWell(
                            child: RichText(
                              // RichText is used to styling a particular text span in a text by grouping them in one widget
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                text: 'Login using ',
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Email and Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () => Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    new Login()),
                                          ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              onTap: () async {
                                verifyPhone(phoneNo);
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20, top: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xffFBB034),
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.all(8),
                                child: IconButton(
                                  icon: Icon(Icons.navigate_next),
                                  iconSize: 40,
                                  color: Colors.white,
                                  onPressed: () => Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) =>
                                            new OtpPin(context)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              ClipPath(
                clipper:
                    TopClipper(), // Custom Clipper for top clipping the social login menu box
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 50, bottom: 50),
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1, 2),
                          spreadRadius: 1.0,
                          blurRadius: 5.0),
                    ],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Or",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff898989),
                        ),
                      ),
                      Text(
                        "Login with Social Media",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff898989),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                                'assets/fb_icon.png'), // loading custom images from assets in Flutter
                            // NOTE that if you have not addressed these images in pubspec.yaml then it will show error
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/g_plus_icon.png'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: InkWell(
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Click here to signup",
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new SignIn()),
                                ),
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 25.0),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authresult) {
      Authenticate().signIn(authresult);
    };
    final PhoneVerificationFailed verificationfailed =
        (AuthException authException) {
      print('${authException.message}');
    };
    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };
    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}

// Custom Clipper Class
class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // Add Path lines to form slight cut
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height - 50);
    return path;
  }

  // we don't need to render it again and again as UI renders
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(size.width, 50);
    path.lineTo(size.width, size.height + 10);
    path.lineTo(0, size.height + 10);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
