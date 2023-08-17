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
  List<String> imagePath = [];
  Future<void> uploadProfileImage() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseStorage storage = FirebaseStorage.instance;
    // Reference storageRef = storage
    //     .ref()
    //     .child("ProfilePictures")
    //     .child(auth.currentUser!.uid)
    //     .child("test.jpg");
    // String imagePath;
    // var pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    // File uploadImageFile = File(pickedImage!.path);
    // await storageRef.putFile(uploadImageFile).then((data) async {
    //   imagePath = await data.ref.getDownloadURL();
    // }).whenComplete(() => print("Success"));
    File? uploadFile;
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      this.imagePath.add(pickedImage!.path);
      uploadFile = File(pickedImage.path);
    });
// Create the file metadata
    final metadata = SettableMetadata(contentType: "image/jpeg");

// Create a reference to the Firebase Storage bucket
    final storageRef = FirebaseStorage.instance.ref();

// Upload file and metadata to the path 'images/mountains.jpg'
    UploadTask task = storageRef
        .child("images/path/to/mountains.jpg")
        .putFile(uploadFile!, metadata);

    task.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          // ...
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(children: [
        IconButton(
          onPressed: uploadProfileImage,
          icon: const Icon(Icons.camera),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: imagePath.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Image(image: FileImage(File(imagePath[index]))),
                subtitle: Text("image"),
              );
            },
          ),
        )
      ]),
    );
  }
}
