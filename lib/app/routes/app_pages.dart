import 'package:get/get.dart';

import '../modules/action_parent/bindings/action_parent_binding.dart';
import '../modules/action_parent/views/action_parent_view.dart';
import '../modules/add_child/bindings/add_child_binding.dart';
import '../modules/add_child/views/add_child_view.dart';
import '../modules/allow_parent/bindings/allow_parent_binding.dart';
import '../modules/allow_parent/views/allow_parent_view.dart';
import '../modules/block_parent/bindings/block_parent_binding.dart';
import '../modules/block_parent/views/block_parent_view.dart';
import '../modules/browser_surfior/bindings/browser_surfior_binding.dart';
import '../modules/browser_surfior/views/browser_surfior_view.dart';
import '../modules/choose_child/bindings/choose_child_binding.dart';
import '../modules/choose_child/views/choose_child_view.dart';
import '../modules/choose_child_name/bindings/choose_child_name_binding.dart';
import '../modules/choose_child_name/views/choose_child_name_view.dart';
import '../modules/choose_user/bindings/choose_user_binding.dart';
import '../modules/choose_user/views/choose_user_view.dart';
import '../modules/list_child/bindings/list_child_binding.dart';
import '../modules/list_child/views/list_child_view.dart';
import '../modules/login_move_toReportior/bindings/login_move_to_reportior_binding.dart';
import '../modules/login_move_toReportior/views/login_move_to_reportior_view.dart';
import '../modules/login_parents/bindings/login_parents_binding.dart';
import '../modules/login_parents/views/login_parents_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/preview_website/bindings/preview_website_binding.dart';
import '../modules/preview_website/views/preview_website_view.dart';
import '../modules/register_parent/bindings/register_parent_binding.dart';
import '../modules/register_parent/views/register_parent_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
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
      name: _Paths.CHOOSE_CHILD_NAME,
      page: () => const ChooseChildNameView(),
      binding: ChooseChildNameBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_MOVE_TO_REPORTIOR,
      page: () => const LoginMoveToReportiorView(),
      binding: LoginMoveToReportiorBinding(),
    ),
    GetPage(
      name: _Paths.LIST_CHILD,
      page: () => const ListChildView(),
      binding: ListChildBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CHILD,
      page: () => const AddChildView(),
      binding: AddChildBinding(),
    ),
    GetPage(
      name: _Paths.SURFIOR,
      page: () => const SurfiorView(),
      binding: SurfiorBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
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
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_CHILD,
      page: () => const ChooseChildView(),
      binding: ChooseChildBinding(),
    ),
    GetPage(
      name: _Paths.ACTION_PARENT,
      page: () => const ActionParentView(),
      binding: ActionParentBinding(),
    ),
    GetPage(
      name: _Paths.ALLOW_PARENT,
      page: () => const AllowParentView(),
      binding: AllowParentBinding(),
    ),
    GetPage(
      name: _Paths.BLOCK_PARENT,
      page: () => const BlockParentView(),
      binding: BlockParentBinding(),
    ),
    GetPage(
      name: _Paths.PREVIEW_WEBSITE,
      page: () => const PreviewWebsiteView(),
      binding: PreviewWebsiteBinding(),
    ),
  ];
}
