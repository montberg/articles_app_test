import 'package:articles_app/presentation/screen/registration_screen.dart';
import 'package:articles_app/repository/article_repository.dart';
import 'package:articles_app/repository/article_repository_implementation.dart';
import 'package:articles_app/repository/user_repository.dart';
import 'package:flutter/material.dart';
import '../../data/model/article.dart';
import '../../repository/user_repository_implementation.dart';
import '../widget/article_list_widget copy.dart';

class ArticlesListScreen extends StatefulWidget {
  const ArticlesListScreen({super.key});

  @override
  State<ArticlesListScreen> createState() => _ArticlesListScreenState();
}

class _ArticlesListScreenState extends State<ArticlesListScreen> {
  final ArticleRepository repo = ArticleRepositoryImplementation();
  late Future<List<Article>> _articlesFuture;
  @override
  void initState() {
    _articlesFuture = repo.getArticles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserRepository repo = UserRepositoryImplementation();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              await repo.logout();
              Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(pageBuilder: (BuildContext context,
                      Animation animation, Animation secondaryAnimation) {
                    return RegistrationScreen();
                  }, transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return new SlideTransition(
                      position: new Tween<Offset>(
                        begin: const Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  }),
                  (Route route) => false);
            },
            icon: Icon(Icons.logout),
          )
        ],
        title: const Text('Список статей'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
            key: UniqueKey(),
            future: _articlesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth >= 600) {
                        return Center(
                            child: SizedBox(
                                width: 600,
                                child:
                                    ArticlesListWidget1(data: snapshot.data!)));
                      }
                      return ArticlesListWidget1(data: snapshot.data!);
                    },
                  );
                }
              }
              return Center(child: const CircularProgressIndicator());
            }),
      ),
    );
  }
}
