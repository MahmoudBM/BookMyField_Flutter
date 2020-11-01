import 'package:bookmyfield_app/Model/http.dart';
import 'package:flutter/material.dart';

class OwnerHomePage extends StatefulWidget {
  final String username;
  OwnerHomePage(this.username, {Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => OwnerHomePageState();
}

class OwnerHomePageState extends State<OwnerHomePage> {
  String nom, prenom, phone, email, img;
  String imgProfile;

  Future<String> getData(String data) async {
    var result = await http_get('users/getUsername/${data}');
    if (result.ok) {
      var in_users = result.data;
      setState(() {
        nom = in_users["nom"].toString();
        prenom = in_users["prenom"].toString();
        phone = in_users["phone"].toString();
        email = in_users["email"].toString();
        img = in_users["image"].toString();
        imgProfile = "http://192.168.137.60:3000/uploads/${img}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            imgProfile != null
                ? Image.network(
                    imgProfile,
                    height: 100,
                    width: 100,
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            Text(
              "First Name : " + prenom.toString(),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Last Name : " + nom.toString()),
            SizedBox(
              height: 20,
            ),
            Text(
              "Email adress : " + email.toString(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Phone : " + phone.toString(),
            ),
          ],
        ));
  }
}
