import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../routes/app_routes.dart';


class LoginController extends GetxController {
  final rollController = TextEditingController();
  final dobController = TextEditingController();

  var rollNumberError = ''.obs;
  var dobError = ''.obs;
  var isLoading = false.obs;

  void validateRollNumber() {
    if (rollController.text.isEmpty) {
      rollNumberError.value = 'Roll number is required';
    } else if (rollController.text.length < 4) {
      rollNumberError.value = 'Roll number must be at least 4 characters';
    } else if (!RegExp(r'^[A-Za-z0-9]+$').hasMatch(rollController.text)) {
      rollNumberError.value = 'Only letters and numbers allowed';
    } else {
      rollNumberError.value = '';
    }
  }

  void validateDOB() {
    if (dobController.text.isEmpty) {
      dobError.value = 'Date of birth is required';
    } else {
      dobError.value = '';
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1E7F78),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      validateDOB();
    }
  }

  void login() async {
    // Validate all fields
    validateRollNumber();
    validateDOB();

    // Check if there are any errors
    if (rollNumberError.value.isNotEmpty || dobError.value.isNotEmpty) {
      return;
    }

    // Show loading
    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Navigate to home
    isLoading.value = false;
    Get.toNamed(AppRoutes.homeScreen);
  }

  @override
  void onClose() {
    rollController.dispose();
    dobController.dispose();
    super.onClose();
  }
}