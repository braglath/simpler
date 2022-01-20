import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:simpler/app/routes/app_pages.dart';

class UserDataDetails {
  final _userNameBox = GetStorage();
  final _userAvatarBox = GetStorage();
  final _userLoggedInBox = GetStorage();
  final _userNameKey = 'userName';
  final _userAvatarKey = 'userAvatar';
  final _userLoggedInKey = 'userLoggedIn';

  saveUserName(String userName) {
    _userNameBox.write(_userNameKey, userName);
  }

  saveUserAvatar(String userAvatar) {
    _userAvatarBox.write(_userAvatarKey, userAvatar);
  }

  saveUserLoggedIn(bool userLoggedIn) {
    _userLoggedInBox.write(_userLoggedInKey, userLoggedIn);
  }

  String readUserName() => _userNameBox.read(_userNameKey);
  String readUserAvatar() => _userAvatarBox.read(_userAvatarKey);
  bool readUserLoggedIn() => _userLoggedInBox.read(_userLoggedInKey) ?? false;

  void loginUser(String userName, String userAvatar, bool userLoggedIn) {
    saveUserName(userName);
    saveUserAvatar(userAvatar);
    saveUserLoggedIn(userLoggedIn);
  }

  void deleteUserDetails() {
    _userNameBox.erase();
    _userAvatarBox.erase();
    _userLoggedInBox.erase();
    Get.offAllNamed(Routes.ASK_NAME_DART);
  }
}
