import 'package:clg_event_management_new/features/students/home/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Event List')),
      body: ListView.builder(
        itemCount: controller.events.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(controller.events[index]),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Get.toNamed(
                  AppRoutes.eventDetails,
                  arguments: controller.events[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}