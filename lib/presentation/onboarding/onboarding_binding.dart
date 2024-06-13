import 'package:get/get.dart';
import 'package:sample_firebase/presentation/onboarding/onboarding_controller.dart';

class OnBoardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OnBoardingController());
  }
}
