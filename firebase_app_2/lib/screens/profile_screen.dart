import 'dart:io';

import 'package:firebase_app_2/screens/home_screen.dart';
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
  final picker = ImagePicker();
  String? imgPath;
  FirebaseStorage storage = FirebaseStorage.instance;
  late PickedFile? _image;

  Future<void> _getImageAndUpload() async {
    final pickedImage =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 200);

    setState(() {
      _image = PickedFile(pickedImage!.path);
    });

    if (_image != null) {
      Reference reference = storage
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = reference.putFile(File(_image!.path));

      await uploadTask.whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully')),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(children: [
        IconButton(
          onPressed: _getImageAndUpload,
          icon: const Icon(Icons.camera),
        ),
        // IconButton(
        //   onPressed: uploadProfileImage,
        //   icon: const Icon(Icons.upload),
        // ),
      ]),
    );
  }
}
