import 'package:get/get.dart';
import 'package:wordpress_client/wordpress_client.dart';

import '../utils/toast.dart';
import '../utils/urls.dart';

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
      final request = ListCategoryRequest(
        page: 1,
        perPage: 5,
      );

      WordpressResponse<List<Category>> response =
          await client.categories.list(request);

      categories = response.asSuccess().data;
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

      final request = ListPostRequest(
        page: 1,
        perPage: 10,
        categories: [categories[selectedIndex.value].id],
      );

      WordpressResponse<List<Post>> response = await client.posts.list(request);

      posts = response.asSuccess().data;
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
      final request = ListPostRequest(
        page: 1,
        include: [id],
        perPage: 10,
      );
      WordpressResponse<List<Post>> response = await client.posts.list(request);
      return response.asSuccess().data[0];
    } catch (e) {
      kShowSnackbar(title: "Error !", message: e.toString());
      rethrow;
    }
  }
}
