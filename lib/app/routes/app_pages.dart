import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../modules/all_projects/bindings/all_projects_binding.dart';
import '../modules/all_projects/views/all_projects_view.dart';
import '../modules/ask_name.dart/bindings/ask_name_dart_binding.dart';
import '../modules/ask_name.dart/views/ask_name_dart_view.dart';
import '../modules/choose_avatar/bindings/choose_avatar_binding.dart';
import '../modules/choose_avatar/views/choose_avatar_view.dart';
import '../modules/first_task/bindings/project_avatar_binding.dart';
import '../modules/first_task/views/project_avatar.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/new_project/bindings/new_project_binding.dart';
import '../modules/new_project/views/new_project_view.dart';
import '../modules/pick_deadline/bindings/pick_deadline_binding.dart';
import '../modules/pick_deadline/views/pick_deadline_view.dart';
import '../modules/profile_page/bindings/profile_page_binding.dart';
import '../modules/profile_page/views/profile_page_view.dart';
import '../modules/project_management/bindings/project_management_binding.dart';
import '../modules/project_management/views/project_management_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/welcome_screen/bindings/welcome_screen_binding.dart';
import '../modules/welcome_screen/views/welcome_screen_view.dart';
import '../views/single%20pages/increase_deadline.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final INITIAL = Routes.WELCOME_SCREEN;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => const HomeView(),
        binding: HomeBinding(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic),
    GetPage(
        name: _Paths.NEW_PROJECT,
        page: () => NewProjectView(),
        binding: NewProjectBinding(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic),
    GetPage(
        name: _Paths.PICK_DEADLINE,
        page: () => PickDeadlineView(),
        binding: PickDeadlineBinding(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic),
    GetPage(
        name: _Paths.FIRST_TASK,
        page: () => ProjectAvatarView(),
        binding: ProjectAvatarBinding(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic),
    GetPage(
        name: _Paths.ASK_NAME_DART,
        page: () => const AskNameDartView(),
        binding: AskNameDartBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic),
    GetPage(
        name: _Paths.CHOOSE_AVATAR,
        page: () => ChooseAvatarView(),
        binding: ChooseAvatarBinding(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic),
    GetPage(
        name: _Paths.PROJECT_MANAGEMENT,
        page: () => ProjectManagementView(),
        binding: ProjectManagementBinding(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
        name: _Paths.ALL_PROJECTS,
        page: () => const AllProjectsView(),
        binding: AllProjectsBinding(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic),
    GetPage(
        name: _Paths.PROFILE_PAGE,
        page: () => ProfilePageView(),
        binding: ProfilePageBinding(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic),
    GetPage(
        name: _Paths.INCREASE_DEADLINE_PAGE,
        page: () => IncreaseDeadline(),
        transition: Transition.rightToLeft,
        transitionDuration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic),
    GetPage(
      name: _Paths.WELCOME_SCREEN,
      page: () => WelcomeScreenView(),
      binding: WelcomeScreenBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    ),
  ];
}
