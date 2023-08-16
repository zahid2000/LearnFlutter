import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'auth_screen.dart';
import 'blogs_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BlogsScreen()));
              },
              icon: const Icon(Icons.home)),
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthScreen(),
                  ),
                  (route) => false,
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const _BuildProfileScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _BuildProfileScreen extends StatefulWidget {
  const _BuildProfileScreen();

  @override
  State<_BuildProfileScreen> createState() => __BuildProfileScreenState();
}

class __BuildProfileScreenState extends State<_BuildProfileScreen> {
  uploadProfileImage() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseStorage storage = FirebaseStorage.instance;
    String imagePath;
    File uploadImageFile = File("");
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    Reference ref = storage
        .ref()
        .child("ProfilePictures")
        .child(auth.currentUser!.uid)
        .child("test.png");
    UploadTask task = ref.putFile(File(pickedImage!.path));
    task.then((p0) async {
      imagePath = await p0.ref.getDownloadURL();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(children: [
        FloatingActionButton(
          onPressed: uploadProfileImage,
          child: const Icon(Icons.camera),
        ),
      ]),
    );
  }
}
