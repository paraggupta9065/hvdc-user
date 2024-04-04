import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hvdc_user/utils/colors.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Articles',
                          style: TextStyle(
                            color: kText,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    FutureBuilder(
                      future: articleController.getPost(id: widget.id),
                      builder:
                          (BuildContext context, AsyncSnapshot<Post> snapshot) {
                        return Text(snapshot.data!.title.toString());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
