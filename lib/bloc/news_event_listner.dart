import 'package:flutter/material.dart';

class NewsEventListner extends ChangeNotifier {
  String? Search = 'Apple';

  CheckSearchState(String? value) {
    Search = value;
    notifyListeners();
  }
}
