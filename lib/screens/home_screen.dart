import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:step_test/screens/user_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  Future<void> addUser() {
    return users
        .add({'full_name': 'Sok Sokvannara', 'company': 'IT', 'age': 22})
        .then((value) => debugPrint("User Added"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: CupertinoButton(
          color: Colors.red,
          child: const Text('Add User'),
          onPressed: () {
            addUser().then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                //return const GetUserName();
                return const UserScreen();
              }));
            });
          },
        ),
      ),
    );
  }
}
