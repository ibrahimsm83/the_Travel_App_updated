import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/Screens/forget_password.dart';
import 'package:travelapp/Screens/main_screen.dart';
import 'package:travelapp/Screens/signup_user_screen.dart';
import 'package:travelapp/Utils/constants.dart';
import 'package:travelapp/bottomnav.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // navigateToLogin() async {
  //   Navigator.pushReplacementNamed(context, "Login");
  // }

  // navigateToRegister() async {
  //   Navigator.pushReplacementNamed(context, "SignUp");
  // }

  bool? _success;
  var obscureText = true;
  String? _email, _password;
  final emailController = TextEditingController();
  final password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  //Sign in fun start
  void _signInWithEmailAndPassword() async {
    final user = (await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: password.text,
    ))
        .user;
    if (user != null) {
      print("------------------${user}");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('useremail', emailController.text);
      var em = prefs.getString('useremail');
      print("---------loginbtn eml----${em}");
      prefs.setBool("isLoggedIn", true);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => BottomNav()));
      // Navigator.of(context).push(MaterialPageRoute(builder: (_) => MechanicDeshboardPg()));
      // setState(() {
      //  // _success = true;
      //   Navigator.of(context).push(MaterialPageRoute(builder: (_) => mecchanicaccount()));
      //   _userEmail = user.email;
      // });
    } else {
      setState(() {
        _success = false;
      });
    }
  }
  ////Sign in fun End

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errormessage),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final double btnmargsize = MediaQuery.of(context).size.width * 0.09;
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("$imgpath/signupsocialmedia.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 70.0, right: 280.0),
                child: IconButton(
                  icon: Icon( Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                  size: 30.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MainScreen()
                      )
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: sizeheight(context) * 0.05),
                child: Text("The Travel App",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal)),
              ),
              SizedBox(height: 20),
              Divider(height: 5, thickness: 1, color: Colors.white),
              SizedBox(height: sizeheight(context) * 0.10),
              Container(
                child: Column(
                  children: [
                    Text(
                      'For Users',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              child: TextFormField(
                                  // ignore: missing_return
                                  // validator: (input) {
                                  //   if (input.isEmpty) return 'Enter Email';
                                  // },
                                  validator: (input) {
                                    if (input == null) return 'Enter Email';
                                  },
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      prefixIcon: Icon(Icons.email)),
                                  onSaved: (input) => _email = input),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              color: Colors.white,
                              child: TextFormField(
                                controller: password,
                                obscureText: obscureText,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    child: obscureText ? const Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    )
                                    : const Icon(
                                      Icons.visibility,
                                      color:  Colors.black,
                                    )
                                  )
                                ),
                                //obscureText: true,
                                validator: (input) {
                                  if (input == null) return 'Enter Password';
                                },

                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => forgotpassword()),);
                                    });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: 10, left: 0, right: 10),
                                      child: TextButton(
                                        child: const Text(
                                          "Forgot Passsword?",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color:
                                                  Colors.white //Color(0xFF267D43)
                                              ),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ForgetPasswordScreen()
                                              )
                                          );
                                        },
                                      )),
                                ),
                              ],
                            ), //Check
                            SizedBox(height: 20),
                            // ignore: deprecated_member_use
                            Container(
                              width: sizeWidth(context),
                              margin: EdgeInsets.only(
                                  left: btnmargsize, right: btnmargsize),
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    // login(emailController.text, password.text);
                                    print("Driver login");
                                    _signInWithEmailAndPassword();
                                    // Navigator.of(context).pushReplacement(MaterialPageRoute(
                                    //     builder: (BuildContext context) => UserDeshboardScreen()));
                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(builder: (_) => UserDeshboardScreen()));
                                  } else {
                                    print('Validation error');
                                  }
                                },
                                child: Text('LOGIN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold)),
                                color: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 10.0),
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(
                                  text: "Don't Have an Account? ",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: ('Sign Up'),
                                      style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.orange,
                                          fontSize: 18),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          SignUpScreen()));
                                        },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
