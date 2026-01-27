import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            Text('Name: ${data['name']}'),
            Text('Register No: ${data['reg']}'),
            Text('Email: ${data['email']}'),
          ],
        ),
      ),
    );
  }
}