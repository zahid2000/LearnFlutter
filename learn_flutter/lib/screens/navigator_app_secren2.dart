import 'package:flutter/material.dart';

class NavigatorAppScreen2 extends StatelessWidget {
  const NavigatorAppScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen1")),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: t1,
            ),
            TextFormField(
              controller: t2,
            ),
            ElevatedButton(
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      username: t1.text,
                      password: t2.text,
                    ),
                  ),
                ),
              },
              child: const Text("Enter"),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, this.username, this.password});
  String? username, password;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  exit() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile Screen")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: exit,
            child: const Text("Back"),
          ),
          Text(
            widget.username!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(widget.password!),
        ],
      ),
    );
  }
}
