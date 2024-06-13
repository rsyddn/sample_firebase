import 'package:get/get.dart';
import 'package:sample_firebase/presentation/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
