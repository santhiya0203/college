

import 'package:flutter/material.dart';

/* ================= EVENT  LIST PAGE ================= */

class EventListPage extends StatelessWidget {
  const EventListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event List"),
        backgroundColor: Colors.lightBlue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          EventTile("Technical Symposium"),
          EventTile("Paper Presentation"),
          EventTile("Coding Contest"),
          EventTile("Cultural Fest"),
          EventTile("Flutter Workshop"),
        ],
      ),
    );
  }
}

class EventTile extends StatelessWidget {
  final String title;

  const EventTile(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.event),
        title: Text(title),
      ),
    );
  }
}
