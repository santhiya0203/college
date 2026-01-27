import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
/*

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 80, color: Color(0xFF1E7F78)),
            const SizedBox(height: 16),
            const Text(
              'College Event Management',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            TextField(
              controller: controller.rollController,
              decoration: const InputDecoration(
                labelText: 'Roll Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: controller.dobController,
              decoration: const InputDecoration(
                labelText: 'Date of Birth',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E7F78),
                ),
                onPressed: controller.login,
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/
class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1E7F78),
              const Color(0xFF2D9B94),
              const Color(0xFF1E7F78).withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Logo
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Opacity(
                          opacity: value,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.school,
                              size: 80,
                              color: Color(0xFF1E7F78),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Animated Title
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 1000),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: const Text(
                            'College Event\nManagement',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 48),

                  // Login Card with Animation
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 1200),
                    tween: Tween<double>(begin: 0, end: 1),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 30 * (1 - value)),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Welcome Back!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E7F78),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Sign in to continue',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Roll Number Field
                                Obx(() => Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller: controller.rollController,
                                      decoration: InputDecoration(
                                        labelText: 'Roll Number',
                                        prefixIcon: const Icon(
                                          Icons.badge,
                                          color: Color(0xFF1E7F78),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF1E7F78),
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[50],
                                      ),
                                      onChanged: (_) =>
                                          controller.validateRollNumber(),
                                    ),
                                    if (controller
                                        .rollNumberError.value.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 12),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.error_outline,
                                              size: 16,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              controller
                                                  .rollNumberError.value,
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                )),
                                const SizedBox(height: 20),

                                // Date of Birth Field
                                Obx(() => Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller: controller.dobController,
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: 'Date of Birth',
                                        hintText: 'DD/MM/YYYY',
                                        prefixIcon: const Icon(
                                          Icons.calendar_today,
                                          color: Color(0xFF1E7F78),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: Color(0xFF1E7F78),
                                            width: 2,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 2,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.grey[50],
                                      ),
                                      onTap: () =>
                                          controller.selectDate(context),
                                    ),
                                    if (controller.dobError.value.isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 12),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.error_outline,
                                              size: 16,
                                              color: Colors.red,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              controller.dobError.value,
                                              style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                )),
                                const SizedBox(height: 32),

                                // Login Button
                                Obx(() => SizedBox(
                                  width: double.infinity,
                                  height: 54,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                      const Color(0xFF1E7F78),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      elevation: 4,
                                      shadowColor: const Color(0xFF1E7F78)
                                          .withOpacity(0.5),
                                    ),
                                    onPressed: controller.isLoading.value
                                        ? null
                                        : controller.login,
                                    child: controller.isLoading.value
                                        ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child:
                                      CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                        : const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}