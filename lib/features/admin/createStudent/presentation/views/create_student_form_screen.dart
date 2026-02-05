import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/create_student_controller.dart';

class CreateStudentFormScreen extends StatelessWidget {
  final controller = Get.find<CreateStudentFormController>();

  CreateStudentFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              _animatedField(
                child: _inputField(
                  controller.nameController,
                  "Student Name",
                  validator: (v) =>
                  v!.isEmpty ? "Name is required" : null,
                ),
              ),

              _animatedField(
                delay: 100,
                child: _inputField(
                  controller.rollController,
                  "Roll Number",
                  validator: (v) =>
                  v!.isEmpty ? "Roll Number required" : null,
                ),
              ),

              _animatedField(
                delay: 200,
                child: _inputField(
                  controller.departmentController,
                  "Department",
                  validator: (v) =>
                  v!.isEmpty ? "Department required" : null,
                ),
              ),

              _animatedField(
                delay: 300,
                child: _inputField(
                  controller.studiedYearController,
                  "Studied Year",
                  keyboard: TextInputType.number,
                  validator: (v) {
                    if (v!.isEmpty) return "Required";
                    if (int.tryParse(v) == null) return "Invalid year";
                    return null;
                  },
                ),
              ),

              _animatedField(
                delay: 400,
                child: _inputField(
                  controller.joinDateController,
                  "Join Date (YYYY-MM-DD)",
                  validator: (v) =>
                  v!.isEmpty ? "Join date required" : null,
                ),
              ),

              _animatedField(
                delay: 500,
                child: TextFormField(
                  controller: controller.dobController,
                  readOnly: true,
                  onTap: () => controller.pickDob(context),
                  decoration: const InputDecoration(
                    labelText: "Date of Birth",
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                  v!.isEmpty ? "Select DOB" : null,
                ),
              ),

              const SizedBox(height: 30),

              _animatedField(
                delay: 600,
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.submitForm,
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(
      TextEditingController controller,
      String label, {
        String? Function(String?)? validator,
        TextInputType keyboard = TextInputType.text,
      }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Widget _animatedField({required Widget child, int delay = 0}) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 500 + delay),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
