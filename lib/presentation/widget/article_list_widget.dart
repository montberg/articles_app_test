import 'package:articles_app/repository/article_repository.dart';
import 'package:articles_app/repository/article_repository_implementation.dart';
import 'package:flutter/material.dart';
import '../../data/model/article.dart';
import '../screen/article_detail_screen.dart';

class ArticlesListWidget extends StatefulWidget {
  const ArticlesListWidget({super.key, List<Article>? data});

  @override
  State<ArticlesListWidget> createState() => _ArticlesListWidgetState();
}

class _ArticlesListWidgetState extends State<ArticlesListWidget> {
  final ArticleRepository repo = ArticleRepositoryImplementation();
  late Future<List<Article>> _articlesFuture;

  @override
  void initState() {
    _articlesFuture = repo.getArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Article>>(
          future: _articlesFuture,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].title),
                        subtitle: Text(snapshot.data![index].description),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArticleDetailScreen(
                                  article: snapshot.data![index]),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
            }
          }),
    );
  }
}
