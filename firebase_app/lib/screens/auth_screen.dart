import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/components/custom_alert.dart';
import 'package:firebase_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login or Register"),
        centerTitle: true,
      ),
      body: const _BuildAuthScreen(),
    );
  }
}

class _BuildAuthScreen extends StatefulWidget {
  const _BuildAuthScreen();

  @override
  State<_BuildAuthScreen> createState() => __BuildAuthScreenState();
}

class __BuildAuthScreenState extends State<_BuildAuthScreen> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  Future<void> register() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((user) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(t1.text)
          .set({"Email": t1.text, "Password": t2.text});
      showDialog(
          context: context,
          builder: (context) => CustomAlert(
              title: "Successfull",
              content: "Registered Successfully",
              success: true));
    }).onError(
      (error, stackTrace) => showDialog(
        context: context,
        builder: (context) => CustomAlert(
            title: 'Error', content: error.toString(), success: false),
      ),
    );
  }

  login() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((user) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(),
        ),
        (route) => false,
      );
    }).onError(
      (error, stackTrace) => showDialog(
        context: context,
        builder: (context) => CustomAlert(
            title: 'Error', content: error.toString(), success: false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(40),
      child: Center(
        child: Column(
          children: [
            TextFormField(
              controller: t1,
            ),
            TextFormField(
              controller: t2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: register,
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child: const Icon(Icons.create),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: login,
                  child: const Icon(
                    Icons.login,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
