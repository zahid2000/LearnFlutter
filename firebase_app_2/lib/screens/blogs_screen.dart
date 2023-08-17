import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blogs"),
        centerTitle: true,
      ),
      body: const _BuildBlogsScreen(),
    );
  }
}

class _BuildBlogsScreen extends StatefulWidget {
  const _BuildBlogsScreen();

  @override
  __BuildBlogsScreenState createState() => __BuildBlogsScreenState();
}

class __BuildBlogsScreenState extends State<_BuildBlogsScreen> {
  final Stream<QuerySnapshot> _blogsStream =
      FirebaseFirestore.instance.collection('Blogs').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _blogsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['header']),
              subtitle: Text(data['body']),
            );
          }).toList(),
        );
      },
    );
  }
}
