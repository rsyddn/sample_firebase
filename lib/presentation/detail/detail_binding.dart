import 'package:get/get.dart';
import 'package:sample_firebase/presentation/detail/detail_controller.dart';
import 'package:sample_firebase/presentation/home/home_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailController());
  }
}
