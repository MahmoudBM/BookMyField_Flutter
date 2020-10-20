import 'package:bookmyfield_app/pages/SignInPage.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BookMyField",
      home: SingIn(),
      debugShowCheckedModeBanner: false,
    );
  }
}

void main() {
  runApp(App());
}
