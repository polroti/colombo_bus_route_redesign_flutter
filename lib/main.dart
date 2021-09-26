import 'package:colombo_bus_route_redesign_flutter/pages/currentPlaceToDestination.dart';
import 'package:colombo_bus_route_redesign_flutter/pages/startToDestination.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigationContainer(title: 'Flutter Demo Home Page'),
    );
  }
}

class BottomNavigationContainer extends StatefulWidget {
  BottomNavigationContainer({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _BottomNavigationContainerState createState() =>
      _BottomNavigationContainerState();
}

class _BottomNavigationContainerState extends State<BottomNavigationContainer> {
  int currentTabIndex = 0;
  List<Widget> tabs = [
    StartToDestinationPage(),
    CurrentPlaceToDestination(),
    StartToDestinationPage(),
    StartToDestinationPage()
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
              icon: Icon(Icons.directions_outlined), title: Text("Find")),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_outlined), title: Text("From Here")),
          BottomNavigationBarItem(
              icon: Icon(Icons.looks_one_outlined), title: Text("Route")),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_bus_outlined),
              title: Text("Buses Here"))
        ],
      ),
    );
  }
}
