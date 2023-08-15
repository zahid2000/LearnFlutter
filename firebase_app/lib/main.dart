import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fiebase App",
      home: BuildScaffold(),
    );
  }
}

class BuildScaffold extends StatelessWidget {
  const BuildScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase App"),
        centerTitle: true,
      ),
      body: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  String header = '', body = '';

  List<Blog> blogs = [];
  create() {
    FirebaseFirestore.instance
        .collection("Blogs")
        .doc(t1.text)
        .set({'header': t1.text, 'body': t2.text}).whenComplete(() =>
            showDialog(
                context: context,
                builder: (context) => CustomAlert(
                    title: "Success", content: "Blog created", success: true)));
  }

  update() {
    FirebaseFirestore.instance
        .collection("Blogs")
        .doc(t1.text)
        .update({'header': t1.text, 'body': t2.text}).whenComplete(() =>
            showDialog(
                context: context,
                builder: (context) => CustomAlert(
                    title: "Success", content: "Blog updated", success: true)));
  }

  delete() {
    FirebaseFirestore.instance
        .collection("Blogs")
        .doc(t1.text)
        .delete()
        .whenComplete(() => showDialog(
            context: context,
            builder: (context) => CustomAlert(
                title: "Success", content: "Blog deleted", success: false)));
  }

  get() {
    FirebaseFirestore.instance
        .collection("Blogs")
        .get()
        .then((resp) => resp.docs)
        .then((docs) {
      setState(() {
        blogs.clear();
        for (var doc in docs) {
          blogs.add(
            Blog(
              header: doc.data()['header'],
              body: doc.data()['body'],
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(40),
      child: Center(
          child: Column(
        children: [
          TextField(controller: t1),
          TextField(controller: t2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: create,
                child: const Text("Create"),
              ),
              ElevatedButton(
                onPressed: update,
                child: const Text("Update"),
              ),
              ElevatedButton(
                onPressed: delete,
                child: const Text("Delete"),
              ),
              ElevatedButton(
                onPressed: get,
                child: const Text("Get"),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(blogs[index].header!),
                  subtitle: Text(blogs[index].body!),
                  onTap: () {
                    t1.text = blogs[index].header!;
                    t2.text = blogs[index].body!;
                  },
                );
              },
            ),
          )
        ],
      )),
    );
  }
}

// ignore: must_be_immutable
class CustomAlert extends StatelessWidget {
  String title, content;
  bool success;
  CustomAlert(
      {required this.title,
      required this.content,
      required this.success,
      super.key});

  @override
  Widget build(BuildContext context) {
    const TextStyle successStyle = TextStyle(
      backgroundColor: Colors.green,
      color: Colors.white,
    );
    const TextStyle errorStyle = TextStyle(
      backgroundColor: Colors.red,
      color: Colors.white,
    );
    return AlertDialog(
      title: Text(title),
      titleTextStyle: success ? successStyle : errorStyle,
      content: Text(content),
      actions: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
          color: Colors.red,
        )
      ],
    );
  }
}

class Blog {
  String? header, body;
  Blog({this.header, this.body});
}
