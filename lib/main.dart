import 'package:app_auth/dashboardpage.dart';
import 'package:app_auth/homepage.dart';
import 'package:app_auth/loginpage.dart';
import 'package:app_auth/registerpage.dart';
import 'package:app_auth/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp(
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //home: LoginPage(),
//      routes: <String, WidgetBuilder> {
//        '/landingPage' : (BuildContext context) => MyApp(),
//        '/homePage' : (BuildContext context) => HomePage(),
//        '/signup' : (BuildContext context) => SignupPage(),
//      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

//  final emailTextController = TextEditingController();
//  final passwordTextController = TextEditingController();
//
//  @override
//  void dispose() {
//    emailTextController.dispose();
//    passwordTextController.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Authentication")
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            SizedBox(
//              width: 360,
//              child: TextFormField(
//                validator: (input) {
//                  if(input.isEmpty) {
//                    return 'Please type an email';
//                  } else {
//                    return null;
//                  }
//                },
//                decoration: InputDecoration(
//                  labelText: "Email"
//                ),
//                controller: emailTextController,
//              ),
//            ),
//
//            SizedBox(
//              width: 360,
//              child: TextFormField(
//                obscureText: true,
//                validator: (input) {
//                  if(input.isEmpty) {
//                    return 'Please type an password';
//                  } else {
//                    return null;
//                  }
//                },
//                decoration: InputDecoration(
//                    labelText: "Password"
//                ),
//                controller: passwordTextController,
//              ),
//            ),
//
//            SizedBox(
//              height: 28,
//            ),

//            SizedBox(
//              width: 360,
//              child: RaisedButton(
//                child: Row(
//                  children: <Widget>[
//                    Icon(Icons.mail, size: 30),
//                    Text(
//                      'Sign up with Email',
//                      style: TextStyle(fontSize: 28)
//                    )
//                  ],
//                ),
//                textColor: Colors.white,
//                color: Colors.red,
//                padding: const EdgeInsets.all(10),
//                onPressed: () {
//                  signUpWithMail();
//                },
//              ),
//            ),

            SizedBox(height: 20,),

            SizedBox(
              width: 360,
              child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.thumb_up, size: 30),
                    Text(
                        'Sign up with Facebook',
                        style: TextStyle(fontSize: 28)
                    )
                  ],
                ),
                textColor: Colors.white,
                color: Colors.blue,
                padding: const EdgeInsets.all(10),
                onPressed: () {
                  signUpWithFacebook();
                },
              ),
            ),

            SizedBox(height: 20,),

            SizedBox(
              width: 360,
              child: RaisedButton(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.search, size: 30),
                    Text(
                        'Sign up with Google',
                        style: TextStyle(fontSize: 28)
                    )
                  ],
                ),
                textColor: Colors.white,
                color: Colors.green,
                padding: const EdgeInsets.all(10),
                onPressed: () {

                  signUpWithGoogle();
                },
              ),
            ),

            SizedBox(height: 20,),

            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.redAccent,
                child: Text("Logout"),
                onPressed: () {
                  _logOut();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

//  Future<void> signUpWithMail() async {
//    try {
//      FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
//          email: emailTextController.text,
//          password: passwordTextController.text,
//      )).user;
//
//      bool isAlreadyRegistered() {
//        if(user != null) {
//          return true;
//        } else {
//          return false;
//        }
//      }
//      if(isAlreadyRegistered()) {
//        Navigator.push(
//          context,
//          MaterialPageRoute(builder: (context) => DashboardPage()),
//        );
//      } else {
//
//      }
//      showDialog(
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            content: Text("Sign up user success"),
//          );
//        }
//      );
//    } catch(e) {
//      print(e.message);
//      showDialog(
//        context: context,
//        builder: (context) {
//          return AlertDialog(
//            content: Text(e.message),
//          );
//        },
//      );
//    }
//  }

  Future<void> signUpWithFacebook() async {

      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if(result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,
        );
        try {
          final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
          print('Signed in ' + user.displayName);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPage()),
          );
          return user;

        } catch(e) {
          print(e.message);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
        }

      }
  }

  Future<void> signUpWithGoogle() async {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email'
        ],
        hostedDomain: '',
        clientId: '',
      );
      //final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      try {
        final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        print("Signed in " + user.displayName);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
        return user;

      } catch(e) {
        print(e.message);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterPage()),
        );
      }

        //return user;

  }

  _logOut() {

  }
}

