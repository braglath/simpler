import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simpler/app/data/resources/usable_strings.dart';
import 'package:simpler/app/data/theme/theme_data.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: MainPageStrings.title,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemesData.themeData,
      ),
    ),
  );
}
