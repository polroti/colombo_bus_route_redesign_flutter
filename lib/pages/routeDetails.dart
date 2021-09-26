import 'package:flutter/material.dart';

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({Key key, this.routeNumber}) : super(key: key);

  final String routeNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: "ROUTE",
                  ),
                  Tab(
                    text: "MAP",
                  )
                ],
              ),
              title: Text('Route Details - ' + this.routeNumber)),
          body: const TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),
    );
  }
}
