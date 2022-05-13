import 'package:ecom/utils/Constants.dart';
import 'package:flutter/material.dart';

ThemeData dark(BuildContext context) {
  return ThemeData.dark().copyWith(
    hintColor: Color.fromARGB(192, 228, 226, 226),
    scaffoldBackgroundColor: Constants.darkprimary,
    bottomAppBarColor: Constants.darkappBarColor,
    iconTheme: const IconThemeData(
      color: Constants.darkIcons,
    ),
    backgroundColor: Constants.darkprimary,
    appBarTheme: const AppBarTheme(
      color: Constants.darkappBarColor,
      titleTextStyle: TextStyle(
          color: Constants.appBarTitle,
          fontSize: 23,
          fontWeight: FontWeight.w600),
    ),
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Constants.darktext,
        ),
    colorScheme: ThemeData().colorScheme.copyWith(primary: Constants.darkIcons),
  );
}

ThemeData light(BuildContext context) {
  return ThemeData.dark().copyWith(
    hintColor: Color.fromARGB(225, 90, 90, 90),
    scaffoldBackgroundColor: Color.fromARGB(255, 250, 250, 250),
    primaryColorLight: Constants.lightIcons,
    cardColor: Constants.lightIcons,
    primaryColor: Constants.lightIcons,
    bottomAppBarColor: Constants.appBarColor,
    iconTheme: const IconThemeData(
      color: Constants.lightIcons,
    ),
    backgroundColor: Constants.lightprimary,
    appBarTheme: const AppBarTheme(
      foregroundColor: Constants.lightIcons,
      color: Constants.appBarColor,
      titleTextStyle: TextStyle(
          color: Constants.appBarTitle,
          fontSize: 20,
          fontWeight: FontWeight.w500),
    ),
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Constants.lighttext,
        ),
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: Constants.lightIcons,
        ),
  );
}
