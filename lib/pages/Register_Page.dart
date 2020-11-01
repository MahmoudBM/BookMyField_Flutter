import 'package:bookmyfield_app/Model/http.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:bookmyfield_app/Animation/FadeAnimation.dart';
import 'package:flutter/cupertino.dart';

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
  int role = 1;
  String response = "";
  createUser() async {
    print("Welcome " + firstname.text);
    var result = await http_post("users/add", {
      "nom": firstname.text,
      "prenom": lastname.text,
      "email": username.text,
      "password": password.text,
      "phone": int.parse(phone.text),
      "role": role.toString(),
      "image": "image.png"
    });
    if (result.ok) {
      setState(() {
        response = result.data.toString();
      });
    }
  }

  Future<String> uploadImage(filename, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['nom'] = firstname.text;
    request.fields['prenom'] = lastname.text;
    request.fields['email'] = username.text;
    request.fields['password'] = password.text;
    request.fields['phone'] = phone.text;
    request.fields['role'] = role.toString();
    request.files
        .add(await http.MultipartFile.fromPath('uploadImage', filename));
    var res = await request.send();
    return res.reasonPhrase;
  }

  String state = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 40.0),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.pink[900],
          Colors.pink[800],
          Colors.pink[400]
        ])),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1,
                        Text(
                          "Register now",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
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
                          height: 30,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(255, 9, 235, .3),
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
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter your first name';
                                        }
                                        return null;
                                      },
                                      controller: firstname,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                          hintText: "First name",
                                          prefixIcon: Icon(Icons.person),
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
                                    child: TextFormField(
                                      controller: lastname,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter your last name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Last name",
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
                                    child: TextFormField(
                                      controller: username,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter a username';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.email),
                                          hintText: "Email or Username",
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
                                    child: TextFormField(
                                      controller: password,
                                      obscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter a password';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          prefixIcon: Icon(Icons.lock),
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
                                    child: TextFormField(
                                      controller: phone,
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter your phone number';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.phone),
                                          hintText: "Phone number",
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
                                    child: Row(
                                      children: <Widget>[
                                        Text("Owner"),
                                        Radio(
                                          value: 1,
                                          groupValue: role,
                                          activeColor: Colors.pink,
                                          onChanged: (T) {
                                            print(T);
                                            setState(() {
                                              role = T;
                                            });
                                          },
                                        ),
                                        Text("Player"),
                                        Radio(
                                          value: 2,
                                          groupValue: role,
                                          activeColor: Colors.pink,
                                          onChanged: (T) {
                                            print(T);
                                            setState(() {
                                              role = T;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FadeAnimation(
                                    1.6,
                                    SizedBox(
                                      width: 180,
                                      height: 50,
                                      child: RaisedButton(
                                          textColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                          ),
                                          color: Colors.pink,
                                          child: Text("Register",
                                              style: TextStyle(fontSize: 18)),
                                          onPressed: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              var file =
                                                  await ImagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery);
                                              var res = await uploadImage(
                                                  file.path,
                                                  "http://192.168.137.60:3000/users/add");
                                              setState(() {
                                                state = res;
                                                print(res);
                                              });
                                            }
                                          }),
                                    ),
                                  ),
                                  Text(response)
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
