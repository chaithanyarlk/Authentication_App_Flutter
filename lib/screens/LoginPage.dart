// Importing Packages that contains all widgets we use
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maverick2245/Routes/Route.dart';
import 'package:maverick2245/authentication.dart';
import 'package:maverick2245/screens/ForgotPassword.dart';
import 'package:maverick2245/screens/OTPLogin.dart';
import 'package:maverick2245/screens/SignUp.dart';

import 'Home.dart';

// Program Starts from here the Main Function

// MyApp is the main Class in which the whole app runs & it is a stateless widget
// because it does not maintain state in it directly.
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner is set to false so that the debug badge from UI is removed
      debugShowCheckedModeBanner: false,
      home: LoginPage(), // LoginPage is the landing page of the app
    );
  }
}

// LoginPage Widget is set to be Stateful but it is also not handling state
// as of now since, its just UI but while implementing features you need to add state variables
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Authenticate _auth = Authenticate();
  final _formkey = GlobalKey<FormState>();

  final email = TextEditingController();
  final password = TextEditingController();

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
                    SystemNavigator.pop();
                  },
                ),
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
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: TextFormField(
                            controller: email,
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            validator: (email) => EmailValidator.validate(email)
                                ? null
                                : "Invalid email address",
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelText: 'Email'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            autofocus: true,
                            validator: (password) {
                              print(password);

                              if (password == "" && password.length <= 6)
                                return 'Invalid password';
                              else
                                return null;
                            },
                            controller: password,
                            obscureText: _passwordVisible,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                labelText: 'Password',
                                suffixIcon: new IconButton(
                                    icon: Icon(Icons.remove_red_eye),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !(_passwordVisible);
                                      });
                                    }),
                                    ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: InkWell(
                              // InkWell widget makes the widget clickable and provide call back for touch events
                              onTap: () {
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) =>
                                          new ForgetPassword()),
                                );
                              },
                              child: Text(
                                'Forget Password?',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color(0xffFBB034),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
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
                                    text: 'Mobile Number and OTP',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () => Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    new OtpLogin()),
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
                                print('entered');
                                if (_formkey.currentState.validate()) {
                                  print(email.text);
                                  print(password.text);
                                  dynamic result = await _auth.handleLogin(
                                      email.text, password.text);
                                  print(result);
                                  if (result == null) {
                                    print("Came here in ERRor");
                                    setState(() {
                                      var error =
                                          'Please enter a proper email address';
                                    });
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: new Text("Error"),
                                            content:
                                                new Text('Invalid Credentials'),
                                            actions: <Widget>[
                                              new FlatButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: new Text("Close"),
                                              ),
                                            ],
                                          );
                                        });
                                  } else {
                                    print("success");
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              new HomeScreen()),
                                    );
                                  }
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20, top: 10),
                                decoration: BoxDecoration(
                                    color: Color(0xffFBB034),
                                    borderRadius: BorderRadius.circular(30)),
                                padding: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.navigate_next,
                                  size: 40,
                                  color: Colors.white,
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
