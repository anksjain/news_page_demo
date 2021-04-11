import 'package:flutter/material.dart';
import 'package:news_page_demo/Screens/NewsList.dart';
class OfflineSaved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewsList(savedNews: true,);
  }
}
