import 'package:flutter/material.dart';
import 'package:maverick2245/authentication.dart';

class Complete extends StatefulWidget {
  @override
  _CompleteState createState() => new _CompleteState();
}

class _CompleteState extends State<Complete> {
  String name;
  String email;
  Authenticate _auth = Authenticate();
  @override
  Widget build(BuildContext context) {
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
                  
                  "",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                leading: new IconButton(
                  icon: Icon(Icons.menu),
                  //onPressed: (){Navigator.push(context, new MaterialPageRoute(builder: (context) => new Login()),);}
                  onPressed: () {
                    null;
                  },
                ),
                // Actions are identified as buttons which are added at the right of App Bar
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        icon: Icon(Icons.exit_to_app),
                        onPressed: () async {
                          await _auth.signOut();
                        }),
                  )
                ],
              ),
              ClipPath(
                // ClipPath is used to clip the child in a custom shape

                // here is the custom clipper for bottom cut shape
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 20, bottom: 25),
                  margin: EdgeInsets.only(top: 10, left: 20, right: 20),
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
                  child:Column(
                    children: <Widget>[
                      Center(
                        child:Image.asset("assets/logo.png",scale:0.5)
                      ),
                      Center(
                        child:Icon(Icons.check_circle,color: Colors.greenAccent,),
                      ),
                      Center(
                        child:Text(
                          "First Challenge",
                          style:TextStyle(fontSize: 18.0),
                        ),
                      ),
                      Center(
                        child:Text(
                          "Completed",
                          style:TextStyle(fontSize: 18.0),
                        ),
                      ),

                  ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
