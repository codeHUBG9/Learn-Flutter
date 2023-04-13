import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class Post {
  String body;
  String author;
  int likes = 0;
  bool userLiked = false;
  Post(this.body, this.author);

  void likePost() {
    this.userLiked = !this.userLiked;
    this.userLiked ? this.likes += 1 : this.likes -= 1;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
    );
  }
}

//== stateless
// class MyHomePage1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Hello World!'),
//         ),
//         body: TextInputButton());
//   }
// }

//----- For TextField+Button+Label
//statefull
// class MyHomePage2 extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String text = "";
//   void changeText(String text) {
//     this.setState(() {
//       this.text = text;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Hello World!'),
//         ),
//         body: Column(
//           children: <Widget>[TextInputButton(this.changeText), Text(this.text)],
//         ));
//   }
// }

//---------End

// class MyHomePage3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Hello World!'),
//         ),
//         body: TextInputButton());
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  void newPost(String text) {
    this.setState(() {
      posts.add(new Post(text, "Vivek"));
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

/**
 * For Just practice
 */
class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Spraxa- ");
  }
}

//==============- Stateful Widgets first -==================
class TextInputWidget extends StatefulWidget {
  const TextInputWidget({super.key});

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();
  String text = "";
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void changeText(text) {
    if (text == "Vivek!") {
      controller.clear();
      text = "";
    }
    setState(() {
      this.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefix: Icon(Icons.message), hintText: "Type a messages dsdsa"),
        onChanged: (text) => this.changeText(text),
      ),
      Text(this.text)
    ]);
  }
}

//==============- Stateful Widgets Second -==================
class TextInputButton extends StatefulWidget {
  final Function(String) callback;

  TextInputButton(this.callback);

  @override
  State<TextInputButton> createState() => _TextInputButtonState();
}

class _TextInputButtonState extends State<TextInputButton> {
  final controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void postMsg() {
    widget.callback(controller.text);
    controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefix: Icon(Icons.message),
            hintText: "Type a messages dsdsa",
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              splashColor: Colors.blue,
              tooltip: "Post message",
              onPressed: this.postMsg,
            )));
  }
}

//------list view

class PostList extends StatefulWidget {
  final List<Post> listItems;
  PostList(this.listItems);
  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
        return Card(
          child: Row(children: <Widget>[
            Expanded(
                child: ListTile(
              title: Text(post.body),
              subtitle: Text(post.author),
            )),
            Row(
              children: <Widget>[
                Container(
                  child: Text(
                    post.likes.toString(),
                    style: TextStyle(fontSize: 20),
                  ),
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                ),
                IconButton(
                  onPressed: () => like(post.likePost),
                  icon: Icon(Icons.thumb_up),
                  color: post.userLiked ? Colors.green : Colors.black,
                )
              ],
            )
          ]),
        );
      },
    );
  }
}
