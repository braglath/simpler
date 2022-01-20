import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:simpler/app/data/resources/colour_resources.dart';
import 'package:simpler/app/views/custom%20widgets/back_appbar.dart';
import '../controllers/project_management_controller.dart';

class ProjectManagementView extends GetView<ProjectManagementController> {
  ProjectManagementView({Key? key}) : super(key: key);

  final projectTitle = Get.arguments;
  String get title => projectTitle['title'];
  String get asset => projectTitle['asset'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BackAppBar(title: title, actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child:
                Image.asset(asset, fit: BoxFit.contain, height: 30, width: 30),
          )
        ]),
        body: _mainBody(context));
  }

  Widget _mainBody(BuildContext context) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 25),
            Center(
              child: Container(
                height: 500,
                width: MediaQuery.of(context).size.width - 50,
                color: Colors.amber,
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: Colors.red,
                      child: Row(
                        children: [
                          const SizedBox(width: 15),
                          Text(
                            'To do',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 5),
                          CircleAvatar(
                            radius: 10.0,
                            backgroundColor: ColorRes.pureWhite,
                            child: Center(
                                child: Text(
                              '5',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ColorRes.textColor),
                            )),
                          ),
                          const Spacer(),
                          const FaIcon(FontAwesomeIcons.plus),
                          const SizedBox(width: 15),
                          const FaIcon(FontAwesomeIcons.ellipsisH),
                          const SizedBox(width: 15),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
