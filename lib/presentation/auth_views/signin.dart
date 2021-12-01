import 'package:flutter/material.dart';
import 'package:textme/data/service_util.dart';
import 'package:textme/domain/model/auth.dart';
import 'package:http/http.dart' as http;
import 'package:textme/presentation/auth_views/signup.dart';
import 'package:textme/presentation/profile_views/profile.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  signIn() async {
    SignIn input = SignIn(
        username: usernameController.text, password: passwordController.text);
    http.StreamedResponse response =
        await ServiceUtil().authService.signIn(input);

    if (response.statusCode == 200) {
      http.StreamedResponse response2 =
          await ServiceUtil().userService.getCurrentUser();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => ProfilePage()),
        (Route<dynamic> route) => false,
      );
    } else {
      _showAlert(context);
    }
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        title: Text("Oops..."),
        content: Text("Login or password is incorrect"),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xcc83e2f7), Color(0xcc50bce2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Container(
                    alignment: Alignment.center,
                    width: 360,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 30),
                          Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 20,
                              bottom: 0,
                            ),
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xee649bb3),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 230,
                                  child: TextField(
                                    keyboardType: TextInputType.name,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    controller: usernameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Username',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2),
                          Container(
                            padding: EdgeInsets.only(
                              left: 10,
                              right: 20,
                              bottom: 0,
                            ),
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xee649bb3),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 230,
                                  child: TextField(
                                    keyboardType: TextInputType.visiblePassword,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Password',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 2),
                          InkWell(
                            onTap: () => signIn(),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 20,
                                bottom: 0,
                              ),
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xcc83e2f7),
                                    Color(0xcc50bce2)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xee649bb3),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(fontSize: 14),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => SignUpPage(),
                                  ),
                                ),
                                child: Text(
                                  "SignUp",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
