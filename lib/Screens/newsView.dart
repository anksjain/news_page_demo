import 'package:flutter/material.dart';
import 'package:news_page_demo/Screens/NewsList.dart';
import 'package:news_page_demo/Screens/OfflineSave.dart';
import 'package:news_page_demo/Screens/profile.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int _currentTab;
  @override
  void initState() {
    _currentTab = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _bottomNavBarItem = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.list), title: Text("List")),
      BottomNavigationBarItem(icon: Icon(Icons.bookmark), title: Text("Saved")),
      BottomNavigationBarItem(
          icon: Icon(Icons.person_pin), title: Text("Profile")),
    ];
    final _tabPages = <Widget>[
      NewsList(savedNews: false),
      OfflineSaved(),
      Profile()
    ];
    assert(_tabPages.length == _bottomNavBarItem.length);
    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 55,
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
            showUnselectedLabels: false,
            selectedItemColor: Colors.blueAccent,
            items: _bottomNavBarItem,
            currentIndex: _currentTab,
            onTap: (index) {
              setState(() {
                _currentTab = index;
              });
            },
          ),
        ),
        body: _tabPages[_currentTab]);
  }
}
