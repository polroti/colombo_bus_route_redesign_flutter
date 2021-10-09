import 'dart:convert';

import 'package:colombo_bus_route_redesign_flutter/data/destinations.dart';
import 'package:search_choices/search_choices.dart';

import 'package:colombo_bus_route_redesign_flutter/pages/routeDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class StartToDestinationPage extends StatefulWidget {
  StartToDestinationPage({Key key}) : super(key: key);

  @override
  _StartToDestinationPageState createState() => _StartToDestinationPageState();
}

class _StartToDestinationPageState extends State<StartToDestinationPage> {
  String start;
  String end;
  final List<DropdownMenuItem> items = [];
  List searchResults = [];
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

  Widget startInput() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.grey, width: 1.0)),
      margin: EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            SearchChoices.single(
                searchInputDecoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: Colors.blueAccent))),
                isExpanded: true,
                value: this.start == "" || this.start == null
                    ? "Start"
                    : this.start,
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
                })
          ],
        ),
      ),
    );
  }

  Widget endInput() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.grey, width: 1.0)),
      margin: EdgeInsets.all(5.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            SearchChoices.single(
                isExpanded: true,
                items: destinations.map((e) {
                  return (DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ));
                }).toList(),
                hint: "End",
                value: this.end == "" || this.end == null ? "End" : this.end,
                searchHint: "End",
                onChanged: (value) {
                  setState(() {
                    this.end = value.toString();
                  });
                })
          ],
        ),
      ),
    );
  }

  Widget searchButton() {
    return ElevatedButton.icon(
        onPressed: this.start == null && this.end == null
            ? null
            : () {
                if (!(this.searchResults.length > 1)) {
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
                }
                print(this.searchResults.length.toString());
              },
        icon: Icon(Icons.search_outlined),
        label: Text("FIND BUS ROUTES"));
  }

  Widget resultList() {
    return Visibility(
        visible: this.searchResults.length > 0,
        child: Flexible(
          child: ListView(children: listOfResults()

              // [Column(
              //   children: listOfResults(),
              // )],
              ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Bus Route"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          startInput(),
          endInput(),
          SizedBox(
            height: 15,
          ),
          searchButton(),
          SizedBox(
            height: 5,
          ),
          resultList(),
        ],
      ),
    );
  }

  List<Widget> listOfResults() {
    List<Widget> widgetList = [Divider()];

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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RouteDetailPage(
                          routeNumber: element['routeNumber'],
                        )),
              );
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
