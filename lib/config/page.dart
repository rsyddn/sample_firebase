import 'package:get/get.dart';
import 'package:sample_firebase/config/routes.dart';
import 'package:sample_firebase/presentation/detail/detail_binding.dart';
import 'package:sample_firebase/presentation/detail/detail_view.dart';
import 'package:sample_firebase/presentation/home/home_binding.dart';
import 'package:sample_firebase/presentation/home/home_view.dart';

class Pages {
  Pages._();

  static const INITIAL = Routes.HOME;
  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      transition: Transition.rightToLeftWithFade,
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.DETAIL,
      page: () => const DetailView(),
      transition: Transition.rightToLeftWithFade,
      binding: DetailBinding(),
    ),
  ];
}
