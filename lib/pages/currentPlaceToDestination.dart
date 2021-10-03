import 'package:colombo_bus_route_redesign_flutter/data/destinations.dart';
import 'package:colombo_bus_route_redesign_flutter/pages/routeDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:search_choices/search_choices.dart';
//import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentPlaceToDestination extends StatefulWidget {
  CurrentPlaceToDestination({Key key}) : super(key: key);

  @override
  _CurrentPlaceToDestinationState createState() =>
      _CurrentPlaceToDestinationState();
}

class _CurrentPlaceToDestinationState extends State<CurrentPlaceToDestination> {
  String start;
  String end;
  String selectedEnd = "End";
  bool locationPermissionStatus = false;
  final List<DropdownMenuItem> items = [];
  List searchResults = [];
  TextEditingController startEditingController;
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
  bool locationPermission = false;

  List data;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('lib/data/routeDetails.json');
    setState(() => data = json.decode(jsonText));
    return 'success';
  }

  callLoadJson() {
    this.loadJsonData();
  }

  getLocationPermissonFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('location');
  }

  callgetLocationPermissonFromSharedPref() {
    getLocationPermissonFromSharedPref();
  }

  @override
  void initState() {
    super.initState();
    this.callLoadJson();
    this.startEditingController = new TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showDialog<String>(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
          title: new Text("Location"),
          content: new Text("Allow this app to access location?"),
          actions: <Widget>[
            FlatButton(
              textColor: Color(0xFF6200EE),
              onPressed: () {
                setState(() {
                  this.locationPermissionStatus = false;
                });
                print(locationPermissionStatus.toString());
                Navigator.pop(context);
              },
              child: Text('DENY'),
            ),
            FlatButton(
              textColor: Color(0xFF6200EE),
              onPressed: () {
                setState(() {
                  this.start = "Wellawatte";
                  this.startEditingController.text =
                      "Fetching your location....";
                  this.locationPermissionStatus = true;
                });
                Navigator.pop(context);

                Future.delayed(const Duration(milliseconds: 2500), () {
                  setState(() {
                    this.startEditingController.text = start.toString();
                  });
                });
              },
              child: Text('ALLOW'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Route Details"),
        ),
        body: Column(
          children: [
            Visibility(
              visible: locationPermissionStatus,
              maintainState: true,
              child: Column(
                children: <Widget>[
                  TextField(
                    enabled: false,
                    controller: startEditingController,
                  ),
                  Divider(),
                  SizedBox(
                    height: 30,
                  ),
                  SearchChoices.single(
                      isExpanded: true,
                      items: destinations.map((e) {
                        return (DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ));
                      }).toList(),
                      hint: "End Stop",
                      value:
                          this.end == "" || this.end == null ? "End" : this.end,
                      searchHint: "End",
                      onChanged: (value) {
                        setState(() {
                          this.end = value.toString();
                        });
                      }),
                  ElevatedButton.icon(
                      onPressed: this.start == null && this.end == null
                          ? null
                          : () {
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
                      icon: Icon(Icons.search),
                      label: Text("FIND BUS ROUTES")),
                  Visibility(
                      visible: this.searchResults.length > 0,
                      child: Container(
                        child: Column(
                          children: listOfResults(),
                        ),
                      ))
                ],
              ),
            ),
            Visibility(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text("Please allow location permission")
                    ],
                  ),
                ),
                visible: !locationPermissionStatus)
          ],
        )

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
          trailing: ElevatedButton.icon(
            icon: Icon(Icons.info),
            label: Text("DETAILS"),
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
