// Importing Packages that contains all widgets we use
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maverick2245/authentication.dart';
import 'package:maverick2245/screens/Home.dart';
import 'package:maverick2245/screens/LoginPage.dart';

// Program Starts from here the Main Function

// MyApp is the main Class in which the whole app runs & it is a stateless widget
// because it does not maintain state in it directly.
class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner is set to false so that the debug badge from UI is removed
      debugShowCheckedModeBanner: false,
      home: SignInPage(), // SignInPage is the landing page of the app
    );
  }
}

// SignInPage Widget is set to be Stateful but it is also not handling state
// as of now since, its just UI but while implementing features you need to add state variables
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final Authenticate _auth = Authenticate();
  final _formkey = GlobalKey<FormState>();

  final fullName = TextEditingController();
  final email = TextEditingController();
  final ph_no = TextEditingController();
  final password1 = TextEditingController();
  final password2 = TextEditingController();

  void dispose() {
    fullName.dispose();
    email.dispose();
    ph_no.dispose();
    password1.dispose();
    password2.dispose();
    super.dispose();
  }

  // Build method runs again and again as the state changes to rebuild the UI
  @override
  Widget build(BuildContext context) {
    var _passwordVisible1 = true;
    var _passwordVisible2 = true;
    var _checkBoxVal = true;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xffFBB034), Color(0xffF8B313)],
            ),
          ),
          child: Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                // elevation removes the shadow under the action bar
                title: Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                leading: new IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new Login()),
                      );
                    }
                    //onPressed: (){SystemNavigator.pop();},
                    ),
                // Actions are identified as buttons which are added at the right of App Bar
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/logo.png'),
                  )
                ],
              ),
              Container(
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
                          controller: fullName,
                          autofocus: true,
                          textCapitalization: TextCapitalization.words,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            Pattern pattern =
                                r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                            RegExp regex = new RegExp(pattern);
                            if (!regex.hasMatch(value))
                              return 'Invalid username';
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Full Name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) => EmailValidator.validate(email)
                              ? null
                              : "Invalid email address",
                          controller: email,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail),
                            labelText: 'Email',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          controller: ph_no,
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          validator: (value) {
                            Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                            RegExp regExp = new RegExp(pattern);
                            if (value.length == 0) {
                              return 'Please enter mobile number';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Please enter valid mobile number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: Image.asset('icons/flags/png/in.png',
                                package: 'country_icons', scale: 3.5),
                            labelText: 'Phone Number',
                          ),
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
                          controller: password1,
                          obscureText: _passwordVisible1,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Password',
                            suffixIcon: new IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible1 = !(_passwordVisible1);
                                  });
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          autofocus: true,
                          controller: password2,
                          validator: (password) {
                            Pattern pattern =
                                r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                            RegExp regex = new RegExp(pattern);
                            print(password);
                            if (password == null &&
                                password1.text != password2.text &&
                                password.length <= 6)
                              return 'Invalid passwords Please check once';
                            else
                              return null;
                          },
                          obscureText: _passwordVisible2,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Confirm Password',
                            suffixIcon: new IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible2 = !(_passwordVisible2);
                                  });
                                }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            new Checkbox(
                                value: _checkBoxVal,
                                activeColor: Colors.orangeAccent,
                                onChanged: (val) {
                                  setState(() {
                                    _checkBoxVal = val;
                                    print(val);
                                  });
                                }),
                            InkWell(
                              child: RichText(
                                text: TextSpan(
                                  text: "I Agree to ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          "Terms and Conditions and Privacy Policy ",
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () => Navigator.push(
                                              context,
                                              new MaterialPageRoute(
                                                  builder: (context) =>
                                                      new SignIn()),
                                            ),
                                      style: TextStyle(
                                          color: Colors.orangeAccent,
                                          decoration: TextDecoration.underline),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(18.0),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: BorderSide(color: Colors.orangeAccent)),
                            color: Colors.orangeAccent,
                            splashColor: Colors.blueAccent,
                            child: Text(
                              'Proceed',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              print('entered');
                              if (_formkey.currentState.validate()) {
                                print(email.text);
                                print(password2.text);
                                dynamic result = await _auth.handleSingUp(
                                    email.text, password2.text);
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
                                          content: new Text(
                                              'Please enter a proper email address'),
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
                                        builder: (context) => new HomeScreen()),
                                  );
                                }
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: InkWell(
                  onTap: () {
                    print(" have an account tap");
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Aldready have an account? ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Click here to Login",
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () => Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => new Login()),
                                ),
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
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
