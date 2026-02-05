import 'package:get/get.dart';

import '../controllers/create_student_controller.dart';

class CreateStudentFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateStudentFormController>(() => CreateStudentFormController());
  }

}