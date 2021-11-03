import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sudo_task/models/news_model.dart';

class HomeApiProvider {
  Future<NewsModel> fetchNewsApi(String? params, String? source) async {
    Response<Map<String, dynamic>> response;
    final Dio dio = Dio();
    // dio.options.headers['X-Requested-With'] = 'XMLHttpRequest';
    String? baseUrl = '';
    switch (source) {
      /*news_model*/
      case 'SEARCH':
        baseUrl =
            'https://newsapi.org/v2/everything?q=$params&from=2021-11-03&sortBy=popularity&apiKey=0b74fdf4ccdd43168a0a59e909c67f93';
        break;
      /*news_model*/
      case 'COUNTRY':
        baseUrl =
            'https://newsapi.org/v2/top-headlines?country=$params&apiKey=0b74fdf4ccdd43168a0a59e909c67f93';
        break;

      case 'CATEGORY':
        baseUrl =
            'https://newsapi.org/v2/top-headlines/sources?category=$params&apiKey=0b74fdf4ccdd43168a0a59e909c67f93';
        break;

      case 'LANGUAGE':
        baseUrl =
            'https://newsapi.org/v2/top-headlines?language=$params&apiKey=0b74fdf4ccdd43168a0a59e909c67f93';
        break;
    }
    try {
      response = await dio.get<Map<String, dynamic>>(baseUrl);
      print('Response-->$response');
      final Map<String, dynamic> map =
          Map<String, dynamic>.from(response.data!);
      return NewsModel.fromJson(map);
    } catch (error, stacktrace) {
      print('ERROR-->$error');
      return NewsModel.withError('$error');
    }
  }
}
