import 'package:flutter/material.dart';

class NavigatorAppScreen extends StatelessWidget {
  const NavigatorAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
        "/Profile": (context) => const ProfileScreen()
      },
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
  enter() {
    if (t1.text == "admin" && t2.text == "1234") {
      Navigator.pushNamed(context, "/Profile",
          arguments: LoginDto(userName: t1.text, password: t2.text));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Diqqət"),
          content: const Text("Dogru məlumat daxil edin!"),
          actions: [
            FloatingActionButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Ok"),
            )
          ],
        ),
      );
    }
  }

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
              onPressed: enter,
              child: const Text("Enter"),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  exit() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    LoginDto dto = ModalRoute.of(context)?.settings.arguments as LoginDto;

    return Scaffold(
      appBar: AppBar(title: const Text("Profile Screen")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: exit,
            child: const Text("Back"),
          ),
          Text(
            dto.userName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(dto.password),
        ],
      ),
    );
  }
}

class LoginDto {
  String userName, password;
  LoginDto({required this.userName, required this.password});
}
