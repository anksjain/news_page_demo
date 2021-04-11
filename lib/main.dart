import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_page_demo/Screens/newsView.dart';
import 'package:news_page_demo/Theme.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      builder: (_)=>MyThemeNotifier(),
      child: Consumer<MyThemeNotifier>(
        builder: (context,MyThemeNotifier notifier,child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News App Demo',
            theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.white,
                backgroundColor: Colors.white,
                buttonColor: Colors.black54,
                // scaffoldBackgroundColor: Colors.black,
              /* light theme settings */
            ),
            darkTheme: ThemeData(
                brightness: Brightness.dark,
                buttonColor: Colors.white,
              /* dark theme settings */
            ),
            themeMode:notifier.isDark?ThemeMode.dark:ThemeMode.light,
            home: NewsView(),
          );
        }
      ),
    );
  }
}