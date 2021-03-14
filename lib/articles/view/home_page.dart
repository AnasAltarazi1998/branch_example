import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:branch_example/articles/services/article_repo.dart';
import 'package:branch_example/articles/view/about_page.dart';
import 'package:branch_example/articles/models/api_result_model.dart';
import 'package:branch_example/articles/view/articale_details.dart';
import 'package:branch_example/articles/bloc/article_bloc.dart';

class home_page extends StatefulWidget {
  home_page({Key key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  ArticleBloc articleBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: Material(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Cricket"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  articleBloc.add(FetchArticlesEvent());
                },
              ),
              IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  navigateToAoutPage(context);
                },
              )
            ],
          ),
          body: Container(
            child: BlocListener<ArticleBloc, ArticleState>(
              listener: (context, state) {
                if (state is ArticleErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              child: BlocBuilder<ArticleBloc, ArticleState>(
                builder: (context, state) {
                  if (state is ArticleInitialState) {
                    return buildLoading();
                  } else if (state is ArticleLoadingState) {
                    return buildLoading();
                  } else if (state is ArticleLoadedState) {
                    return buildArticleList(state.articles);
                  } else if (state is ArticleErrorState) {
                    return buildErrorUi(state.message + "test");
                  } else {
                    return buildErrorUi("something went wrong");
                  }
                },
              ),
            ),
          ),
        ),
      ),
      create: (context) {
        articleBloc = ArticleBloc(repository: ArticleRepositoryImpl());
        articleBloc.add(FetchArticlesEvent());
        return articleBloc;
      },
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildArticleList(List<Articles> articles) {
    articles.removeAt(2);
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        print('${articles[pos].urlToImage}');
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: ListTile(
              leading: ClipOval(
                child: Hero(
                  tag: articles[pos].urlToImage,
                  child: Image.network(
                    articles[pos].urlToImage,
                    fit: BoxFit.cover,
                    height: 70.0,
                    width: 70.0,
                  ),
                ),
              ),
              title: Text(articles[pos].title),
              subtitle: Text(articles[pos].publishedAt),
            ),
            onTap: () {
              navigateToArticleDetailPage(context, articles[pos]);
            },
          ),
        );
      },
    );
  }

  void navigateToArticleDetailPage(BuildContext context, Articles article) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ArticleDetailPage(
        article: article,
      );
    }));
  }

  void navigateToAoutPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AboutPage();
    }));
  }
}
