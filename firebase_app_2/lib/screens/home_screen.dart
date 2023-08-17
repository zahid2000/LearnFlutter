import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/custom_alert.dart';
import '../models/blog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase App"),
        centerTitle: true,
      ),
      body: const _BuildHomeScreen(),
    );
  }
}

class _BuildHomeScreen extends StatefulWidget {
  const _BuildHomeScreen();

  @override
  State<_BuildHomeScreen> createState() => __BuildHomeScreenState();
}

class __BuildHomeScreenState extends State<_BuildHomeScreen> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  String header = '', body = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  List<Blog> blogs = [];
  create() {
    
    FirebaseFirestore.instance
        .collection("Blogs")
        .doc(t1.text)
        .set({'userId':auth.currentUser!.uid,'header': t1.text, 'body': t2.text}).whenComplete(() =>
            showDialog(
                context: context,
                builder: (context) => CustomAlert(
                    title: "Success", content: "Blog created", success: true)));
  }

  update() {
    FirebaseFirestore.instance
        .collection("Blogs")
        .doc(t1.text)
        .update({'userId':auth.currentUser!.uid,'header': t1.text, 'body': t2.text}).whenComplete(() =>
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
