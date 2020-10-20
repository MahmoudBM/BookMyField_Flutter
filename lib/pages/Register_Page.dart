import 'package:bookmyfield_app/Model/http.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController image = TextEditingController();

  String response = "";
  createUser() async {
    print("Welcome " + firstname.text);
    var result = await http_post("users/add", {
      "nom": firstname.text,
      "prenom": lastname.text,
      "email": username.text,
      "password": password.text,
      "phone": int.parse(phone.text),
      "role": int.parse(role.text),
      "image": image.text
    });
    if (result.ok) {
      setState(() {
        response = result.data.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register here"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: firstname,
            decoration: InputDecoration(hintText: "First name"),
          ),
          TextField(
            controller: lastname,
            decoration: InputDecoration(hintText: "Last name"),
          ),
          TextField(
            controller: username,
            decoration: InputDecoration(hintText: "Username"),
          ),
          TextField(
            controller: password,
            decoration: InputDecoration(hintText: "Password"),
          ),
          TextField(
              controller: phone,
              decoration: InputDecoration(hintText: "Phone"),
              keyboardType: TextInputType.number),
          TextField(
            controller: role,
            decoration: InputDecoration(hintText: "Role"),
          ),
          TextField(
            controller: image,
            decoration: InputDecoration(hintText: "Image"),
          ),
          RaisedButton(
            child: Text("Register"),
            onPressed: createUser,
          ),
          Text(response)
        ],
      ),
    );
  }
}
