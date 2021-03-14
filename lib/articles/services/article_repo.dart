import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:branch_example/articles/models/api_result_model.dart';
import 'package:branch_example/articles/resources/constant.dart';

abstract class ArticleRepository {
  Future<List<Articles>> getArticles();
}

class ArticleRepositoryImpl implements ArticleRepository {
  @override
  Future<List<Articles>> getArticles() async {
    var response = await http.get(Uri.parse(AppStrings.cricArticleUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Articles> articles = ApiResultModel.fromJson(data).articles;
      print(articles.toString());
      return articles;
    } else {
      throw Exception();
    }
  }
}
