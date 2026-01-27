import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../routes/app_routes.dart';

class EventRegisterScreen extends StatefulWidget {
  const EventRegisterScreen({super.key});

  @override
  State<EventRegisterScreen> createState() => _EventRegisterScreenState();
}

class _EventRegisterScreenState extends State<EventRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final regCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: 'Student Name'),
                validator: (v) =>
                v!.isEmpty ? 'Enter name' : null,
              ),
              TextFormField(
                controller: regCtrl,
                decoration:
                const InputDecoration(labelText: 'Register Number'),
                validator: (v) =>
                v!.isEmpty ? 'Enter register number' : null,
              ),
              TextFormField(
                controller: emailCtrl,
                decoration: const InputDecoration(labelText: 'Email ID'),
                validator: (v) =>
                v!.isEmpty ? 'Enter email' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Get.toNamed(
                      AppRoutes.userProfile,
                      arguments: {
                        'name': nameCtrl.text,
                        'reg': regCtrl.text,
                        'email': emailCtrl.text,
                      },
                    );
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}