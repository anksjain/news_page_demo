import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_page_demo/Theme.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            top(context),
            Padding(padding: EdgeInsets.only(top: 30),
            child: Column(
              children: <Widget>[
                ListTile(title: Text("Hi Alex",),),
                themeSwitch(),
              ],
            ),),
          ],
        ),
      ),
    );
  }

  top(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Settings",
            style: TextStyle(
                color: Theme.of(context).textTheme.headline1.color,
                fontSize: 25),
          ),
          Icon(
            Icons.edit,
            color: Theme.of(context).iconTheme.color,
          )
        ],
      ),
    );
  }
  themeSwitch() {
    return Consumer<MyThemeNotifier>(
      builder: (context,notifier,child)=> SwitchListTile(
            title: Text("Dark Mode"),
            onChanged: (val){
              notifier.switchTheme();
            },
        value: notifier.isDark,
          ),
    );
  }
}
