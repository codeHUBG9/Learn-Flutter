import 'package:flutter/material.dart';
import 'package:hello_world/myHomePage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Page')),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email = "";
  TextEditingController controller = new TextEditingController();
  void click() {
    email = controller.text;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyHomePage(email)));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          controller: this.controller,
          decoration: InputDecoration(
              prefix: Icon(Icons.email),
              labelText: "Email",
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 5, color: Colors.black)),
              suffixIcon: IconButton(
                icon: Icon(Icons.done),
                splashColor: Colors.blue,
                tooltip: "Submit",
                onPressed: click,
              )),
        ),
      ),
    );
  }
}
