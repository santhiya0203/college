import 'package:clg_event_management_new/features/admin/createStudent/presentation/bindings/create_student_form_binding.dart';
import 'package:clg_event_management_new/features/admin/createStudent/presentation/views/create_student_form_screen.dart';
import 'package:clg_event_management_new/features/students/home/presentation/bindings/home_binding.dart';
import 'package:get/get.dart';

import '../features/login/presentation/bindings/login_binding.dart';
import '../features/login/presentation/views/event_details_screen.dart';
import '../features/students/home/presentation/views/home_screen.dart';
import '../features/login/presentation/views/event_register_screen.dart';
import '../features/login/presentation/views/login_screen.dart';
import '../features/login/presentation/views/user_profile_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      binding: LoginBinding(),
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      binding: HomeBinding(),
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.eventDetails,
      page: () => const EventDetailsScreen(),
    ),
    GetPage(
      name: AppRoutes.eventRegister,
      page: () => const EventRegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.userProfile,
      page: () => const UserProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.createStudent,
      binding: CreateStudentFormBinding(),
      page: () =>  CreateStudentFormScreen(),
    ),
  ];
}