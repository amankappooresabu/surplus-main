import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:surplus/chatscreen.dart';
import 'package:surplus/user_data.dart'; // Import UserData model (modified)

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.hasData) {
            final users = snapshot.data!.docs
                .map((doc) => UserData.fromMap(doc.data()))
                .toList();
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name), // Display user name
                  onTap: () {
                    // Navigate to ChatScreen for this user
                  Get.to(() => ChatScreen(), arguments: {'name': user.name, 'uid': user.uid, 'recipientId': user.uid});

                  },
                );
              },
            );
          }

          return CircularProgressIndicator(); // Show loading indicator initially
        },
      ),
    );
  }
}
