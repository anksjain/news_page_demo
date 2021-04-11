import 'package:flutter/material.dart';
import 'package:infinity_page_view/infinity_page_view.dart';
import 'package:news_page_demo/DB/DBProvider.dart';
import 'package:news_page_demo/Models/News.dart';
import 'package:news_page_demo/Screens/NewsCard.dart';

class NewsList extends StatefulWidget {
  final bool savedNews;
  NewsList({this.savedNews});
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  InfinityPageController _controller;
  List<NewsDetail> displayNewsList;
  NewsDb _newsDb = new NewsDb();
  List<NewsDetail> _allNewsList;
  List<NewsDetail> _savedNewsList;
  bool getData = false;

  getNews() async {
    _allNewsList = _newsDb.getNews();
    _savedNewsList = await DBProvider.dbProvider.getAllSavedNews();
    // print(widget.savedNews);
    // print(_allNewsList[0].title);
    // print(_savedNewsList.length);
    markSaveNews();
    setState(() {
      if (widget.savedNews) {
        if (_savedNewsList.length > 0)
          displayNewsList = _savedNewsList;
        else
          displayNewsList = _allNewsList;
      } else
        displayNewsList = _allNewsList;

      getData = true;
      // print(displayNewsList.length);
    });
  }

  markSaveNews() {
    for (int i = 0; i < _allNewsList.length; i++)
      for (int j = 0; j < _savedNewsList.length; j++)
        if (_allNewsList[i].id == _savedNewsList[j].id) {
          _allNewsList[i].saved = _savedNewsList[j].saved;
          break;
        }
  }

  bool showFilter;
  bool readMode;
  bool type=false;

  @override
  void initState() {
    // TODO: implement initState
    _controller = new InfinityPageController(initialPage: 0);
    showFilter = false;
    readMode = false;
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: !getData
          ? Center(child: CircularProgressIndicator())
          : GestureDetector(
              onTap: () {
                setState(() {
                  print("show filter");
                  showFilter = !showFilter;
                });
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    child: new InfinityPageView(
                      itemCount: displayNewsList.length,
                      scrollDirection: Axis.vertical,
                      controller: _controller,
                      itemBuilder: (BuildContext context, index) => NewsCard(
                        newsDetail: displayNewsList[index],readMode: readMode,
                      ),
                    ),
                  ),
                  showFilter ? showAppBar() : Container(),
                  showFilter ? today(context) : Container(),
                  !showFilter ? Container() : dateText(),
                ],
              ),
            ),
    );
  }
  showlist()
  {
    if(type)
      displayNewsList=_allNewsList;
    else
      displayNewsList=_savedNewsList;
    type=!type;
  }
  showAppBar() {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        title: Text('Hello world'),
        backgroundColor: Theme.of(context).appBarTheme.color,
        actions: <Widget>[
          IconButton(
            icon:
                readMode ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                readMode = !readMode;
              });
            },
          )
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
  }

  today(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: 50,
      left: width / 4,
      right: width / 4,
      child: GestureDetector(
        onTap: ()  {
          setState(() {
            showlist();
          });
        },
            // _selectDate(context),
        child: Container(
          height: height / 10,
          width: width / 4,
          decoration: BoxDecoration(
            // color: Theme.of(context).bottomAppBarColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.blueAccent,
            ),
          ),
          child: Center(
              child: Text("Today",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueAccent,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300))),
        ),
      ),
    );
  }

  dateText() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Date",
              style:
                  TextStyle(color: Theme.of(context).textTheme.headline5.color),
            ),
            Text(
              "Swipe Up/Down for more",
              style:
                  TextStyle(color: Theme.of(context).textTheme.headline5.color),
            )
          ],
        ),
      ),
    );
  }
}
