import 'package:flutter/material.dart';
import 'post.dart';
import 'postList.dart';
import 'textInputButton.dart';

class MyHomePage extends StatefulWidget {
  final String email;
  MyHomePage(this.email);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  void newPost(String text) {
    this.setState(() {
      posts.add(new Post(text, widget.email));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello World!'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: PostList(this.posts)),
            TextInputButton(this.newPost),
          ],
        ));
  }
}
