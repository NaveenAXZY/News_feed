import 'dart:async';
import 'package:dio/dio.dart';
import 'package:sudo_task/config/appconfig.dart';
import 'package:sudo_task/models/news_model.dart';

class HomeApiProvider {
  Future<NewsModel> fetchNewsApi(String? params, String? source) async {
    Response<Map<String, dynamic>> response;
    final Dio dio = Dio(); // dio.options.headers['X-Requested-With'] = 'XMLHttpRequest';
    String? baseUrl = '';
    switch (source) {
      case 'SEARCH':
        baseUrl =
            'https://newsapi.org/v2/everything?q=$params&from=2021-11-03&sortBy=popularity&apiKey=${AppConfig.API_KEY}';
        break;

      case 'COUNTRY':
        baseUrl =
            'https://newsapi.org/v2/top-headlines?country=$params&apiKey=${AppConfig.API_KEY}';
        break;

      case 'LANGUAGE':
        baseUrl =
            'https://newsapi.org/v2/top-headlines?language=$params&apiKey=${AppConfig.API_KEY}';
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
        return NewsModel.withError('No Internet connection is available!!');
      } else if (ex.type == DioErrorType.response) {
        return NewsModel.withError(
            'Internal server error or Too many request!!');
      }
      return NewsModel.withError('$ex');
    } catch (error, stacktrace) {
      return NewsModel.withError('$error');
    }
  }
}
