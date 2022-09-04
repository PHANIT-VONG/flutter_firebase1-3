import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  //final String documentId;

  const GetUserName({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Username'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc('ZWV8lgHJMxeVygeaaU6O').get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(
              "Full Name: ${data['full_name']}\nAge: ${data['age']}\nCompany: ${data['company']}",
              style: Theme.of(context).textTheme.headline4,
            );
          }

          return const Text("loading");
        },
      ),
    );
  }
}
