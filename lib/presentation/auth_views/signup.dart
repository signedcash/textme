import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:textme/data/service_util.dart';
import 'package:textme/domain/model/auth.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  signUp() async {
    SignUp input = SignUp(
        username: usernameController.text,
        name: nameController.text,
        password: passwordController.text);

    http.StreamedResponse response =
        await ServiceUtil().authService.signUp(input);

    if (response.statusCode == 200) {
      Navigator.pop(context);
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
        content: Text("Input error"),
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
              Positioned(
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          EvaIcons.arrowIosBackOutline,
                          size: 32,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                left: 20,
                top: MediaQuery.of(context).padding.top + 10,
              ),
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
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Name',
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
                            onTap: () => signUp(),
                            child: Container(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 20,
                                bottom: 0,
                              ),
                              width: 300,
                              height: 50,
                              alignment: Alignment.center,
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
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
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
