import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:hvdc_user/models/user.dart';
import 'package:hvdc_user/utils/request_handler.dart';
import 'package:hvdc_user/utils/routing.dart';
import 'package:hvdc_user/utils/toast.dart';

String? getToken() {
  Box box = Hive.box('user');
  return box.get("token");
}

class AuthController extends GetxController {
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
    "email",
    'https://www.googleapis.com/auth/user.phonenumbers.read'
  ]);
  Box box = Hive.box('user');
  Future login() async {
    try {
      final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();

      final GoogleSignInAuthentication googleAuthentication =
          await googleAccount!.authentication;

      String endpoint = "/user/login/";

      dynamic response = await ApiHelper.post(endpoint, {
        "token": googleAuthentication.accessToken.toString(),
      }, headers: {
        "Content-Type": "application/json"
      });
      box.put("token", response['access_token']);
      box.put("refresh_token", response['refresh_token']);
    } catch (e) {
      print(e);
      kShowSnackbar(title: "Error !", message: e.toString());
    }
  }

  bool isLogin() {
    String? token = box.get("token");
    if (token == null) {
      return false;
    }
    return true;
  }

  RxBool isLoadingProfile = RxBool(false);
  User? user;

  Future getProfile() async {
    try {
      isLoadingProfile.value = true;
      String endpoint = "/user/profile/";

      String? token = getToken();

      dynamic response = await ApiHelper.get(
        endpoint,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      user = User.fromJson(response['results']);
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString());
    } finally {
      isLoadingProfile.value = false;
    }
  }

  logout() {
    box.clear();
    router.go("/sign-up");
  }
}
