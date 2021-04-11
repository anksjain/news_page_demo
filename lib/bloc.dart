import 'dart:async';

import 'package:news_page_demo/DB/DBProvider.dart';
import 'package:news_page_demo/Models/News.dart';
class NewsBloc {
  //constructor
  NewsBloc() {
    getSavedNews();
  }
  final _countryController =StreamController<List<NewsDetail>>.broadcast();
  get countries => _countryController.stream;

  //avoid memoery leak
  dispose() {
    _countryController.close();
  }

  getSavedNews() async {
    _countryController.sink.add(await DBProvider.dbProvider.getAllSavedNews());
  }
}