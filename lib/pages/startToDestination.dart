import 'dart:convert';

import 'package:colombo_bus_route_redesign_flutter/data/destinations.dart';
import 'package:colombo_bus_route_redesign_flutter/pages/routeDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class StartToDestinationPage extends StatefulWidget {
  StartToDestinationPage({Key key}) : super(key: key);

  @override
  _StartToDestinationPageState createState() => _StartToDestinationPageState();
}

class _StartToDestinationPageState extends State<StartToDestinationPage> {
  int _counter = 0;
  String start;
  String end;
  final List<DropdownMenuItem> items = [];
  final destinations = [
    "Athurugiriya",
    "Bambalapitiya",
    "Battaramulla",
    "Batuwatta",
    "Bloemendhal",
    "Boralesgamuwa",
    "Borella",
    "Cinnamon Gardens",
    "Dalugama",
    "Dehiwala",
    "Dematagoda",
    "Fort",
    "Grandpass",
    "Havelock Town",
    "Hokandara",
    "Hulftsdorp",
    "Ja Ela",
    "Kadawatha",
    "Kaduwela",
    "Kahathuduwa",
    "Kalubowila",
    "Kandana",
    "Kiribathgoda",
    "Kirulapana",
    "Kohuwala",
    "Kollupitiya",
    "Kolonnawa",
    "Koswatte",
    "Kotahena",
    "Kotikawatta",
    "Kottawa",
    "Madampitiya",
    "Maha Nuge Gardens",
    "Maharagama",
    "Malabe",
    "Maligawatta",
    "Maradana",
    "Mattakkuliya",
    "Modara",
    "Moratuwa",
    "Mount Lavinia",
    "Narahenpita",
    "Nawala",
    "Nugegoda",
    "Wellawatte"
  ];
  List searchResults = [];
  List data;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('lib/data/routeDetails.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }

  callLoadJson() {
    this.loadJsonData();
  }

  @override
  void initState() {
    super.initState();
    this.callLoadJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Bus Route"),
      ),
      body: Column(
//        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          SearchableDropdown.single(
              isExpanded: true,
              items: destinations.map((e) {
                return (DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ));
              }).toList(),
              hint: "Start",
              searchHint: "Start",
              onChanged: (value) {
                setState(() {
                  this.start = value.toString();
                });
              }),
          SearchableDropdown.single(
              isExpanded: true,
              items: destinations.map((e) {
                return (DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ));
              }).toList(),
              hint: "End",
              searchHint: "End",
              onChanged: (value) {
                setState(() {
                  this.end = value.toString();
                });
              }),
          ElevatedButton.icon(
              onPressed: () {
                data.forEach((element) {
                  print(start);
                  print(end);

                  if (element['places'].contains(this.start) &&
                      element['places'].contains(this.end)) {
                    setState(() {
                      this.searchResults.add(element);
                    });
                  }
                });
                print(this.searchResults.length.toString());
              },
              icon: Icon(Icons.search_outlined),
              label: Text("FIND BUS ROUTES")),
          SizedBox(
            height: 15,
          ),
          Divider(),
          Visibility(
              visible: this.searchResults.length > 0,
              child: Container(
                child: Column(
                  children: listOfResults(),
                ),
              )),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<Widget> listOfResults() {
    List<Widget> widgetList = [];

    if (this.searchResults.length > 0) {
      this.searchResults.forEach((element) {
        print(element['routeNumber']);
        widgetList.add(ListTile(
          title: Text(element['routeNumber']),
          subtitle: Text(element['routeName']),
          trailing: TextButton(
            child: Text("DETAILS"),
            onPressed: () {
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TabBarDemo(
                            routeNumber: element['routeNumber'],
                          )),
                );
              }
            },
          ),
        ));
      });
    } else {
      widgetList.add(Text("Sorry machan mokuth na"));
    }

    return widgetList.toList();
  }
}
