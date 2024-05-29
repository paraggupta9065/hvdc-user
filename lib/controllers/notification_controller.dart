import 'package:get/get.dart';

class NotificationController extends GetxController {
  // Future getBanner() async {
  //   try {
  //     isLoadingBanner.value = true;
  //     String endpoint = "/banners/";

  //     String? token = getToken();

  //     dynamic response = await ApiHelper.get(
  //       endpoint,
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //     );
  //     List rawBanners = response['results'];
  //     banners = List<BannerModel>.generate(rawBanners.length,
  //         (index) => BannerModel.fromJson(rawBanners[index]));
  //   } catch (e) {
  //     kShowSnackbar(title: "Error !", message: e.toString());
  //   } finally {
  //     isLoadingBanner.value = false;
  //   }
  // }
}
