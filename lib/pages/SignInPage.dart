import 'package:bookmyfield_app/pages/OwnerHomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:bookmyfield_app/Animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:bookmyfield_app/Model/http.dart';
import 'Register_Page.dart';

class SingIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SingInState();
  }
}

class SingInState extends State<SingIn> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visib = true;

  String response = "";
  authUser() async {
    var res = await http_post("users/auth", {
      "email": username.text,
      "password": password.text,
    });
    if (res.data.toString() == "Welcome") {
      setState(() {
        response = "";
        print(response);
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OwnerHomePage(username.text)));
    } else {
      setState(() {
        response = res.data.toString();
        print(response);
        _showMyDialog();
      });
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Incorrect Username or passwrd.'),
                Text('Try again or click Forgot password to reset it.'),
              ],
            ),
          ),
          actions: <Widget>[
            OutlineButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                password.clear();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.pink[900],
          Colors.pink[800],
          Colors.pink[400]
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                      1,
                      Text(
                        "BookMyField",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  FadeAnimation(
                      1.3,
                      Text(
                        "Welcome Back",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(135, 206, 235, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      controller: username,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          hintText: "Email or Username",
                                          prefixIcon:
                                              Icon(Icons.person_outline),
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.grey[200]))),
                                    child: TextField(
                                      controller: password,
                                      obscureText: visib,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          prefixIcon: Icon(Icons.lock),
                                          suffixIcon: IconButton(
                                            icon: Icon(visib
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                            onPressed: () {
                                              setState(() {
                                                visib = !visib;
                                              });
                                            },
                                          ),
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 16,
                        ),
                        FadeAnimation(
                            1.5,
                            Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.grey),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.6,
                            SizedBox(
                              width: 180,
                              height: 50,
                              child: RaisedButton(
                                onPressed: authUser,
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                color: Colors.pink,
                                child: Text("Login",
                                    style: TextStyle(fontSize: 18)),
                              ),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.9,
                            InkWell(
                              child: Text("Sign up"),
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return RegisterPage();
                                }));
                              },
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
