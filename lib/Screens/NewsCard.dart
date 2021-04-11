import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_page_demo/DB/DBProvider.dart';
import 'package:news_page_demo/Models/News.dart';

class NewsCard extends StatefulWidget {
  final NewsDetail newsDetail;
  final bool readMode;
  NewsCard({this.newsDetail,this.readMode=false});
  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool readMode;
  @override
  void initState() {
    print(widget.newsDetail.saved);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          newsImage(context),
          newsTextCard(context),
          ],
      );
    // );
  }

  newsImage(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.9,
        child: Image.asset(
          widget.newsDetail.imageUrl,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ));
  }

  newsTextCard(BuildContext context) {
    return Positioned(
        top: MediaQuery.of(context).size.height * 2 / 5,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              (MediaQuery.of(context).size.height * 2 / 5 + 55 + 20),
          decoration: BoxDecoration(
              color: !widget.readMode?Theme.of(context).backgroundColor:Color.fromRGBO(100, 100, 70, 5),
              borderRadius: BorderRadius.only(topRight: Radius.circular(50))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              hashTag(),
              titleToggle(),
              description(),
              // Spacer(),
              // !showFilter ? Container() : dateText(),
            ],
          ),
        ));
  }

  // showAppBar() {
  //   return Positioned(
  //     top: 0.0,
  //     left: 0.0,
  //     right: 0.0,
  //     child: AppBar(
  //       title: Text('Hello world'),
  //       backgroundColor:Theme.of(context).appBarTheme.color,
  //       actions: <Widget>[
  //         IconButton(
  //           icon: readMode?Icon(Icons.visibility):Icon(Icons.visibility_off),
  //           onPressed: (){
  //             setState(() {
  //               readMode=!readMode;
  //             });
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime pickedDate = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2015),
  //       lastDate: DateTime(2050));
  // }

  // today(BuildContext context) {
  //   double width = MediaQuery.of(context).size.width;
  //   double height = MediaQuery.of(context).size.width;
  //   return Positioned(
  //     bottom: 50,
  //     left: width / 4,
  //     right: width / 4,
  //     child: GestureDetector(
  //       onTap: ()=>_selectDate(context),
  //       child: Container(
  //         height: height / 10,
  //         width: width / 4,
  //         decoration: BoxDecoration(
  //           // color: Theme.of(context).bottomAppBarColor,
  //           borderRadius: BorderRadius.circular(15),
  //             border: Border.all(
  //               color: Colors.blueAccent,
  //             ),
  //         ),
  //         child: Center(
  //         child: Text("Today",
  //   style: TextStyle(fontSize: 20,color: Colors.blueAccent,fontStyle: FontStyle.italic,fontWeight: FontWeight.w300))),
  //       ),
  //     ),
  //   );
  // }

  toggle() async {
    if (widget.newsDetail.saved * -1 == 1) {
      widget.newsDetail.saved *= -1;
      await DBProvider.dbProvider.addNews(widget.newsDetail);
    } else {
      widget.newsDetail.saved *= -1;
      await DBProvider.dbProvider.deleteNews(widget.newsDetail.id);
    }
  }

  // dateText() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: <Widget>[
  //         Text(
  //           "Date",
  //           style: TextStyle(color: Theme.of(context).textTheme.headline5.color),
  //         ),
  //         Text(
  //           "Swipe Up/Down for more",
  //           style: TextStyle(color: Theme.of(context).textTheme.headline5.color),
  //         )
  //       ],
  //     ),
  //   );
  // }

  titleToggle() {
    return Padding(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              widget.newsDetail.title ?? "Default",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.headline1.color,
                fontSize: 20,
              ),
            ),
          ),
          Spacer(),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                toggle();
              });
            },
            tooltip: 'Mark It Read',
            backgroundColor:
                widget.newsDetail.saved == 1 ? Colors.green : Theme.of(context).buttonColor,
            child: Icon(Icons.check),
          ),
          SizedBox(
            width: 25,
          )
        ],
      ),
    );
  }

  description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        widget.newsDetail.description ?? "Default",
        style: TextStyle(
          fontWeight: FontWeight.w300,
          color: Theme.of(context).textTheme.bodyText1.color,
          fontSize: 20,
        ),
      ),
    );
  }

  hashTag() {
    return Padding(
      padding: EdgeInsets.only(left: 15,top: 15),
      child: Text(widget.newsDetail.tags,style: TextStyle(color: Colors.indigoAccent),),
    );
  }
}
