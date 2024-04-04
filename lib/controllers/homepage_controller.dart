import 'package:get/get.dart';
import 'package:hvdc_user/models/banner.dart';
import 'package:hvdc_user/screens/home/homepage.dart';

import '../models/category.dart';
import '../utils/request_handler.dart';
import '../utils/toast.dart';
import 'auth_controller.dart';

class HomepageController extends GetxController {
  AuthController authController = Get.put(AuthController());

  RxBool isLoading = RxBool(false);

  Future<void> initHomepage() async {
    getCategories();
    isLoading.value = true;
    await authController.getProfile();
    await getBanner();
    isLoading.value = false;
  }

  RxBool isLoadingBanner = RxBool(false);
  List<BannerModel> banners = [];

  Future getBanner() async {
    try {
      isLoadingBanner.value = true;
      String endpoint = "/banners/";

      String? token = getToken();

      dynamic response = await ApiHelper.get(
        endpoint,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      List rawBanners = response['results'];
      banners = List<BannerModel>.generate(rawBanners.length,
          (index) => BannerModel.fromJson(rawBanners[index]));
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString());
    } finally {
      isLoadingBanner.value = false;
    }
  }

  List<Category> categories = [];
  RxBool isLoadingCategories = RxBool(false);

  Future getCategories() async {
    try {
      isLoadingCategories.value = true;
      String endpoint = "/categories/";

      String? token = getToken();

      dynamic response = await ApiHelper.get(
        endpoint,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      List rawCategories = response['results'];
      categories = List<Category>.generate(rawCategories.length,
          (index) => Category.fromJson(rawCategories[index]));
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString());
    } finally {
      isLoadingCategories.value = false;
    }
  }
}
