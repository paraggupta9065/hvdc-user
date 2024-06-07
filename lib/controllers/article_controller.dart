import 'dart:convert';

import 'package:get/get.dart';
import 'package:wordpress_client/wordpress_client.dart';

import '../models/test.dart';
import '../utils/request_handler.dart';
import '../utils/toast.dart';
import '../utils/urls.dart';
import 'auth_controller.dart';
import 'package:http/http.dart' as http;

class ArticleController extends GetxController {
  final client = WordpressClient.initialize(baseUrl: wordpressUrl);

  RxBool isLoading = RxBool(false);

  RxInt selectedIndex = RxInt(0);

  initArticles() async {
    isLoading.value = true;
    await getCategories();
    await getPosts();
    isLoading.value = false;
  }

  List<Category> categories = [];

  Future<void> getCategories() async {
    try {
      String endpoint = "/categories?per_page=5&page=1";

      http.Response response =
          await http.get(Uri.parse('$wordpressUrl$endpoint'));

      dynamic data = jsonDecode(response.body);
      categories =
          List.generate(data.length, (index) => Category.fromJson(data[index]));
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString());
      rethrow;
    }
  }

  List<Post> posts = [];
  List<Post> trandingPosts = [];

  Future<void> getPosts() async {
    try {
      isLoading.value = true;

      String endpoint = "/posts?per_page=5&page=1";

      http.Response response =
          await http.get(Uri.parse('$wordpressUrl$endpoint'));

      dynamic data = jsonDecode(response.body);
      posts = List.generate(data.length, (index) => Post.fromJson(data[index]));
      trandingPosts = posts;
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString());
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Post> getPost({required int id}) async {
    try {
      isLoading.value = true;

      String endpoint = "/posts?per_page=5&page=1&include=$id";

      http.Response response =
          await http.get(Uri.parse('$wordpressUrl$endpoint'));

      dynamic data = jsonDecode(response.body);
      posts = List.generate(data.length, (index) => Post.fromJson(data[index]));

      return posts[0];
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString());
      rethrow;
    }
  }

  List<Test> recommendationSearch = [];
  RxBool isLoadingRecommendation = RxBool(false);
  Future getTestsRecommendation({required String key}) async {
    try {
      isLoadingRecommendation.value = true;
      String endpoint = "/pathology_test/?key=$key";

      String? token = getToken();

      dynamic response = await ApiHelper.get(
        endpoint,
        headers: {
          "Content-Type": "application/json",
        },
      );
      List rawTests = response['results'];
      recommendationSearch = [];
      recommendationSearch = List<Test>.generate(
          rawTests.length, (index) => Test.fromJson(rawTests[index]));
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString());
    } finally {
      isLoadingRecommendation.value = false;
    }
  }
}
