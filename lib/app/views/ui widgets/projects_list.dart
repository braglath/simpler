import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simpler/app/views/custom%20widgets/project_card.dart';
import 'package:simpler/app/views/custom%20widgets/separator.dart';

class RecentProjects extends StatelessWidget {
  final int itemCount;
  final RxList<dynamic> project;
  const RecentProjects(
      {Key? key, required this.itemCount, required this.project})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // print('project index - $index');
          final projectList = project[index];
          return ProjectCard(
            project: projectList,
            index: index,
          );
        },
        separatorBuilder: (context, index) {
          return const Separator();
        },
        itemCount: itemCount);
  }
}
