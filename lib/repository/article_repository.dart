import '../data/model/article.dart';

abstract class ArticleRepository{
  Future<List<Article>> getArticles();
}