import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/utils/appBar.dart';
import 'package:hvdc_user/utils/colors.dart';
import 'package:hvdc_user/utils/loading.dart';
import 'package:hvdc_user/utils/responsive.dart';
import 'package:hvdc_user/utils/style.dart';
import 'package:wordpress_client/wordpress_client.dart';

import '../controllers/article_controller.dart';

class Article extends StatefulWidget {
  const Article({super.key, required this.id});
  final int id;

  @override
  State<Article> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Article> {
  final ArticleController articleController = Get.put(ArticleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar("Articles"),
      body: SafeArea(
        child: FutureBuilder(
          future: articleController.getPost(id: widget.id),
          builder: (BuildContext context, AsyncSnapshot<Post> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: KLoading());
            }

            Post post = snapshot.data!;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  children: [
                    Text(
                      post.title?.parsedText ?? "",
                      style: kTextStyle.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                    Image.network(
                      post.featuredImageUrl ?? "",
                      width: kWidth(100),
                      fit: BoxFit.cover,
                    ),
                    Text(
                      (post.content?.parsedText ?? "")
                          .replaceAll('\n\n', '\n')
                          .toString(),
                      style: kTextStyle,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
