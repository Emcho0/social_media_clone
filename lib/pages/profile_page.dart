import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_clone/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // user
  final currentUser = FirebaseAuth.instance.currentUser!;

  // all users
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  // edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color(0xFF878996), // Yorumi Mist background color
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Color(0xFF060914)), // Yorumi Mist text color
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Color(0xFF060914)), // Yorumi Mist text color
          decoration: InputDecoration(
            hintText: "Enter new $field",
            hintStyle: TextStyle(color: Color(0xFF343742)), // Yorumi Mist hint color
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF060914)), // Yorumi Mist text color
            ),
          ),
          // save button
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: Text(
              'Save',
              style: TextStyle(color: Color(0xFF060914)), // Yorumi Mist text color
            ),
          ),
        ],
      ),
    );

    // update in Firestore
    if (newValue.trim().isNotEmpty) {
      await usersCollection.doc(currentUser.email).update({
        field: newValue,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBDBFCB), // Yorumi Mist background color
      appBar: AppBar(
        title: Text("Profile Page"),
        backgroundColor: Color(0xFF878996), // Yorumi Mist app bar color
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          // get user data
          if (snapshot.hasData) {
            final userData = snapshot.data?.data() as Map<String, dynamic>? ?? {};
            return ListView(
              children: [
                const SizedBox(height: 50),
                // profile pic
                Icon(
                  Icons.person,
                  size: 72,
                  color: Color(0xFF060914), // Yorumi Mist icon color
                ),
                const SizedBox(height: 10),
                // user email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF343742)), // Yorumi Mist text color
                ),
                // user details
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    "My Details",
                    style: TextStyle(color: Color(0xFF343742)), // Yorumi Mist text color
                  ),
                ),
                // username
                MyTextBox(
                  text: userData['username'],
                  sectionName: 'username',
                  onPressed: () => editField('username'),
                ),
                // bio
                MyTextBox(
                  text: userData['bio'],
                  sectionName: 'bio',
                  onPressed: () => editField('bio'),
                ),
                const SizedBox(height: 50),
                // user posts
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: Text(
                    "My Posts",
                    style: TextStyle(color: Color(0xFF343742)), // Yorumi Mist text color
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error ${snapshot.error}'),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}