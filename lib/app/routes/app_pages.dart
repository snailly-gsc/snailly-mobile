import 'package:get/get.dart';

import '../modules/browser_surfior/bindings/browser_surfior_binding.dart';
import '../modules/browser_surfior/views/browser_surfior_view.dart';
import '../modules/choose_child/bindings/choose_child_binding.dart';
import '../modules/choose_child/views/choose_child_view.dart';
import '../modules/choose_user/bindings/choose_user_binding.dart';
import '../modules/choose_user/views/choose_user_view.dart';
import '../modules/login_parents/bindings/login_parents_binding.dart';
import '../modules/login_parents/views/login_parents_view.dart';
import '../modules/register_parent/bindings/register_parent_binding.dart';
import '../modules/register_parent/views/register_parent_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/surfior/bindings/surfior_binding.dart';
import '../modules/surfior/views/surfior_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.REGISTER_PARENT,
      page: () => const RegisterParentView(),
      binding: RegisterParentBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PARENTS,
      page: () => const LoginParentsView(),
      binding: LoginParentsBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_USER,
      page: () => const ChooseUserView(),
      binding: ChooseUserBinding(),
    ),
    GetPage(
      name: _Paths.SURFIOR,
      page: () => const SurfiorView(),
      binding: SurfiorBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.BROWSER_SURFIOR,
      page: () => const BrowserSurfiorView(),
      binding: BrowserSurfiorBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_CHILD,
      page: () => const ChooseChildView(),
      binding: ChooseChildBinding(),
    ),
  ];
}
