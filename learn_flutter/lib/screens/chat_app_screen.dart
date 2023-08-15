import 'package:flutter/material.dart';

class ChatAppScrenn extends StatelessWidget {
  const ChatAppScrenn({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Chat Messenger",
      home: BuildChatScreen(),
    );
  }
}

class BuildChatScreen extends StatefulWidget {
  const BuildChatScreen({super.key});

  @override
  State<BuildChatScreen> createState() => _BuildChatScreenState();
}

class _BuildChatScreenState extends State<BuildChatScreen> {
  List<MessageBubble> messages = [];
  TextEditingController t1 = TextEditingController();

  sendMessage(String message) {
    setState(() {
      messages.insert(0, MessageBubble(message));
      t1.clear();
    });
  }

  Widget messageField() {
    return Row(children: [
      Flexible(
        child: TextField(
          onSubmitted: sendMessage,
          controller: t1,
        ),
      ),
      IconButton(
          onPressed: () => sendMessage(t1.text), icon: const Icon(Icons.send))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Messenger"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(children: [
          Flexible(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                return messages[index];
              },
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          messageField()
        ]),
      ),
    );
  }
}

String user = "Zahid";

// ignore: must_be_immutable
class MessageBubble extends StatelessWidget {
  String message;
  MessageBubble(
    this.message, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Row(children: [
        const CircleAvatar(
          backgroundImage: NetworkImage(
              "https://www.pngarts.com/files/6/User-Avatar-in-Suit-PNG.png"),
        ),
        Column(
          children: [
            Text(user),
            Text(message),
          ],
        )
      ]),
    );
  }
}
