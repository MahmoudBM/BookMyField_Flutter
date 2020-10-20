import 'package:bookmyfield_app/Model/http.dart';
import 'package:bookmyfield_app/pages/Register_Page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WelcomePageState();
  }
}

class User {
  String username;
  String role;
  User(this.username, this.role);
}

class WelcomePageState extends State<WelcomePage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  // int rolee = 0;
/*
  findUser() async {
    var result = await http_get("users/getUsername/{email}", {
      "email": username.text,
    });

    if (result.ok) {}
  }
*/
  String response = "";
  authUser() async {
    var res = await http_post("users/auth", {
      "email": username.text,
      "password": password.text,
    });
    if (res.data.toString() == "Welcome") {
    } else {
      setState(() {
        response = res.data.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return RegisterPage();
              }));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: username,
              decoration: InputDecoration(hintText: "Username"),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(hintText: "Password"),
            ),
            RaisedButton(
              child: Text("Login"),
              onPressed: authUser,
            ),
            Text(response)
          ],
        ),
      ),
    );
  }
}
