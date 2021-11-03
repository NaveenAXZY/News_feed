import 'package:sudo_task/models/news_model.dart';

import 'api_provider_home.dart';

class Repository {
  final HomeApiProvider homeApiProvider = HomeApiProvider();

  Future<NewsModel> fetchNewsApiModel(String? value, String? source) =>
      homeApiProvider.fetchNewsApi(value, source);
}
