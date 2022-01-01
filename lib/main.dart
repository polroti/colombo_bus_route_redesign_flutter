import 'package:colombo_bus_route_redesign_flutter/pages/busesInCurrentPlace.dart';
import 'package:colombo_bus_route_redesign_flutter/pages/currentPlaceToDestination.dart';
import 'package:colombo_bus_route_redesign_flutter/pages/routeNumber.dart';
import 'package:colombo_bus_route_redesign_flutter/pages/startToDestination.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ColomboBusRouteApp());
}

class ColomboBusRouteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.lightBlue.shade900,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: Colors.lightBlue.shade900,
              selectedIconTheme:
                  IconThemeData(color: Colors.lightBlue.shade900)),
          iconTheme: IconThemeData(color: Colors.lightBlue.shade900),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: 'Ubuntu'),
              color: Colors.lightBlue.shade900)),
      home: BottomNavigationContainer(),
    );
  }
}

class BottomNavigationContainer extends StatefulWidget {
  BottomNavigationContainer({Key key}) : super(key: key);

  @override
  _BottomNavigationContainerState createState() =>
      _BottomNavigationContainerState();
}

class _BottomNavigationContainerState extends State<BottomNavigationContainer> {
  int currentTabIndex = 0;
  List<Widget> tabs = [
    StartToDestinationPage(),
    CurrentPlaceToDestination(),
    RouteNumberPage(),
    BusesInCurrentPlace()
  ];
  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  //build bottom navigation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        iconSize: 24,
        onTap: onTapped,
        currentIndex: currentTabIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_outlined), label: "Find"),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), label: "From Here"),
          BottomNavigationBarItem(
              icon: Icon(Icons.looks_one_outlined), label: "Route"),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_bus_outlined), label: "Buses Here")
        ],
      ),
    );
  }
}
