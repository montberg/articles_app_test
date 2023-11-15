import 'package:flutter/material.dart';
import '../../data/model/article.dart';

class ArticleDetailScreen extends StatelessWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    var _width = double.infinity;
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if(constraints.maxWidth>=600){
            _width = 600;
          }
          else _width = double.infinity;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: _width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        article.title,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        article.content,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Дата публикации: ${article.date}',
                        style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
