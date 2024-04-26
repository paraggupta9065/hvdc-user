import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/controllers/address_controller.dart';
import 'package:hvdc_user/controllers/cart_controller.dart';
import 'package:hvdc_user/controllers/order_controller.dart';
import 'package:hvdc_user/controllers/packages_controller.dart';
import 'package:hvdc_user/controllers/patient_controller.dart';
import 'package:hvdc_user/controllers/upload_prescription.dart';
import 'package:hvdc_user/models/banner.dart';
import 'package:hvdc_user/screens/home/homepage.dart';

import '../models/category.dart';
import '../models/pathlogy.dart';
import '../utils/request_handler.dart';
import '../utils/toast.dart';
import 'article_controller.dart';
import 'auth_controller.dart';

class HomepageController extends GetxController {
  AuthController authController = Get.put(AuthController());
  CartController cartController = Get.put(CartController());
  AddressController addressController = Get.put(AddressController());
  PatientController patientController = Get.put(PatientController());
  final ArticleController articleController = Get.put(ArticleController());
  final OrderController orderController = Get.put(OrderController());
  final UploadPrescriptionC uploadPrescription = Get.put(UploadPrescriptionC());
  final PackagesController packagesController = Get.put(PackagesController());

  PageController pageController = PageController();

  RxBool isLoading = RxBool(false);

  Future<void> initHomepage() async {
    getCategories();
    uploadPrescription.getPrescriptions();
    cartController.getCart();
    addressController.getAddressCart();
    patientController.getPatientCart();
    articleController.initArticles();
    orderController.getOrders();
    packagesController.getPackages();
    isLoading.value = true;
    await authController.getProfile();
    await getBanner();
    await getPathologies();
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

  RxBool isLoadingPathlogy = RxBool(false);
  List<Pathlogy> pathologies = [];

  Future getPathologies() async {
    try {
      isLoadingPathlogy.value = true;
      String endpoint = "/pathology?is_offline=true";

      String? token = getToken();

      dynamic response = await ApiHelper.get(
        endpoint,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      List rawPathologies = response['results'];
      pathologies = List<Pathlogy>.generate(rawPathologies.length,
          (index) => Pathlogy.fromJson(rawPathologies[index]));
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString());
      rethrow;
    } finally {
      isLoadingPathlogy.value = false;
    }
  }
}
