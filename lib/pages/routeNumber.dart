import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class RouteNumberPage extends StatefulWidget {
  RouteNumberPage({Key key}) : super(key: key);

  @override
  _RouteNumberPageState createState() => _RouteNumberPageState();
}

class _RouteNumberPageState extends State<RouteNumberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Details"),
        automaticallyImplyLeading: false,
        actions: [],
        //centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: TextField(
                    decoration: InputDecoration(labelText: "Route Number "),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Flexible(
                    child: ElevatedButton(
                        onPressed: () {
                          print("ee");
                        },
                        child: Text("SEE DETAILS")))
              ],
            )
          ],
        ),
      ),
    );
  }
}
