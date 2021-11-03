import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sudo_task/models/news_model.dart';

class HomeApiProvider {
  Future<NewsModel> fetchNewsApi(String? params, String? source) async {
    print('%%%%%%%%%%%');
    Response<Map<String, dynamic>> response;
    final Dio dio = Dio();
    // dio.options.headers['X-Requested-With'] = 'XMLHttpRequest';
    String? baseUrl = '';
    switch (source) {
      case 'SEARCH':
        baseUrl =
            'https://newsapi.org/v2/everything?q=$params&from=2021-11-03&sortBy=popularity&apiKey=0b74fdf4ccdd43168a0a59e909c67f93';
        break;

      case 'COUNTRY':
        baseUrl =
            'https://newsapi.org/v2/top-headlines?country=$params&apiKey=0b74fdf4ccdd43168a0a59e909c67f93';
        break;

      case 'LANGUAGE':
        baseUrl =
            'https://newsapi.org/v2/top-headlines?language=$params&apiKey=0b74fdf4ccdd43168a0a59e909c67f93';
        break;
    }
    try {
      response = await dio.get<Map<String, dynamic>>(baseUrl);

      if (response.data!['articles'].isEmpty) {
        return NewsModel.withError('No Data Found!');
      } else {
        final Map<String, dynamic> map =
            Map<String, dynamic>.from(response.data!);
        return NewsModel.fromJson(map);
      }
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.other) {
        print('EEEEEEEEE1111');
        return NewsModel.withError('No Internet connection is available');
      } else if (ex.type == DioErrorType.response) {
        print('EEEEEEEEE2222');
        return NewsModel.withError(
            'Required parameters are missing. Please set any of the following parameters and try again: sources, q, language, country, category.');
      }
      return NewsModel.withError('$ex');
    } catch (error, stacktrace) {
      print('ERROR-->$error');
      return NewsModel.withError('$error');
    }
  }
}
