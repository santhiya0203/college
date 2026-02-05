// controllers/create_student_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../../../../services/admin_firebase_services.dart';
import '../../data/models/student_model.dart';


class CreateStudentFormController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  final ImagePicker _picker = ImagePicker();

  final formKey = GlobalKey<FormState>();

  // Controllers
  final nameController = TextEditingController();
  final rollController = TextEditingController();
  final departmentController = TextEditingController();
  final studiedYearController = TextEditingController();
  final joinDateController = TextEditingController();
  final dobController = TextEditingController();

  // Observable states
  Rx<DateTime?> selectedDob = Rx<DateTime?>(null);
  Rx<DateTime?> selectedJoinDate = Rx<DateTime?>(null);
  RxBool isLoading = false.obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  // Pick Image
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        selectedImage.value = File(image.path);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to pick image: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Take Photo
  Future<void> takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (photo != null) {
        selectedImage.value = File(photo.path);
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to take photo: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Remove selected image
  void removeImage() {
    selectedImage.value = null;
  }

  // Pick DOB
  Future<void> pickDob(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2002),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedDob.value = picked;
      dobController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  // Pick Join Date
  Future<void> pickJoinDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      selectedJoinDate.value = picked;
      joinDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  // Auto timestamps
  String get currentTimestamp => DateTime.now().toIso8601String();

  // Validation methods
  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? validateRollNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Roll number is required';
    }
    return null;
  }

  String? validateDepartment(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Department is required';
    }
    return null;
  }

  String? validateStudiedYear(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Studied year is required';
    }
    final year = int.tryParse(value);
    if (year == null) {
      return 'Please enter a valid number';
    }
    if (year < 1 || year > 5) {
      return 'Year must be between 1 and 5';
    }
    return null;
  }

  String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Date is required';
    }
    return null;
  }

// CREATE - Submit form and create student in Firestore
  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;

        // Generate unique student ID first (Firestore auto-generates)
        String studentId = _firebaseService.studentsCollection.doc().id;

        // Create student object with the generated ID
        Student student = Student(
          id: studentId,  // Set the ID here
          name: nameController.text.trim(),
          rollNumber: rollController.text.trim(),
          department: departmentController.text.trim(),
          dateOfBirth: dobController.text.trim(),
          studiedYear: int.parse(studiedYearController.text),
          joinDate: joinDateController.text.trim(),
          createdAt: currentTimestamp,
          updatedAt: currentTimestamp,
          imageUrl: null,
        );

        // Upload image if selected (before saving to Firestore)
        if (selectedImage.value != null) {
          String imageUrl = await _firebaseService.uploadImage(
            selectedImage.value!,
            studentId,
          );
          student.imageUrl = imageUrl;
        }

        // Save complete student data to Firestore with the pre-generated ID
        await _firebaseService.studentsCollection.doc(studentId).set(student.toJson());

        Get.snackbar(
          "Success",
          "Student Added to Firestore Successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        clearForm();

      } catch (e) {
        Get.snackbar(
          "Error",
          "Failed to create student: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  void clearForm() {
    nameController.clear();
    rollController.clear();
    departmentController.clear();
    studiedYearController.clear();
    joinDateController.clear();
    dobController.clear();
    selectedDob.value = null;
    selectedJoinDate.value = null;
    selectedImage.value = null;
    formKey.currentState?.reset();
  }

  @override
  void onClose() {
    nameController.dispose();
    rollController.dispose();
    departmentController.dispose();
    studiedYearController.dispose();
    joinDateController.dispose();
    dobController.dispose();
    super.onClose();
  }
}