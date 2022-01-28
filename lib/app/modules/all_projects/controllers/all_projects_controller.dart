import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import 'package:simpler/app/data/database/project_database.dart';
import 'package:simpler/app/data/user_data/user_data.dart';

class AllProjectsController extends GetxController
    with SingleGetTickerProviderMixin {
  final date = ''.obs;
  int timing = 0;
  late Timer _timer;
  var allProjectsList = [].obs;
  final ScrollController allProjectScrollController = ScrollController();
  final scrollToBottom = true.obs;
  final showRefreshIndicator = false.obs;
  final choiceChipValue = 0.obs;
  bool showPicker = false;
  late AnimationController animationController;
  @override
  void onInit() {
    super.onInit();
    currentDate();
    getAllProjectsList();
    animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        animationBehavior: AnimationBehavior.preserve);
    allProjectScrollController.addListener(() {
      final scrollListener = allProjectScrollController.position.pixels > 200;
      if (scrollListener) {
        scrollToBottom.value = false;
      } else {
        scrollToBottom.value = true;
      }
    });
    _timer = Timer.periodic(const Duration(seconds: 8), (Timer t) {
      timing = timing + 1;
      changeDateName();
      // print(timing);
      // print(date.value);
    });
  }

  void scrollToBottomOnTap() {
    allProjectScrollController.animateTo(
        allProjectScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn);
  }

  void scrollToTopOnTap() {
    allProjectScrollController.animateTo(
        allProjectScrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn);
  }

  void scroll() {
    if (scrollToBottom.isTrue) {
      scrollToBottomOnTap();
    } else {
      scrollToTopOnTap();
    }
  }

  void changeDateName() {
    if (timing.isEven && UserDataDetails().readUserName().isNotEmpty) {
      date.value = UserDataDetails().readUserName();
    } else {
      currentDate();
    }
  }

  Future getAllProjectsList() async {
    final allProjects = await ProjectDatabase.instance.fetchAllProjects();
    allProjectsList.value = allProjects;
  }

  Future getCompletedProjectsList() async {
    final allProjects = await ProjectDatabase.instance.readCompletedProjects();
    allProjectsList.value = allProjects;
  }

  Future getPendingProjectsList() async {
    final allProjects = await ProjectDatabase.instance.readPendingProjects();
    allProjectsList.value = allProjects;
  }

  void currentDate() {
    List months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];

    var now = DateTime.now();
    var currentMon = now.month;
    date.value = '${months[currentMon - 1]} ${now.day}, ${now.year}';
    // print(months[currentMon - 1]);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    animationController.dispose();
  }
}
