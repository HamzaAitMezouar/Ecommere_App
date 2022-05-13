import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecom/pages/Settings.dart';
import 'package:ecom/pages/home_body.dart';
import 'package:ecom/utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Authpage.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int indexs = 0;
  List<Widget> screens = [homebody(), Settings()];
  final icons = <Widget>[const Icon(Icons.home), const Icon(Icons.settings)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // BOTTOM NAv BAR---------------------
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).bottomAppBarColor,
        buttonBackgroundColor: Constants.appBarTitle,
        height: 50,
        index: indexs,
        items: icons,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        onTap: (index) {
          print(indexs);

          setState(() {
            indexs = index;
          });
        },
      ),
      //--------------APPBAR

      //Body
      body: screens[indexs],
    );
  }
}
