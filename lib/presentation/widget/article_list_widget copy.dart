import 'package:flutter/material.dart';
import '../../data/model/article.dart';
import '../screen/article_detail_screen.dart';

class ArticlesListWidget1 extends StatelessWidget {
  final List<Article> data;
  const ArticlesListWidget1({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(data[index].title),
            subtitle: Text(data[index].description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ArticleDetailScreen(article: data[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
